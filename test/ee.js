const tape = require('tape')
const { main, decodeBlockData } = require('../dist/ee')
const { generateTestSuite } = require('../dist/relayer/lib')

tape('turboproof ee', async t => {
  const testSuite = await generateTestSuite()
  //const testSuite = fromScout('turboproof.yaml')
  // Only verifies multiproof, doesn't update trie
  const isValid = main({ preStateRoot: testSuite.preStateRoot, blockData: testSuite.blockData })
  t.true(isValid)
  t.end()
})

function fromScout(path) {
  const fs = require('fs')
  const yaml = require('js-yaml')
  const testCase = yaml.safeLoad(fs.readFileSync(path))

  return {
    preStateRoot: Buffer.from(testCase.shard_pre_state.exec_env_states[0], 'hex'),
    postStateRoot: Buffer.from(testCase.shard_post_state.exec_env_states[0], 'hex'),
    blockData: Buffer.from(testCase.shard_blocks[0].data, 'hex'),
  }
}
