import BN = require('bn.js')
import { getOpcodesForHF } from 'ethereumjs-vm/dist/evm/opcodes'

const Trie = require('merkle-patricia-tree/secure')
const { promisify } = require('util')

export class Bytecode {
  code: Buffer

  constructor (code: Buffer) {
    this.code = code
  }

  /**
   * Does a single pass over bytecode to find the list
   * of all basic blocks (i.e. blocks of code with no
   * control flow change).
   */
  getBasicBlocks(minLen: number = 0): Buffer[] {
    let blocks = this.getBasicBlockIndices()
    if (minLen) {
      blocks = mergeBlocks(blocks, minLen)
    }
    // Slice code based on block indices
    return blocks.map((b: number[]) => this.code.slice(b[0], b[1]))
  }

  getBasicBlockIndices(): number[][] {
    const TERMINATING_OPS = ['JUMP', 'JUMPI', 'STOP', 'RETURN', 'REVERT', 'SELFDESTRUCT']
    const opcodes = getOpcodesForHF('istanbul')
    const getOp = (i: number) => (opcodes[this.code[i]] ? opcodes[this.code[i]].name : 'INVALID')

    // [start, end) indices
    const blocks = [[0, -1]]
    for (let i = 0; i < this.code.length; i++) {
      const op = getOp(i)
      // Skip push args
      if (op === 'PUSH') {
        i += this.code[i] - 0x5f
      }

      // Current instruction terminates block or next instruction is JUMPDEST
      if (TERMINATING_OPS.includes(op) || (i + 1 < this.code.length && getOp(i + 1) === 'JUMPDEST')) {
        blocks[blocks.length - 1][1] = i + 1
        // Create new block if not at end of code
        if (i + 1 < this.code.length) {
          blocks.push([i + 1, -1])
        }
      }
    }

    // Close block if no terminating instruction at the end
    if (blocks[blocks.length - 1][1] === -1) {
      blocks[blocks.length - 1][1] = this.code.length
    }

    return blocks
  }

  /**
   * Divides code into basic blocks and constructs a MPT
   * with these blocks as leaves. The key for each block is
   * the index of the first byte of that block in the bytecode.
   */
  async merkelizeCode(minLen: number = 0): Promise<any> {
    let blockIndices = this.getBasicBlockIndices()
    if (minLen) {
      blockIndices = mergeBlocks(blockIndices, minLen)
    }
    const trie = new Trie()
    const putP = promisify(trie.put.bind(trie))
    // Keys are indices into the bytecode. Determine key length by
    // how large the last index is.
    const keyLength = new BN(this.code.length - 1).byteLength()
    for (let i = 0; i < blockIndices.length; i++) {
      const key = new BN(blockIndices[i][0]).toBuffer('be', keyLength)
      const val = this.code.slice(blockIndices[i][0], blockIndices[i][1])
      await putP(key, val)
    }
    return trie
  }
}

export class Chunk {
  start: number
  end: number
  code: Buffer

  constructor (start: number, end: number, fullCode: Buffer) {
    this.start = start
    this.end = end
    this.code = fullCode.slice(start, end)
  }
}

/**
 * Given a list of basic blocks, it merges neighbouring blocks
 * so that each block has a minimum length.
 */
export function mergeBlocks(blocks: number[][], minLen: number = 32): number[][] {
  // [start, end)
  const res = [[0, -1]]
  for (const b of blocks) {
    if (b[1] - res[res.length - 1][0] >= minLen) {
      res[res.length - 1][1] = b[1]
      res.push([b[1], -1])
    }
  }
  // Close block if final block < minLen
  if (res[res.length - 1][1] === -1) {
    res[res.length - 1][1] = blocks[blocks.length - 1][1]
  }
  // Delete last block if it's an empty block
  if (res[res.length - 1][0] === res[res.length - 1][1]) {
    res.pop()
  }
  return res
}
