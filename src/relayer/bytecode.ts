import BN = require('bn.js')
import { getOpcodesForHF } from 'ethereumjs-vm/dist/evm/opcodes'

const Trie = require('merkle-patricia-tree/secure')
const { promisify } = require('util')

export interface Chunker {
  getChunks(code: Buffer): Chunk[]
}

export class Bytecode {
  code: Buffer
  chunks: Chunk[]

  constructor (code: Buffer, chunker: BasicBlockChunker) {
    this.code = code
    this.chunks = chunker.getChunks(code)
  }

  /**
   * Divides code into basic blocks and constructs a MPT
   * with these blocks as leaves. The key for each block is
   * the index of the first byte of that block in the bytecode.
   */
  async merkelizeCode(minLen: number = 0): Promise<any> {
    const trie = new Trie()
    const putP = promisify(trie.put.bind(trie))
    // Keys are indices into the bytecode. Determine key length by
    // how large the last index is.
    const keyLength = new BN(this.code.length - 1).byteLength()
    for (const chunk of this.chunks) {
      const key = new BN(chunk.start).toBuffer('be', keyLength)
      const val = chunk.code
      await putP(key, val)
    }
    return trie
  }

  pcChunk(pc: number): Chunk | undefined {
    for (const c of this.chunks) {
      if (this.pcInChunk(pc, c)) {
        return c
      }
    }
    return undefined
  }

  chunkRange(start: number, end: number): Chunk[] {
    const res = []
    const codeLength = this.code.length //blockIndices[blockIndices.length - 1][1]
    if (start >= codeLength) start = codeLength - 1
    if (end >= codeLength) end = codeLength - 1
    let startChunk: number | undefined
    let endChunk: number | undefined
    for (let i = 0; i < this.chunks.length; i++) {
      const c = this.chunks[i]
      if (this.pcInChunk(start, c)) {
        startChunk = i
        break
      }
    }
    if (startChunk === undefined) throw new Error('No start in block range')
    for (let i = 0; i < this.chunks.length; i++) {
      const c = this.chunks[i]
      if (this.pcInChunk(end, c)) {
        endChunk = i
        break
      }
    }
    if (endChunk === undefined) throw new Error('No end in block range')
    return this.chunks.slice(startChunk, endChunk + 1)
  }

  pcInChunk(pc: number, chunk: Chunk): boolean {
    return pc >= chunk.start && pc < chunk.end
  }
}

export class BasicBlockChunker {
  MIN_BLOCK_LEN: number

  constructor (minBlockLen: number = 0) {
    this.MIN_BLOCK_LEN = minBlockLen
  }

  getChunks(code: Buffer): Chunk[] {
    let blocks = this.getBasicBlockIndices(code)
    if (this.MIN_BLOCK_LEN > 0) {
      blocks = this.mergeBlocks(blocks)
    }

    return blocks.map((b: number[]) => new Chunk(code, b[0], b[1]))
  }

  getBasicBlockIndices(code: Buffer): number[][] {
    const TERMINATING_OPS = ['JUMP', 'JUMPI', 'STOP', 'RETURN', 'REVERT', 'SELFDESTRUCT']
    const opcodes = getOpcodesForHF('istanbul')
    const getOp = (i: number) => (opcodes[code[i]] ? opcodes[code[i]].name : 'INVALID')

    // [start, end) indices
    const blocks = [[0, -1]]
    for (let i = 0; i < code.length; i++) {
      const op = getOp(i)
      // Skip push args
      if (op === 'PUSH') {
        i += code[i] - 0x5f
      }

      // Current instruction terminates block or next instruction is JUMPDEST
      if (TERMINATING_OPS.includes(op) || (i + 1 < code.length && getOp(i + 1) === 'JUMPDEST')) {
        blocks[blocks.length - 1][1] = i + 1
        // Create new block if not at end of code
        if (i + 1 < code.length) {
          blocks.push([i + 1, -1])
        }
      }
    }

    // Close block if no terminating instruction at the end
    if (blocks[blocks.length - 1][1] === -1) {
      blocks[blocks.length - 1][1] = code.length
    }

    return blocks
  }

  /**
   * Given a list of basic blocks, it merges neighbouring blocks
   * so that each block has a minimum length.
   */
  mergeBlocks(blocks: number[][]): number[][] {
    // [start, end)
    const res = [[0, -1]]
    for (const b of blocks) {
      if (b[1] - res[res.length - 1][0] >= this.MIN_BLOCK_LEN) {
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
}

export class Chunk {
  start: number
  end: number
  code: Buffer

  constructor (fullCode: Buffer, start: number, end: number) {
    this.start = start
    this.end = end
    this.code = fullCode.slice(start, end)
  }
}
