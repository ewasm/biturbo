import * as assert from 'assert'
import BN = require('bn.js')
import { getOpcodesForHF } from 'ethereumjs-vm/dist/evm/opcodes'
import Common from 'ethereumjs-common'

const Trie = require('merkle-patricia-tree/secure')
const { promisify } = require('util')
const common = new Common('mainnet', 'istanbul')

export interface Chunker {
  getChunks(code: Buffer): Chunk[]
  isFixedSize(): boolean
}

export class Bytecode {
  code: Buffer
  chunks: Chunk[]
  isFixedSize: boolean

  constructor (code: Buffer, chunker: Chunker) {
    this.code = code
    this.chunks = chunker.getChunks(code)
    this.isFixedSize = chunker.isFixedSize()
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
      let val
      if (this.isFixedSize) {
        const skip = chunk.firstCodeByte - chunk.start
        // Fits in a byte
        assert(skip < 256)
        const skipBuf = Buffer.alloc(1)
        skipBuf.writeUInt8(skip, 0)
        val = Buffer.concat([skipBuf, chunk.code])
      } else {
        val = chunk.code
      }
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
    const opcodes = getOpcodesForHF(common)
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

  isFixedSize (): boolean {
    return false
  }
}

export class FixedSizeChunker {
  SIZE: number

  constructor (size: number = 32) {
    if (size < 32) {
      console.warn('FixedSizeChunker might not work properly with size < 32')
    }
    this.SIZE = size
  }

  getChunks (code: Buffer): Chunk[] {
    const opcodes = getOpcodesForHF(common)
    const getOp = (i: number) => (opcodes[code[i]] ? opcodes[code[i]].name : 'INVALID')
    const chunks: Chunk[] = []

    // Split into chunks
    let start = 0
    for (let i = 0; i < code.length; i += this.SIZE) {
      chunks.push(new Chunk(code, i, i + this.SIZE))
    }
    if (chunks[chunks.length - 1].end < code.length) {
      const s = chunks[chunks.length - 1].end
      chunks.push(new Chunk(code, s, code.length))
    }

    // Determine first non-data byte in each chunk
    for (let i = 0; i < code.length; i++) {
      const op = getOp(i)
      if (op === 'PUSH') {
        const numToPush = code[i] - 0x5f
        if ((i + numToPush) % this.SIZE <= i % this.SIZE) {
          const chunkIdx = Math.floor((i + numToPush) / this.SIZE)
          if (chunks[chunkIdx] !== undefined) {
            chunks[chunkIdx].firstCodeByte = i + numToPush + 1
            //throw new Error(`Chunk not found (${chunkIdx}/${chunks.length})`)
          } else {
            // Data section at the end of bytecode can mess this up
            console.log('Chunk not found, check math', i + numToPush, this.SIZE, code.length)
            //console.log(code.slice(i - 2, i + numToPush + 1))
          }
        }
        i += numToPush
      }
    }

    return chunks
  }

  isFixedSize (): boolean {
    return true
  }
}

export class Chunk {
  start: number
  end: number
  code: Buffer
  // For fixed sized chunks we need to know which byte is first non-data byte
  firstCodeByte: number

  constructor (fullCode: Buffer, start: number, end: number, firstCodeByte: number = start) {
    this.start = start
    this.end = end
    this.code = fullCode.slice(start, end)
    this.firstCodeByte = firstCodeByte
  }
}
