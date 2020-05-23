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
import { Bytecode, Chunker, BasicBlockChunker, FixedSizeChunker } from '../src/relayer/bytecode'
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
    const chunker = new BasicBlockChunker()
    const blocks = chunker.getChunks(code)
    t.equal(blocks.length, 1, 'bytecode should have one block')
    t.equal(blocks[0].code.toString('hex'), codeHex)
    st.end()
  })

  t.test('two blocks separated by JUMPDEST', (st: tape.Test) => {
    const code = Buffer.from('60005b600000', 'hex')
    const chunker = new BasicBlockChunker()
    const blocks = chunker.getChunks(code)
    t.equal(blocks.length, 2, 'bytecode should have two block')
    t.equal(blocks[0].code.toString('hex'), '6000')
    t.equal(blocks[1].code.toString('hex'), '5b600000')
    st.end()
  })
})

tape('get evm fixed sized chunks', async t => {
  t.test('two full chunks', (st: tape.Test) => {
    const codeHex = '60006000600060006000600060006000600060006000600060006000600060005050600060006000600060006000600060006000600060006000600060006000'
    const code = Buffer.from(codeHex, 'hex')
    const chunker = new FixedSizeChunker()
    const chunks = chunker.getChunks(code)
    t.equal(chunks.length, 2, 'bytecode should have 2 chunks')
    console.log(chunks)
    t.equal(chunks[0].code.toString('hex'), '6000600060006000600060006000600060006000600060006000600060006000')
    t.equal(chunks[1].code.toString('hex'), '5050600060006000600060006000600060006000600060006000600060006000')
    st.end()
  })

  t.test('one and a half chunks', (st: tape.Test) => {
    const codeHex = '6000600060006000600060006000600060006000600060006000600060006000505060006000600060006000600060006000600060006000600060006000'
    const code = Buffer.from(codeHex, 'hex')
    const chunker = new FixedSizeChunker()
    const chunks = chunker.getChunks(code)
    t.equal(chunks.length, 2, 'bytecode should have 2 chunks')
    t.equal(chunks[0].code.toString('hex'), '6000600060006000600060006000600060006000600060006000600060006000')
    t.equal(chunks[1].code.toString('hex'), '505060006000600060006000600060006000600060006000600060006000')
    st.end()
  })

  t.test('one code chunk, one full data chunk', (st: tape.Test) => {
    const codeHex = '600060006000600060006000600060006000600060006000600060006000507f5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b'
    const code = Buffer.from(codeHex, 'hex')
    const chunker = new FixedSizeChunker()
    const chunks = chunker.getChunks(code)
    t.equal(chunks.length, 2, 'bytecode should have 2 chunks')
    t.equal(chunks[0].code.toString('hex'), '600060006000600060006000600060006000600060006000600060006000507f')
    t.equal(chunks[1].code.toString('hex'), '5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b')
    t.equal(chunks[0].firstCodeByte, 0)
    t.equal(chunks[1].firstCodeByte, 64)
    st.end()
  })

  t.test('one code chunk, one almost full data chunk', (st: tape.Test) => {
    const codeHex = '600060006000600060006000600060006000600060006000600060006000507e5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b'
    const code = Buffer.from(codeHex, 'hex')
    const chunker = new FixedSizeChunker()
    const chunks = chunker.getChunks(code)
    t.equal(chunks.length, 2, 'bytecode should have 2 chunks')
    t.equal(chunks[0].code.toString('hex'), '600060006000600060006000600060006000600060006000600060006000507e')
    t.equal(chunks[1].code.toString('hex'), '5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b')
    t.equal(chunks[0].firstCodeByte, 0)
    t.equal(chunks[1].firstCodeByte, 63)
    st.end()
  })

  t.test('one code chunk, one data byte in next chunk', (st: tape.Test) => {
    const codeHex = '60006000600060006000600060006000600060006000600060006000600050605b5b505050505050505050505050505050505050505050505050505050505050'
    const code = Buffer.from(codeHex, 'hex')
    const chunker = new FixedSizeChunker()
    const chunks = chunker.getChunks(code)
    t.equal(chunks.length, 2, 'bytecode should have 2 chunks')
    t.equal(chunks[0].code.toString('hex'), '6000600060006000600060006000600060006000600060006000600060005060')
    t.equal(chunks[1].code.toString('hex'), '5b5b505050505050505050505050505050505050505050505050505050505050')
    t.equal(chunks[0].firstCodeByte, 0)
    t.equal(chunks[1].firstCodeByte, 33)
    st.end()
  })

  t.test('one code chunk, one data byte in next 2 chunks', (st: tape.Test) => {
    const codeHex = '60006000600050605b5b6000600050605b5b6000'
    const code = Buffer.from(codeHex, 'hex')
    const chunker = new FixedSizeChunker(8)
    const chunks = chunker.getChunks(code)
    t.equal(chunks.length, 3, 'bytecode should have 3 chunks')
    t.equal(chunks[0].code.toString('hex'), '6000600060005060')
    t.equal(chunks[1].code.toString('hex'), '5b5b600060005060')
    t.equal(chunks[2].code.toString('hex'), '5b5b6000')
    t.equal(chunks[0].firstCodeByte, 0)
    t.equal(chunks[1].firstCodeByte, 9)
    t.equal(chunks[2].firstCodeByte, 17)
    st.end()
  })

  t.test('firstCodeByte shouldnt be overwritten', (st: tape.Test) => {
    const codeHex = '60006000600050635b5b5b5b635b5b5b5b5060006000'
    const code = Buffer.from(codeHex, 'hex')
    const chunker = new FixedSizeChunker(8)
    const chunks = chunker.getChunks(code)
    t.equal(chunks.length, 3, 'bytecode should have 3 chunks')
    t.equal(chunks[0].code.toString('hex'), '6000600060005063')
    t.equal(chunks[1].code.toString('hex'), '5b5b5b5b635b5b5b')
    t.equal(chunks[2].code.toString('hex'), '5b5060006000')
    t.equal(chunks[0].firstCodeByte, 0)
    t.equal(chunks[1].firstCodeByte, 12)
    t.equal(chunks[2].firstCodeByte, 17)
    st.end()
  })
})

tape('merkelize evm bytecode', async t => {
  t.test('merkelize basic code', async (st: tape.Test) => {
    const code = Buffer.from('60005b600000', 'hex')
    const chunker = new BasicBlockChunker()
    const bytecode = new Bytecode(code, chunker)
    const trie = await bytecode.merkelizeCode()
    const key = keccak256(Buffer.from('02', 'hex'))
    const p = await proveP(trie, key)
    const v = await verifyProofP(trie.root, key, p)
    st.equal(v.toString('hex'), '5b600000')
    st.end()
  })

  t.test('merkelize basic code with fixed size chunker', async (st: tape.Test) => {
    const code = Buffer.from('60006000600050635b5b5b5b635b5b5b5b5060006000', 'hex')
    const chunker = new FixedSizeChunker(8)
    const bytecode = new Bytecode(code, chunker)
    const trie = await bytecode.merkelizeCode()
    const key = keccak256(Buffer.from('08', 'hex'))
    const p = await proveP(trie, key)
    const v = await verifyProofP(trie.root, key, p)
    st.equal(v.toString('hex'), '045b5b5b5b635b5b5b')
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
        const traces: { [k: string]: CodeTrace } = {}
        //const { contracts, step } = codeTracer(state, MIN_BLOCK_LEN)
        const vm = new VM({ stateManager: state._wrapped })
        const chunker = new BasicBlockChunker(MIN_BLOCK_LEN)
        vm.on('step', codeTracer(state, traces, MIN_BLOCK_LEN, chunker))
        const res = await vm.runTx({ block, tx })
        st.deepEqual(state._wrapped._trie.root, hexToBuffer(c.postStateRoot))

        // Now that we've determined which blocks of
        // each contract have been touched, prepare proofs.
        const blockData = await getCodeProofs(traces, {})

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
    const traces:{ [k: string]: CodeTrace } = {}
    const createdContracts: { [k: string]: boolean } = {}
    let vm = new VM({ stateManager: state._wrapped, hardfork: 'istanbul' })
    // @ts-ignore
    vm.blockchain = blockchain!
    // Hook VM to track touched code blocks
    const chunker = new BasicBlockChunker(MIN_BLOCK_LEN)
    vm.on('step', codeTracer(state, traces, MIN_BLOCK_LEN, chunker ,false))
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
    const blockData = await getCodeProofs(traces, createdContracts)

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
      //vm.on('step', printRunState)
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

tape('merkelize realistic bytecode fixed size chunker', async (t: tape.Test) => {
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
    const traces:{ [k: string]: CodeTrace } = {}
    const createdContracts: { [k: string]: boolean } = {}
    let vm = new VM({ stateManager: state._wrapped, hardfork: 'istanbul' })
    // @ts-ignore
    vm.blockchain = blockchain!
    // Hook VM to track touched code blocks
    const chunker = new FixedSizeChunker(128)
    vm.on('step', codeTracer(state, traces, MIN_BLOCK_LEN, chunker, false))
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
    const blockData = await getCodeProofs(traces, createdContracts)

    let codeLengthSum = 0
    let proofLengthSum = 0
    let proofHashesSum = 0
    let proofLeavesSum = 0
    // The verifier checks proofs and assembles proven
    // blocks of code, simultaneously creating a skip list
    // for data bytes at the beginning of chunks.
    const skipList: any = {}
    for (const addr in blockData) {
      const contract = blockData[addr]
      const keys = contract.sortedAddrs.map((a: Buffer) => keccak256(a))
      t.assert(await verifyMultiproof(contract.codeRoot, contract.proof, keys), 'bytecode proof is valid')
      const blockIndices = contract.sortedAddrs.map((a: Buffer) => new BN(a).toNumber())
      const code = Buffer.alloc(contract.codeLength)
      const leaves = contract.proof.keyvals.map((kv: Buffer) => decode(kv))
      const toSkip = []
      for (let i = 0; i < leaves.length; i++) {
        const leaf = leaves[i]
        const skip = leaf[1].readUInt8(0)
        const chunk = leaf[1].slice(1)
        for (let j = 0; j < skip; j++) {
          toSkip.push(blockIndices[i] + j)
        }
        chunk.copy(code, blockIndices[i])
      }
      if (!blockPreState.preState['0x' + addr]) {
        continue
      }
      blockPreState.preState['0x' + addr].code = '0x' + code.toString('hex')
      skipList[addr] = toSkip

      // Gather data for statistics
      codeLengthSum += contract.codeLength
      proofLengthSum += encode(rawMultiproof(contract.proof, true)).length
      proofHashesSum += encode(contract.proof.hashes).length
      proofLeavesSum += encode(contract.proof.keyvals).length
    }
    for (const addr in createdContracts) {
      skipList[addr] = []
    }
    console.log(Object.keys(skipList))

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
      //vm.on('step', printRunState)
      const res = await vm.runTx({ block, tx, skipMap: skipList })
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
  fs.writeFileSync('code-saving-fixed-size.csv', csvOut)

  t.end()
})

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

/*function blockStats(code: Buffer, MIN_BLOCK_LEN: number): void {
  const bytecode = new Bytecode(code)
  const blocks = bytecode.getBasicBlocks(MIN_BLOCK_LEN)
  const blockLens = blocks.map((b: Buffer) => b.length)
  blockLens.sort()
  console.log('avg block length', ss.average(blockLens))
  console.log('blocklengths min: ', ss.min(blockLens), 'max', ss.max(blockLens), 'median', ss.median(blockLens), 'std dev', ss.standardDeviation(blockLens))
}*/

interface CodeTrace {
  bytecode: Bytecode
  touched: Set<number>
}

function codeTracer(state: any, traces: { [k: string]: CodeTrace }, MIN_BLOCK_LEN: number, chunker: Chunker, debug: boolean = false) {
  return async (runState: any) => {
    const newContractData = async (code: Buffer): Promise<CodeTrace> => {
      //const chunker = new BasicBlockChunker(MIN_BLOCK_LEN)
      //const chunker = new FixedSizeChunker(32)
      //console.log('before new bytecode', chunker, code)
      const bytecode = new Bytecode(code, chunker)
      return {
        bytecode,
        touched: new Set()
      }
    }

    if (debug) {
      printRunState(runState)
    }

    const addr = runState.codeAddress.toString('hex')
    let trace = traces[addr]
    if (!trace) {
      trace = traces[addr] = await newContractData(runState.code)
    }

    const chunk = trace.bytecode.pcChunk(runState.pc)
    if (!chunk) throw new Error('PC not in chunk')
    trace.touched.add(chunk.start)

    const sp = runState.stack.length - 1
    // We also need parts of code asked for by CODECOPY 
    if (runState.opcode.name === 'CODECOPY') {
      // Get code offset and length from stack
      const offset = runState.stack[sp - 1].toNumber()
      const len = runState.stack[sp - 2].toNumber()
      const chunks = trace.bytecode.chunkRange(offset, offset + len)
      for (const c of chunks) {
        trace.touched.add(c.start)
      }
    } else if (runState.opcode.name === 'EXTCODECOPY') {
      const extAddr = addressToBuffer(runState.stack[sp]).toString('hex')
      const offset = runState.stack[sp - 2].toNumber()
      const len = runState.stack[sp - 2].toNumber()
      if (!traces[extAddr]) {
        traces[extAddr] = await newContractData(await state.getContractCode(extAddr))
      }
      const extTrace = traces[extAddr]
      const chunks = trace.bytecode.chunkRange(offset, offset + len)
      for (const c of chunks) {
        trace.touched.add(c.start)
      }
    } else if (runState.opcode.name === 'EXTCODEHASH') {
      const extAddr = addressToBuffer(runState.stack[sp]).toString('hex')
      if (!traces[extAddr]) {
        traces[extAddr] = await newContractData(await state.getContractCode(extAddr))
      }
      const extTrace = traces[extAddr]
      // Verifier needs every block to compute correct hash
      for (const c of extTrace.bytecode.chunks) {
        extTrace.touched.add(c.start)
      }
    }
  }
}

function printRunState(runState: any) {
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

async function getCodeProofs(traces: { [k: string]: CodeTrace }, createdContracts: { [k: string]: boolean }) {
  const blockData: { [k: string]: any } = {}
  for (const addr of Object.keys(traces)) {
    if (createdContracts[addr]) {
      console.log('Ignoring created contract ', addr)
      continue
    }

    const trace = traces[addr]
    const bytecode = trace.bytecode
    const trie = await bytecode.merkelizeCode()
    const keyLength = new BN(bytecode.code.length - 1).byteLength()
    const addrs = []
    const touched: number[] = Array.from(trace.touched)
    console.log('-- Stats for ', addr)
    console.log('num of chunks: ', bytecode.chunks.length, ' num of touched blocks: ', touched.length)
    for (let bi of touched) {
      addrs.push(new BN(bi).toBuffer('be', keyLength))
    }
    const { proof, sortedAddrs } = await prepareProof(trie, addrs)
    blockData[addr] = {
      codeRoot: trie.root,
      proof,
      sortedAddrs,
      codeLength: bytecode.code.length // TODO: this is potentially attackable, encode length in trie somehow
    }

    // Statistics
    const encoded = encode(rawMultiproof(proof, true))
    console.log('code length: ', bytecode.code.length, 'proof length: ', encoded.length, 'space reduction(%): ', 1 - encoded.length / bytecode.code.length)
    const hashesEn = encode(proof.hashes)
    const leavesEn = encode(proof.keyvals)
    console.log('#hashes', proof.hashes.length, '#leaves', proof.keyvals.length)
    console.log('proof hashes len: ', hashesEn.length, 'keyvals len: ', leavesEn.length)
    //blockStats(contract.code, MIN_BLOCK_LEN)
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
