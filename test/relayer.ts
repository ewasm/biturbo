import * as tape from 'tape'
import { getBasicBlocks, getBasicBlockIndices, merkelizeCode } from '../src/relayer/lib'
import { keccak256 } from 'ethereumjs-util'
const { promisify } = require('util')
const { prove, verifyProof } = require('merkle-patricia-tree/proof')
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
