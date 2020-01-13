import * as fs from 'fs'
import * as path from 'path'
import { encode } from 'rlp'
import { Multiproof } from '../multiproof'
import {
  TestSuite,
  getTestsAccounts,
  transfer,
  rawMultiproof,
  SimulationData,
  getTestsTxes,
} from './lib'
const Trie = require('merkle-patricia-tree/secure')

export async function basicEvmTestSuite(p: string = 'fixture/add.json'): Promise<TestSuite> {
  const trie = new Trie()

  const test = JSON.parse(fs.readFileSync(path.join(__dirname, p), 'utf-8'))
  const [accounts, codeHashes, bytecode] = await getTestsAccounts(trie, test)

  const preStateRoot = trie.root
  const [txes, addrs, multiproof, simulationData] = await getTestsTxes(trie, accounts, test)
  const returnValue = Buffer.from(test.returnValue.slice(2), 'hex')

  // Serialize witnesses and tx data
  const blockData = encode([
    txes,
    addrs,
    ...rawMultiproof(multiproof as Multiproof, true),
    codeHashes,
    bytecode,
    returnValue,
  ])

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
