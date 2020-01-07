import * as tape from 'tape'
import * as fs from 'fs'
import * as path from 'path'
import { keccak256 } from 'ethereumjs-util'
import { verifyMultiproof } from '../src/multiproof'
import {
  AccountData,
  accountDataFromJSON,
  turboproofFromAccountData,
  toBuffer,
  generateRealisticTestSuite,
} from '../src/relayer/realistic'
import { main } from '../src/ee'
const Trie = require('merkle-patricia-tree/secure')

tape('turboproof from rpc data', async t => {
  const testCase = JSON.parse(
    fs.readFileSync(path.join(__dirname, 'fixture/eth_getProof_sample.json'), { encoding: 'utf8' }),
  )
  const accData = []
  const preStateRoot = toBuffer(testCase.preStateRoot)
  for (const acc of testCase.accounts) {
    accData.push(accountDataFromJSON(acc.result))
  }
  const trie = new Trie()
  trie.root = preStateRoot
  const p = await turboproofFromAccountData(trie, accData)

  const keys = accData.map((a: AccountData) => keccak256(a.address))
  keys.sort(Buffer.compare)
  t.true(await verifyMultiproof(preStateRoot, p, keys))

  t.end()
})

tape('run ee with rpc data', async t => {
  const testCase = JSON.parse(
    fs.readFileSync(path.join(__dirname, 'fixture/eth_getProof_sample.json'), { encoding: 'utf8' }),
  )
  const testSuite = await generateRealisticTestSuite(testCase)
  // Only verifies multiproof, doesn't update trie
  const isValid = main({ preStateRoot: testSuite.preStateRoot, blockData: testSuite.blockData })
  t.true(isValid)
  t.end()
})
