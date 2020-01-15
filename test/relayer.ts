import * as tape from 'tape'
import * as fs from 'fs'
import * as path from 'path'
import * as assert from 'assert'
import * as ss from 'simple-statistics'
import { keccak256, setLength } from 'ethereumjs-util'
import VM from 'ethereumjs-vm'
import { encode, decode } from 'rlp'
import { toBuffer } from 'ethereumjs-util'
import { rawMultiproof } from '../src/relayer/lib'
import { getBasicBlocks, getBasicBlockIndices, mergeBlocks, merkelizeCode } from '../src/relayer/bytecode'
import { getStateTest, parseTestCases, getPreState, makeTx, makeBlockFromEnv, format, hexToBuffer } from '../src/relayer/state-test'
import { Multiproof, makeMultiproof, verifyMultiproof } from '../src/multiproof'
import BN = require('bn.js')
const { promisify } = require('util')
const { prove, verifyProof } = require('merkle-patricia-tree/proof')
const Block = require('ethereumjs-block')
const ethjsUtil = require('ethjs-util')
const proveP = promisify(prove)
const verifyProofP = promisify(verifyProof)

tape('get evm basic blocks', async t => {
  t.test('add11 bytecode, one block', (st: tape.Test) => {
    const codeHex = '600160010160005500'
    const code = Buffer.from(codeHex, 'hex')
    const blocks = getBasicBlocks(code)
    t.equal(blocks.length, 1, 'bytecode should have one block')
    t.equal(blocks[0].toString('hex'), codeHex)
    st.end()
  })

  t.test('two blocks separated by JUMPDEST', (st: tape.Test) => {
    const code = Buffer.from('60005b600000', 'hex')
    const blocks = getBasicBlocks(code)
    t.equal(blocks.length, 2, 'bytecode should have two block')
    t.equal(blocks[0].toString('hex'), '6000')
    t.equal(blocks[1].toString('hex'), '5b600000')
    st.end()
  })
})

tape('merkelize evm bytecode', async t => {
  t.test('merkelize basic code', async (st: tape.Test) => {
    const code = Buffer.from('60005b600000', 'hex')
    const blocks = getBasicBlockIndices(code)
    const trie = await merkelizeCode(code)
    const key = keccak256(Buffer.from('02', 'hex'))
    const p = await proveP(trie, key)
    const v = await verifyProofP(trie.root, key, p)
    st.equal(v.toString('hex'), '5b600000')
    st.end()
  })
})

tape('state tests', async t => {
  const MIN_BLOCK_LEN = 128
  // ['multiOwnedAddOwner']
  const tests = await getStateTest('dayLimitSetDailyLimit')
  for (const tdata of tests) {
    t.test(tdata.testName, async st => {
      const cases = parseTestCases(tdata.test)

      for (const c of cases) {
        const tx = makeTx(c.transaction, 'petersburg')
        if (!tx.validate()) {
          console.log('invalid tx')
          continue
        }

        const block = makeBlockFromEnv(c.env)
        tx._homestead = true
        tx.enableHomestead = true
        block.isHomestead = () => true

        const state = await getPreState(c.pre)
        const contracts: any = {}
        //const { contracts, step } = codeTracer(state, MIN_BLOCK_LEN)
        const vm = new VM({ stateManager: state._wrapped })
        vm.on('step', codeTracer(state, contracts, MIN_BLOCK_LEN))
        const res = await vm.runTx({ block, tx })
        st.deepEqual(state._wrapped._trie.root, hexToBuffer(c.postStateRoot))

        // Now that we've determined which blocks of
        // each contract have been touched, prepare proofs.
        const blockData = await getCodeProofs(contracts, {}, MIN_BLOCK_LEN)

        // The verifier checks proofs and executes
        // blocks of bytecode
        for (const addr in blockData) {
          const contract = blockData[addr]
          const keys = contract.sortedAddrs.map((a: Buffer) => keccak256(a))
          st.assert(await verifyMultiproof(contract.codeRoot, contract.proof, keys), 'bytecode proof is valid')
          const blockIndices = contract.sortedAddrs.map((a: Buffer) => new BN(a).toNumber())
          const code = Buffer.alloc(contract.codeLength)
          const leaves = contract.proof.keyvals.map((kv: Buffer) => decode(kv))
          for (let i = 0; i < leaves.length; i++) {
            const leaf = leaves[i]
            leaf[1].copy(code, blockIndices[i])
          }
        }
      }

      st.end()
    })
  }

  t.end()
})

tape('merkelize realistic bytecode', async (t: tape.Test) => {
  const MIN_BLOCK_LEN = 128
  let data = JSON.parse(fs.readFileSync(path.join(__dirname, 'fixture/blocks-prestate.json'), 'utf8'))

  if (!Array.isArray(data)) data = [data]

  const stats = []
  for (const blockPreState of data) {
    const block = makeRealBlock(blockPreState.block)
    block.isHomestead = () => true

    // Mock blockchain for BLOCKHASH opcode
    const blockchain = {
      getBlock: (n: BN, cb: any) => {
        const bh = blockPreState.blockhashes['0x' + n.toString('hex')]
        if (!bh) {
          throw new Error('Unavailable blockhash requested')
        }
        return cb(null, { hash: () => toBuffer(bh) })
      }
    }

    let state = await getPreState(blockPreState.preState)
    const contracts: any = {}
    const createdContracts: { [k: string]: boolean } = {}
    let vm = new VM({ stateManager: state._wrapped, hardfork: 'istanbul' })
    // @ts-ignore
    vm.blockchain = blockchain!
    // Hook VM to track touched code blocks
    vm.on('step', codeTracer(state, contracts, MIN_BLOCK_LEN, false))
    vm.on('newContract', (e: any) => {
      createdContracts[e.address.toString('hex')] = true
    })

    t.comment('Executing and tracing transactions')
    for (const txIdx in blockPreState.block.transactions) {
      // Construct tx from data
      const txData = blockPreState.block.transactions[txIdx]
      const expectedReceipt = getTxReceipt(blockPreState.receipts[txIdx])
      const tx = makeTx(txData, 'istanbul')
      tx._homestead = true
      tx.enableHomestead = true

      t.assert(tx.validate())

      // Run tx and validate receipt
      let res = await vm.runTx({ block, tx })
      t.deepEqual(expectedReceipt.bloom, res.bloom.bitvector)
      t.assert(expectedReceipt.gasUsed.eq(res.gasUsed))
    }

    // Now that we've determined which blocks of
    // each contract have been touched, prepare proofs.
    const blockData = await getCodeProofs(contracts, createdContracts, MIN_BLOCK_LEN)

    let codeLengthSum = 0
    let proofLengthSum = 0
    let proofHashesSum = 0
    let proofLeavesSum = 0
    // The verifier checks proofs and assembles proven
    // blocks of code
    for (const addr in blockData) {
      const contract = blockData[addr]
      const keys = contract.sortedAddrs.map((a: Buffer) => keccak256(a))
      t.assert(await verifyMultiproof(contract.codeRoot, contract.proof, keys), 'bytecode proof is valid')
      const blockIndices = contract.sortedAddrs.map((a: Buffer) => new BN(a).toNumber())
      const code = Buffer.alloc(contract.codeLength)
      const leaves = contract.proof.keyvals.map((kv: Buffer) => decode(kv))
      for (let i = 0; i < leaves.length; i++) {
        const leaf = leaves[i]
        leaf[1].copy(code, blockIndices[i])
      }
      if (!blockPreState.preState['0x' + addr]) {
        continue
      }
      blockPreState.preState['0x' + addr].code = '0x' + code.toString('hex')

      // Gather data for statistics
      codeLengthSum += contract.codeLength
      proofLengthSum += encode(rawMultiproof(contract.proof, true)).length
      proofHashesSum += encode(contract.proof.hashes).length
      proofLeavesSum += encode(contract.proof.keyvals).length
    }

    const totalGasUsed = new BN(0)
    // Revert to pre state and replace contract codes
    // with codes constructed from the proofs
    state = await getPreState(blockPreState.preState)
    // Execute each tx with constructed code and validate
    // the receipts
    t.comment('Executing transactions with code constructed from chunks')
    for (const txIdx in blockPreState.block.transactions) {
      const txData = blockPreState.block.transactions[txIdx]
      const expectedReceipt = getTxReceipt(blockPreState.receipts[txIdx])
      const tx = makeTx(txData, 'istanbul')
      console.log('Executin tx', tx.hash())
      tx._homestead = true
      tx.enableHomestead = true

      vm = new VM({ stateManager: state._wrapped, hardfork: 'istanbul' })
      // @ts-ignore
      vm.blockchain = blockchain
      //vm.on('step', printTrace)
      const res = await vm.runTx({ block, tx })
      t.deepEqual(expectedReceipt.bloom, res.bloom.bitvector)
      t.assert(expectedReceipt.gasUsed.eq(res.gasUsed))
      totalGasUsed.iadd(res.gasUsed)
    }

    // TODO: Verify block header fields
    t.assert(totalGasUsed.eq(new BN(ethjsUtil.stripHexPrefix(blockPreState.block.gasUsed), 'hex')), 'block gasUsed should match')


    //console.log('> Sum of code lengths: ', codeLengthSum, 'Sum of proof lengths: ', proofLengthSum, 'Saving ratio: ', 1 - proofLengthSum / codeLengthSum)
    stats.push({
      blockNumber: new BN(block.header.number).toNumber(),
      codeLengthSum,
      proofLengthSum,
      proofHashesSum,
      proofLeavesSum
    })
  }

  let csvOut = 'blockNumber,codeLength,proofLength,proofHashes,proofLeaves\n'
  for (const bs of stats) {
    const line = [bs.blockNumber,bs.codeLengthSum, bs.proofLengthSum, bs.proofHashesSum, bs.proofLeavesSum]
    csvOut += line.join(',')
    csvOut += '\n'
  }
  fs.writeFileSync('code-saving.csv', csvOut)

  t.end()
})

function instructionInBlock(bi: any, pc: number): boolean {
  return pc >= bi[0] && pc < bi[1]
}

function blockOfInstruction(blockIndices: any, pc: number): any {
  for (const bi of blockIndices) {
    if (instructionInBlock(bi, pc)) {
      return bi
    }
  }
  console.log(pc, blockIndices[blockIndices.length - 1])
  throw new Error('Instruction not in any block')
}

function blockRange(blockIndices: any, start: number, end: number): any {
  const res = []
  const codeLength = blockIndices[blockIndices.length - 1][1]
  if (start >= codeLength) start = codeLength - 1
  if (end >= codeLength) end = codeLength - 1
  let startBlock
  let endBlock
  for (const i in blockIndices) {
    const bi = blockIndices[i]
    if (instructionInBlock(bi, start)) {
      startBlock = i
    }
  }
  if (!startBlock) throw new Error('No start in block range')
  for (const i in blockIndices) {
    const bi = blockIndices[i]
    if (instructionInBlock(bi, end)) {
      endBlock = i
    }
  }
  if (!endBlock) throw new Error('No end in block range')
  return blockIndices.slice(startBlock, endBlock + 1)
}

async function prepareProof(trie: any, addrs: Buffer[]): Promise<any> {
  // Make sure keys are unique and sort them
  const keys = addrs.map(a => keccak256(a))
  keys.sort(Buffer.compare)

  // Sort addresses based on their hashes.
  // Naive algorithm
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

  const proof = await makeMultiproof(trie, keys)

  // Verify proof is valid
  assert(verifyMultiproof(trie.root, proof, keys))

  return { proof, sortedAddrs }
}

function blockStats(code: Buffer, MIN_BLOCK_LEN: number): void {
  const blocks = getBasicBlocks(code, MIN_BLOCK_LEN)
  const blockLens = blocks.map((b: Buffer) => b.length)
  blockLens.sort()
  console.log('avg block length', ss.average(blockLens))
  console.log('blocklengths min: ', ss.min(blockLens), 'max', ss.max(blockLens), 'median', ss.median(blockLens), 'std dev', ss.standardDeviation(blockLens))
}

function codeTracer(state: any, contracts: any, MIN_BLOCK_LEN: number, debug: boolean = false) {
  return async (runState: any) => {
    const newContractData = async (code: Buffer) => {
      let blockIndices = getBasicBlockIndices(code)
      blockIndices = mergeBlocks(blockIndices, MIN_BLOCK_LEN)
      return {
        code,
        blockIndices: blockIndices,
        touched: new Set()
      }
    }

    if (debug) {
      printTrace(runState)
    }

    const addr = runState.codeAddress.toString('hex')
    if (!contracts[addr]) {
      contracts[addr] = await newContractData(runState.code)
    }

    const bi = blockOfInstruction(contracts[addr].blockIndices, runState.pc)
    contracts[addr].touched.add(bi[0])

    const sp = runState.stack.length - 1
    // We also need parts of code asked for by CODECOPY 
    if (runState.opcode.name === 'CODECOPY') {
      // Get code offset and length from stack
      let offset = runState.stack[sp - 1].toNumber()
      const len = runState.stack[sp - 2].toNumber()
      const blocks = blockRange(contracts[addr].blockIndices, offset, offset + len)
      for (const b of blocks) {
        contracts[addr].touched.add(b[0])
      }
    } else if (runState.opcode.name === 'EXTCODECOPY') {
      const extAddr = addressToBuffer(runState.stack[sp]).toString('hex')
      const offset = runState.stack[sp - 2].toNumber()
      const len = runState.stack[sp - 2].toNumber()
      if (!contracts[extAddr]) {
        contracts[extAddr] = await newContractData(await state.getContractCode(extAddr))
      }
      const blocks = blockRange(contracts[extAddr].blockIndices, offset, offset + len)
      for (const b of blocks) {
        contracts[extAddr].touched.add(b[0])
      }
    } else if (runState.opcode.name === 'EXTCODEHASH') {
      const extAddr = addressToBuffer(runState.stack[sp]).toString('hex')
      if (!contracts[extAddr]) {
        contracts[extAddr] = await newContractData(await state.getContractCode(extAddr))
      }
      // Verifier needs every block to compute correct hash
      for (const b of contracts[extAddr].blockIndices) {
        contracts[extAddr].touched.add(b[0])
      }
    }
  }
}

function printTrace(runState: any) {
  let hexStack = []
  hexStack = runState.stack.map((item: any) => {
    return '0x' + new BN(item).toString(16, 0)
  })

  let opTrace = {
    'pc': runState.pc,
    'op': runState.opcode.opcode,
    //'gas': '0x' + runState.gasLeft.toString('hex'),
    'gas': runState.gasLeft.toNumber(),
    'gasCost': '0x' + runState.opcode.fee.toString(16),
    'stack': hexStack,
    'depth': runState.depth,
    'opName': runState.opcode.name,
    'codeLen': runState.code.length,
  }
  console.log(JSON.stringify(opTrace))
}

async function getCodeProofs(contracts: any, createdContracts: { [k: string]: boolean }, MIN_BLOCK_LEN: number) {
  const blockData: { [k: string]: any } = {}
  for (const addr of Object.keys(contracts)) {
    if (createdContracts[addr]) {
      console.log('Ignoring created contract ', addr)
      continue
    }

    const contract = contracts[addr]
    const trie = await merkelizeCode(contract.code, MIN_BLOCK_LEN)
    const keyLength = new BN(contract.code.length - 1).byteLength()
    const addrs = []
    const touched: number[] = Array.from(contract.touched)
    console.log('-- Stats for ', addr)
    console.log('num of blocks: ', contract.blockIndices.length, ' num of touched blocks: ', touched.length)
    for (let bi of touched) {
      addrs.push(new BN(bi).toBuffer('be', keyLength))
    }
    const { proof, sortedAddrs } = await prepareProof(trie, addrs)
    blockData[addr] = {
      codeRoot: trie.root,
      proof,
      sortedAddrs,
      codeLength: contract.code.length // TODO: this is potentially attackable, encode length in trie somehow
    }

    // Statistics
    const encoded = encode(rawMultiproof(proof, true))
    console.log('code length: ', contract.code.length, 'proof length: ', encoded.length, 'space reduction(%): ', 1 - encoded.length / contract.code.length)
    const hashesEn = encode(proof.hashes)
    const leavesEn = encode(proof.keyvals)
    console.log('#hashes', proof.hashes.length, '#leaves', proof.keyvals.length)
    console.log('proof hashes len: ', hashesEn.length, 'keyvals len: ', leavesEn.length)
    blockStats(contract.code, MIN_BLOCK_LEN)
  }
  return blockData
}

function makeRealBlock(data: any): any {
  return new Block({
    header: {
      timestamp: format(data.timestamp),
      gasLimit: format(data.gasLimit),
      parentHash: format(data.parentHash, false, true),
      coinbase: setLength(format(data.miner, false, true), 20),
      difficulty: format(data.difficulty),
      number: format(data.number)
    },
    transactions: {},
    uncleHeaders: []
  })
}

function getTxReceipt(data: any): any {
  return {
    gasUsed: new BN(ethjsUtil.stripHexPrefix(data.gasUsed), 16),
    bloom: Buffer.from(ethjsUtil.stripHexPrefix(data.logsBloom), 'hex'),
  }
}

const MASK_160 = new BN(1).shln(160).subn(1)
function addressToBuffer(address: BN) {
  return address.and(MASK_160).toArrayLike(Buffer, 'be', 20)
}
