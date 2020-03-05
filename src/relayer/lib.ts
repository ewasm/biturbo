import BN = require('bn.js')
import Account from 'ethereumjs-account'
import { keccak256, ecsign, stripZeros } from 'ethereumjs-util'
import { encode, decode } from 'rlp'
import { Multiproof, verifyMultiproof, makeMultiproof, flatEncodeInstructions } from '../multiproof'
import VM from 'ethereumjs-vm'
import { Transaction } from 'ethereumjs-tx'
import { getOpcodesForHF } from 'ethereumjs-vm/dist/evm/opcodes'
import Common from 'ethereumjs-common'

const assert = require('assert')
const { promisify } = require('util')
const Wallet = require('ethereumjs-wallet')
const Trie = require('merkle-patricia-tree/secure')

export interface TestSuite {
  preStateRoot: Buffer
  blockData: Buffer
  postStateRoot: Buffer
}

export interface RunnerArgs {
  stateless: boolean
  fork: string
  test: string
  scout: string
  dist: string
  forkConfig: string
  jsontrace: boolean
  debug: boolean
  data: string
  gasLimit: number
  value: number
}

export interface TestGetterArgs {
  test: string
}

export interface SimulationData {
  from: Buffer
  to: Buffer
  value: BN
  nonce: BN
}

export interface AccountInfo {
  address: Buffer
  privateKey: Buffer
  account: Account
}

export async function generateTestSuite(): Promise<TestSuite> {
  const trie = new Trie()
  // Generate random accounts
  const accounts = await generateAccounts(trie, 5000)

  const preStateRoot = trie.root

  // Generate txes
  const [txes, addrs, multiproof, simulationData] = await generateTxes(trie, accounts, 70)

  // Serialize witnesses and tx data
  const blockData = encode([txes, addrs, ...rawMultiproof(multiproof as Multiproof, true)])

  // Apply txes on top of trie to compute post state root
  for (const tx of simulationData as SimulationData[]) {
    await transfer(trie, tx)
  }

  return {
    preStateRoot,
    blockData,
    postStateRoot: trie.root,
  }
}

async function generateTxes(trie: any, accounts: AccountInfo[], count = 50) {
  const txes = []
  const simulationData = []
  const root = trie.root
  const toProve: any = {}
  for (let i = 0; i < count; i++) {
    const from = accounts[i].address
    const to = accounts[i + 1].address
    const value = new BN('00000000000000000000000000000000000000000000000000000000000000ff', 16)
    const nonce = new BN('0000000000000000000000000000000000000000000000000000000000000000', 16)
    simulationData.push({ from, to, value, nonce })

    const fromKey = from.toString('hex')
    if (!toProve[fromKey]) {
      toProve[fromKey] = []
    }
    toProve[fromKey].push({ txId: i, fieldIdx: 3 })

    const toKey = to.toString('hex')
    if (!toProve[toKey]) {
      toProve[toKey] = []
    }
    toProve[toKey].push({ txId: i, fieldIdx: 0 })

    const txRlp = encode([
      to,
      stripZeros(value.toBuffer('be', 32)),
      stripZeros(nonce.toBuffer('be', 32)),
    ])
    const txHash = keccak256(txRlp)
    const txSig = ecsign(txHash, accounts[i].privateKey)
    assert(txSig.r.byteLength === 32)
    assert(txSig.s.byteLength === 32)
    assert(txSig.v < 256)

    txes.push([
      to,
      stripZeros(value.toBuffer('be', 32)),
      stripZeros(nonce.toBuffer('be', 32)),
      from,
    ])
  }
  // Make sure keys are unique and sort them
  const unsortedAddrs = Object.keys(toProve).map(s => Buffer.from(s, 'hex'))
  const keys = unsortedAddrs.map(a => keccak256(a))
  keys.sort(Buffer.compare)
  const sortedAddrs = sortAddrsByHash(unsortedAddrs)

  const proof = await makeMultiproof(trie, keys)
  // Verify proof is valid
  assert(verifyMultiproof(root, proof, keys))

  // Modify txes and replace from and to addresses
  // with their index in the keys array
  for (let i = 0; i < sortedAddrs.length; i++) {
    const addr = sortedAddrs[i]
    const addrData = toProve[addr.toString('hex')]
    for (const instance of addrData) {
      txes[instance.txId][instance.fieldIdx] = i
    }
  }

  return [txes, sortedAddrs, proof, simulationData]
}

export async function transfer(trie: any, tx: SimulationData) {
  const { from, to, value, nonce } = tx
  assert(value.gten(0))

  const fromAcc = await getAccount(trie, from)
  const toAcc = await getAccount(trie, to)

  assert(new BN(fromAcc.balance).gte(value))
  assert(new BN(fromAcc.nonce).eq(nonce))

  const newFromBalance = new BN(fromAcc.balance).sub(value)
  fromAcc.balance = newFromBalance.toBuffer()
  fromAcc.nonce = nonce.addn(1).toBuffer()
  const newToBalance = new BN(toAcc.balance).add(value)
  toAcc.balance = newToBalance.toBuffer()

  await putAccount(trie, from, fromAcc)
  await putAccount(trie, to, toAcc)
}

// Sort addresses based on their hashes.
// Naive algorithm
export function sortAddrsByHash(addrs: Buffer[]): Buffer[] {
  const keys = addrs.map((a: Buffer) => keccak256(a))
  keys.sort(Buffer.compare)
  const sortedAddrs = new Array(keys.length).fill(undefined)

  for (const a of addrs) {
    let idx = -1
    const h = keccak256(a)
    for (let i = 0; i < keys.length; i++) {
      const k = keys[i]
      if (h.equals(k)) {
        idx = i
      }
    }
    assert(idx >= 0)
    sortedAddrs[idx] = a
  }

  return sortedAddrs
}

export async function generateAccounts(trie: any, count = 500): Promise<AccountInfo[]> {
  const accounts = []
  for (let i = 0; i < count; i++) {
    const wallet = Wallet.generate()
    const address = wallet.getAddress()
    const privateKey = wallet.getPrivateKey()
    const account = new Account()
    account.balance = new BN('ffffff', 16).toBuffer()
    accounts.push({
      address,
      privateKey,
      account,
    })
    await putAccount(trie, address, account)
  }
  return accounts
}

export async function stateTestRunner(runnerArgs: RunnerArgs, test: any): Promise<TestSuite> {
  const trie = new Trie()

  const [accounts, codeHashes, bytecode] = await getTestsAccounts(trie, test)

  const preStateRoot = trie.root
  const [txes, addrs, multiproof, simulationData, pks] = await getTestsTxes(trie, accounts, test)

  const blockData = encode([
    txes,
    addrs,
    ...rawMultiproof(multiproof as Multiproof, true),
    codeHashes,
    bytecode,
  ])

  // Execute txes on top of trie to compute post state root
  let i = 0
  for (const tx of simulationData as SimulationData[]) {
    const pk = (pks as Buffer[])[0]
    await execute(runnerArgs, trie, tx, pk)
    i = i + 1
  }

  return {
    preStateRoot,
    blockData,
    postStateRoot: trie.root,
  }
}

export async function getTestsTxes(trie: any, accounts: AccountInfo[], test: any) {
  const txes = []
  const pks = []
  const simulationData = []
  const root = trie.root
  const toProve: any = {}

  const from = accounts[1].address
  const to = accounts[0].address

  const value = new BN(test.transaction.value[0].substring(2), 16)
  const nonce = new BN(test.pre['0x' + from.toString('hex')].nonce.substring(2), 16)

  simulationData.push({ from, to, value, nonce })

  const fromKey = from.toString('hex')

  if (!toProve[fromKey]) {
    toProve[fromKey] = []
  }
  toProve[fromKey].push({ txId: 0, fieldIdx: 3 })

  const toKey = to.toString('hex')

  if (!toProve[toKey]) {
    toProve[toKey] = []
  }

  toProve[toKey].push({ txId: 0, fieldIdx: 0 })

  txes.push([to, stripZeros(value.toBuffer('be', 32)), stripZeros(nonce.toBuffer('be', 32)), from])

  pks.push(accounts[1].privateKey)

  // Make sure keys are unique and sort them
  const unsortedAddrs = Object.keys(toProve).map(s => Buffer.from(s, 'hex'))
  const keys = unsortedAddrs.map(a => keccak256(a))
  keys.sort(Buffer.compare)
  const sortedAddrs = sortAddrsByHash(unsortedAddrs)

  const proof = await makeMultiproof(trie, keys)

  // Verify proof is valid
  assert(verifyMultiproof(root, proof, keys))

  // Modify txes and replace from and to addresses
  // with their index in the keys array
  for (let i = 0; i < sortedAddrs.length; i++) {
    const addr = sortedAddrs[i]
    const addrData = toProve[addr.toString('hex')]
    for (const instance of addrData) {
      txes[instance.txId][instance.fieldIdx] = i
    }
  }

  return [txes, sortedAddrs, proof, simulationData, pks]
}

async function execute(options: any, trie: any, tx: SimulationData, pk: any) {
  const rawTx = {
    nonce: '0x' + tx.nonce.toString('hex'),
    gasLimit: '0x61a80',
    gasPrice: '0x1',
    value: '0x' + tx.value.toString('hex'),
    from: '0x' + tx.from.toString('hex'),
    to: '0x' + tx.to.toString('hex'),
  }

  const vm = new VM({
    state: trie,
    hardfork: options.forkConfig.toLowerCase(),
  })

  await runTx(vm, rawTx, pk)
}

async function runTx(vm: any, rawTx: any, pk: any) {
  const tx = new Transaction(rawTx)
  tx.sign(pk)

  const results = await vm.runTx({
    tx: tx,
  })

  return results
}

export async function getTestsAccounts(
  trie: any,
  test: any,
): Promise<[AccountInfo[], Buffer[], Buffer[]]> {
  const accounts: AccountInfo[] = []
  const codeHashes: Buffer[] = []
  const bytecode: Buffer[] = []
  const privateKey = test.transaction.secretKey

  for (const address in test.pre) {
    const acct = test.pre[address]
    const code = Buffer.from(acct.code.substring(2), 'hex')
    const codeHash = keccak256(code)

    const acct_data = {
      nonce: acct.nonce,
      balance: acct.balance,
      codeHash: codeHash,
    }

    const account = new Account(acct_data)

    const addr_buf = Buffer.from(address.substring(2), 'hex')
    accounts.push({
      address: addr_buf,
      privateKey: Buffer.from(privateKey.substring(2), 'hex'),
      account: account,
    })

    await putAccount(trie, addr_buf, account)

    await new Promise((resolve, reject) => {
      account.setCode(trie, code, (err: any, codeHash: Buffer) => {
        if (err) {
          return reject(err)
        }
        codeHashes.push(codeHash)
        bytecode.push(code)
        resolve(codeHash)
      })
    })
  }

  return [accounts, codeHashes, bytecode]
}

async function putAccount(trie: any, address: Buffer, account: Account) {
  await promisify(trie.put.bind(trie))(address, account.serialize())
}

async function getAccount(trie: any, address: Buffer): Promise<Account> {
  const raw = await promisify(trie.get.bind(trie))(address)
  if (!raw) {
    return new Account()
  } else {
    return new Account(raw)
  }
}

export function rawMultiproof(proof: Multiproof, flatInstructions: boolean = false): any {
  const keys = []
  const values = []
  for (const kv of proof.keyvals) {
    const raw = decode(kv)
    keys.push(raw[0])
    values.push(raw[1])
  }
  if (flatInstructions) {
    return [proof.hashes, keys, values, flatEncodeInstructions(proof.instructions)]
  } else {
    return [
      proof.hashes,
      keys,
      values,
      proof.instructions.map(i => {
        if (i.value !== undefined) return [i.kind, i.value]
        return [i.kind]
      }),
    ]
  }
}

export function getBasicBlockIndices(code: Buffer): number[][] {
  const TERMINATING_OPS = ['JUMP', 'JUMPI', 'STOP', 'RETURN', 'REVERT', 'SELFDESTRUCT']
  const opcodes = getOpcodesForHF(new Common('mainnet', 'istanbul'))
  const getOp = (i: number) => (opcodes[code[i]] ? opcodes[code[i]].name : 'INVALID')

  // [start, end) indices
  const blocks = [[0, -1]]
  for (let i = 0; i < code.length; i++) {
    const op = getOp(i)
    // Skip push args
    if (op === 'PUSH') {
      i += code[i] - 0x5f
    }

    // Current instruction terminates block or next instruction is JUMPDEST
    if (TERMINATING_OPS.includes(op) || (i + 1 < code.length && getOp(i + 1) === 'JUMPDEST')) {
      blocks[blocks.length - 1][1] = i + 1
      // Create new block if not at end of code
      if (i + 1 < code.length) {
        blocks.push([i + 1, -1])
      }
    }
  }

  // Close block if no terminating instruction at the end
  if (blocks[blocks.length - 1][1] === undefined) {
    blocks[blocks.length - 1][1] = code.length
  }

  return blocks
}

/**
 * Does a single pass over bytecode to find the list
 * of all basic blocks (i.e. blocks of code with no
 * control flow change).
 */
export function getBasicBlocks(code: Buffer): Buffer[] {
  const blocks = getBasicBlockIndices(code)
  // Slice code based on block indices
  return blocks.map((b: number[]) => code.slice(b[0], b[1]))
}

/**
 * Divides code into basic blocks and constructs a MPT
 * with these blocks as leaves. The key for each block is
 * the index of the first byte of that block in the bytecode.
 */
export async function merkelizeCode(code: Buffer): Promise<any> {
  const blockIndices = getBasicBlockIndices(code)
  const trie = new Trie()
  const putP = promisify(trie.put.bind(trie))
  // Keys are indices into the bytecode. Determine key length by
  // how large the last index is.
  const keyLength = new BN(code.length - 1).byteLength()
  for (let i = 0; i < blockIndices.length; i++) {
    const key = new BN(blockIndices[i][0]).toBuffer('be', keyLength)
    const val = code.slice(blockIndices[i][0], blockIndices[i][1])
    await putP(key, val)
  }
  return trie
}
