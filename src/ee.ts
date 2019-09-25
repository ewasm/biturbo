import * as assert from 'assert'
import BN = require('bn.js')
import { keccak256 } from 'ethereumjs-util'
import { encode, decode } from 'rlp'
import { verifyMultiproof, decodeInstructions, flatDecodeInstructions } from './multiproof'

interface TestSuite {
  preStateRoot: Buffer
  blockData: Buffer
}

// TODO
interface BlockData {}

interface Account {
  nonce: BN
  balance: BN
  stateRoot: Buffer
  codeHash: Buffer
}

interface Tx {
  toIdx: number
  value: BN
  nonce: BN
  fromIdx: number
}

export function decodeBlockData(blockData: Buffer): any {
  const d = decode(blockData)
  return {
    txes: d[0],
    addrs: d[1],
    multiproof: {
      // @ts-ignore
      hashes: d[2],
      // @ts-ignore
      keyvals: d[3],
      // @ts-ignore
      instructions: flatDecodeInstructions(d[4]),
    },
  }
}

function decodeTx(raw: Buffer[]): Tx {
  // TODO: How many addresses possible? is u8 enough for indices?
  return {
    toIdx: bufToU8(raw[0]),
    value: new BN(raw[1]),
    nonce: new BN(raw[2]),
    fromIdx: bufToU8(raw[3]),
  }
}

function bufToU8(b: Buffer): number {
  // RLP decoding of 0 is empty buffer
  if (b.length === 0) {
    return 0
  }
  return b.readUInt8(0)
}

function decodeAccount(raw: Buffer): Account {
  const d = decode(raw)
  // @ts-ignore
  return { nonce: new BN(d[0]), balance: new BN(d[1]), stateRoot: d[2], codeHash: d[3] }
}

function encodeAccount(acc: Account): Buffer {
  return encode([
    acc.nonce.toArrayLike(Buffer, 'be'),
    acc.balance.toArrayLike(Buffer, 'be'),
    acc.stateRoot,
    acc.codeHash,
  ])
}

export function main(testSuite: TestSuite): boolean {
  const preStateRoot = testSuite.preStateRoot
  const blockData = decodeBlockData(testSuite.blockData)

  const addrs = blockData.addrs
  const proof = blockData.multiproof
  const updatedLeaves = new Array(blockData.multiproof.keyvals.length).fill(undefined)

  for (const rawTx of blockData.txes) {
    const tx = decodeTx(rawTx)
    const fromIdx = tx.fromIdx
    const toIdx = tx.toIdx

    const encodedUnsignedTx = encode([addrs[toIdx], tx.value, tx.nonce])
    const txHash = keccak256(encodedUnsignedTx)
    // TODO: assert signature recovered address matches the given address
    // const recoveredAddr = ecrecover(txHash, tx.sig)
    // assert(addrs[fromIdx].equals(recoveredAddr))

    // If `from` or `to` has been modified, use the updated version
    let fromLeaf = proof.keyvals[fromIdx]
    if (updatedLeaves[fromIdx] !== undefined) {
      fromLeaf = updatedLeaves[fromIdx]
    }
    let toLeaf = proof.keyvals[toIdx]
    if (updatedLeaves[toIdx] !== undefined) {
      toLeaf = updatedLeaves[toIdx]
    }

    const decodedFrom = decode(fromLeaf)
    const decodedTo = decode(toLeaf)
    // @ts-ignore
    const fromAcc = decodeAccount(decodedFrom[1])
    // @ts-ignore
    const toAcc = decodeAccount(decodedTo[1])

    assert(fromAcc.balance.gte(tx.value))
    assert(fromAcc.nonce.eq(tx.nonce))

    fromAcc.balance.isub(tx.value)
    toAcc.balance.iadd(tx.value)
    fromAcc.nonce.iaddn(1)

    updatedLeaves[fromIdx] = encode([decodedFrom[0], encodeAccount(fromAcc)])
    updatedLeaves[toIdx] = encode([decodedTo[0], encodeAccount(toAcc)])
  }

  const keys = addrs.map((a: Buffer) => keccak256(a))

  return verifyMultiproof(preStateRoot, blockData.multiproof, keys)
}
