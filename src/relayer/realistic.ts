import BN = require('bn.js')
import * as assert from 'assert'
import Account from 'ethereumjs-account'
import { keccak256, stripZeros } from 'ethereumjs-util'
import { encode } from 'rlp'
import { Multiproof, makeMultiproof, verifyMultiproof } from '../multiproof'
import { TestSuite, sortAddrsByHash, rawMultiproof, SimulationData, transfer, getAccount } from './lib'
const { promisify } = require('util')
const Trie = require('merkle-patricia-tree/secure')

export interface AccountData {
  address: Buffer
  accountProof: Buffer[]
  nonce: BN
  balance: BN
  codeHash: Buffer
  storageHash: Buffer
  storageProof: Buffer[]
}

export interface TransactionData {
  to: Buffer
  value: BN
  nonce: BN
  from: Buffer
}

export async function generateRealisticTestSuite(data: any): Promise<TestSuite> {
  const trie = new Trie()
  const preStateRoot = toBuffer(data.preStateRoot)
  trie.root = preStateRoot

  const accData = []
  const addrs = []
  for (const acc of data.accounts) {
    accData.push(accountDataFromJSON(acc.result))
    addrs.push(accData[accData.length-1].address)
  }

  const multiproof = await turboproofFromAccountData(trie, accData)

  const sortedAddrs = sortAddrsByHash(addrs)
  const txes = []
  const simulationData = []
  for (const rawTx of data.transactions) {
    const txData = transactionDataFromJSON(rawTx.result)
    simulationData.push({
      to: txData.to,
      value: txData.value,
      nonce: txData.nonce,
      from: txData.from
    })
    const toIdx = sortedAddrs.findIndex((a: Buffer) => a.equals(txData.to))
    const fromIdx = sortedAddrs.findIndex((a: Buffer) => a.equals(txData.from))
    if (toIdx === -1 || fromIdx === -1) {
      throw new Error('Invalid transaction sender/recipient')
    }
    txes.push([toIdx, stripZeros(txData.value.toBuffer('be', 32)), stripZeros(txData.nonce.toBuffer('be', 32)), fromIdx])
  }

  const blockData = encode([txes, sortedAddrs, ...rawMultiproof(multiproof as Multiproof, true)])

  // Apply txes on top of trie to compute post state root
  for (const tx of simulationData as SimulationData[]) {
    await transfer(trie, tx)
  }

  return {
    preStateRoot,
    blockData,
    postStateRoot: trie.root
  }
}

export async function turboproofFromAccountData(trie: any, data: AccountData[]): Promise<Multiproof> {
  const putRaw = promisify(trie._putRaw.bind(trie))
  const addrs = []
  for (const accountData of data) {
    addrs.push(accountData.address)
    for (const node of accountData.accountProof) {
      await putRaw(keccak256(node), node)
    }
  }
  const keys = addrs.map((a: Buffer) => keccak256(a))
  keys.sort(Buffer.compare)

  return makeMultiproof(trie, keys)
}

export function accountDataFromJSON(data: any): AccountData {
  return {
    address: toBuffer(data.address),
    accountProof: data.accountProof.map((n: string) => toBuffer(n)),
    nonce: toBN(data.nonce),
    balance: toBN(data.balance),
    codeHash: toBuffer(data.codeHash),
    storageHash: toBuffer(data.storageHash),
    storageProof: data.storageProof.map((n: string) => toBuffer(n))
  }
}

export function transactionDataFromJSON(data: any): TransactionData {
  return {
    to: toBuffer(data.to),
    value: toBN(data.value),
    nonce: toBN(data.nonce),
    from: toBuffer(data.from)
  }
}

export function toBuffer(str: string): Buffer {
  return Buffer.from(str.slice(2), 'hex')
}

function toBN(str: string): BN {
  return new BN(str.slice(2), 16)
}
