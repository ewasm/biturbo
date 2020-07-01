import { Transaction } from 'ethereumjs-tx'
import { toBuffer, setLength } from 'ethereumjs-util'
import Account from 'ethereumjs-account'
import { encode } from 'rlp'
import StateManager from 'ethereumjs-vm/dist/state/stateManager'
import PStateManager from 'ethereumjs-vm/dist/state/promisified'
import BN = require('bn.js')

const Block = require('ethereumjs-block')
const testing = require('ethereumjs-testing')
const ethjsUtil = require('ethjs-util')
const { promisify } = require('util')

export interface StateTest {
  _info: any
  env: StateTestEnv
  post: {[k: string]: StateTestPost[]}
  pre: {[k: string]: StateTestPreAccount}
  transaction: StateTestTransaction
}

export interface StateTestEnv {
  currentCoinbase: string
  currentDifficulty: string
  currentGasLimit: string
  currentNumber: string
  currentTimestamp: string
  previousHash: string
}

export interface StateTestPost {
  hash: string
  indexes: any
  logs: string
}

export interface StateTestPreAccount {
  balance: string
  code: string
  nonce: string
  storage: {[k: string]: string}
}

export interface StateTestTransaction {
  data: string[]
  gasLimit: string[]
  gasPrice: string
  nonce: string
  secretKey: string
  to: string
  value: string[]
}

export interface Block {
  coinbase: Buffer
  difficulty: BN
  gasLimit: BN
  number: BN
  timestamp: BN
}

export interface TestCase {
  fileName: string
  testName: string
  test: any
}

export async function getStateTest(name: string): Promise<TestCase[]> {
  let tests: TestCase[] = []
  await testing
    .getTestsFromArgs(
      'GeneralStateTests',
      async (fileName: string, testName: string, t: any) => {
        tests.push({ fileName, testName, test: t })
      },
      { test: name },
    )
  return tests
}

export function parseTestCases (testData: StateTest) {
  let testCases: any[] = []
  if (testData['post']['ConstantinopleFix']) {
    testCases = testData['post']['ConstantinopleFix'].map((testCase: any) => {
      let testIndexes = testCase['indexes']
      let tx: any = Object.assign({}, testData.transaction)
      tx.data = testData.transaction.data[testIndexes['data']]
      tx.gasLimit = testData.transaction.gasLimit[testIndexes['gas']]
      tx.value = testData.transaction.value[testIndexes['value']]
      return {
        'transaction': tx,
        'postStateRoot': testCase['hash'],
        'env': testData['env'],
        'pre': testData['pre']
      }
    })
  }

  testCases = testCases.filter((testCase: any) => {
    return testCase != null
  })

  return testCases
}

export async function getPreState(pre: {[k: string]: StateTestPreAccount}): Promise<PStateManager> {
  const state = new StateManager()
  const pstate = new PStateManager(state)
  for (const k in pre) {
    const kBuf = toBuffer(k)
    const obj = pre[k]
    const code = toBuffer(obj.code)
    const acc = new Account()
    acc.nonce = hexToBuffer(obj.nonce)
    acc.balance = hexToBuffer(obj.balance)
    const storageTrie = state._trie.copy()
    storageTrie.root = null
    for (const sk in obj.storage) {
      const sv = obj.storage[sk]
      const valBN = new BN(sv.slice(2), 16)
      if (valBN.isZero()) continue
      const val = encode(valBN.toBuffer('be'))
      const key = setLength(Buffer.from(sk.slice(2), 'hex'), 32)
      await promisify(storageTrie.put.bind(storageTrie))(key, val)
    }
    acc.stateRoot = storageTrie.root
    await pstate.putAccount(
      kBuf,
      acc
    )
    await pstate.putContractCode(kBuf, code)
  }
  return pstate
}

export const makeTx = (txData: any, hf: string): any => {
  const tx = new Transaction({}, { hardfork: hf })
  tx.nonce = format(txData.nonce)
  tx.gasPrice = format(txData.gasPrice)
  tx.gasLimit = format(txData.gasLimit || txData.gas)
  tx.to = txData.to ? format(txData.to, true, true) : Buffer.alloc(0)
  tx.value = format(txData.value)
  tx.data = format(txData.data || txData.input, false, true) // slice off 0x
  if (txData.secretKey) {
    var privKey = format(txData.secretKey, false, true)
    tx.sign(privKey)
  } else {
    tx.v = Buffer.from(ethjsUtil.padToEven(txData.v.slice(2)), 'hex')
    tx.r = Buffer.from(ethjsUtil.padToEven(txData.r.slice(2)), 'hex')
    tx.s = Buffer.from(ethjsUtil.padToEven(txData.s.slice(2)), 'hex')
  }
  return tx
}

export function makeBlockHeader(data: any): any {
  var header: any = {}
  header.timestamp = format(data.currentTimestamp)
  header.gasLimit = format(data.currentGasLimit)
  if (data.previousHash) {
    header.parentHash = format(data.previousHash, false, true)
  }
  header.coinbase = setLength(format(data.currentCoinbase, false, true), 20)
  header.difficulty = format(data.currentDifficulty)
  header.number = format(data.currentNumber)
  return header
}

/**
 * makeBlockFromEnv - helper to create a block from the env object in tests repo
 * @param {Object} env object from tests repo
 * @param {Object} transactions transactions for the block
 * @returns {Object} the block
 */
export function makeBlockFromEnv(env: any, transactions?: any): any {
  return new Block({
    header: exports.makeBlockHeader(env),
    transactions: transactions || {},
    uncleHeaders: []
  })
}

export const makeBlock = (data: any): Block => {
  return {
    coinbase: toBuffer(data.currentCoinbase),
    difficulty: new BN(ethjsUtil.stripHexPrefix(data.currentDifficulty), 16),
    gasLimit: new BN(ethjsUtil.stripHexPrefix(data.currentGasLimit), 16),
    number: new BN(ethjsUtil.stripHexPrefix(data.currentNumber), 16),
    timestamp: new BN(ethjsUtil.stripHexPrefix(data.currentTimestamp), 16)
  }
}

export const format = (a: any, toZero: boolean = false, isHex: boolean = false) => {
  if (a === '') {
    return Buffer.alloc(0)
  }

  if (a.slice && a.slice(0, 2) === '0x') {
    a = a.slice(2)
    if (a.length % 2) a = '0' + a
    a = Buffer.from(a, 'hex')
  } else if (!isHex) {
    a = Buffer.from(new BN(a).toArray())
  } else {
    if (a.length % 2) a = '0' + a
    a = Buffer.from(a, 'hex')
  }

  if (toZero && a.toString('hex') === '') {
    a = Buffer.from([0])
  }

  return a
}

export const hexToBN = (n: string): BN => {
  return new BN(ethjsUtil.stripHexPrefix(n), 16)
}

export const hexToBuffer = (h: string, allowZero: boolean = false): Buffer => {
  const buf = toBuffer(h)
  if (!allowZero && buf.toString('hex') === '00') {
    return Buffer.alloc(0)
  }
  return buf
}

export function getTestCases (path: string): Promise<TestCase[]> {
  return new Promise((resolve, reject) => {
    const cases: TestCase[] = []
    require('ethereumjs-testing').getTestsFromArgs(path, (fileName: string, testName: string, test: any) => {
      cases.push({ fileName, testName, test })
      return new Promise((resolve, reject) => resolve())
    }).then(() => {
      return resolve(cases)
    }).catch((err: Error) => reject(err))
  })
}
