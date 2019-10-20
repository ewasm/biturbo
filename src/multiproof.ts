import * as assert from 'assert'
import { decode, encode } from 'rlp'
import { keccak256 } from 'ethereumjs-util'
import { addHexPrefix, removeHexPrefix, bufToU8, lookupNode } from './util'
const promisify = require('util.promisify')
const Trie = require('merkle-patricia-tree/baseTrie')
const TrieNode = require('merkle-patricia-tree/trieNode')
const {
  stringToNibbles,
  nibblesToBuffer,
  getNodeType,
  isRawNode,
} = require('merkle-patricia-tree/trieNode')
const { matchingNibbleLength } = require('merkle-patricia-tree/util')

export enum Opcode {
  Branch = 0,
  Hasher = 1,
  Leaf = 2,
  Extension = 3,
  Add = 4,
}

export enum NodeType {
  Branch = 0,
  Leaf = 1,
  Extension = 2,
  Hash = 3,
}

export interface Instruction {
  kind: Opcode
  value?: number | number[]
}

export interface Multiproof {
  hashes: Buffer[]
  keyvals: Buffer[]
  instructions: Instruction[]
}

export interface StackItem {
  kind: NodeType
  // For now keeping raw for re-constructuring trie
  raw: any
  pathIndices: number[]
  // Buffer or raw (for embedded nodes), or sponge for branch
  hash: any
}

export function verifyMultiproof(root: Buffer, proof: Multiproof, keys: Buffer[]): boolean {
  const stack: StackItem[] = []

  const leaves = proof.keyvals.map((l: Buffer) => decode(l))
  assert(leaves.length === keys.length)
  let leafIdx = 0
  let hashIdx = 0
  const paths = new Array(leaves.length).fill(undefined)

  for (const instr of proof.instructions) {
    if (instr.kind === Opcode.Hasher) {
      const h = proof.hashes[hashIdx++]
      if (!h) {
        throw new Error('Not enough hashes in multiproof')
      }
      stack.push({ kind: NodeType.Hash, raw: [h], pathIndices: [], hash: h.length < 32 ? decode(h) : h })
    } else if (instr.kind === Opcode.Leaf) {
      const l = leaves[leafIdx++]
      if (!l) {
        throw new Error('Expected leaf in multiproof')
      }
      const raw = [l[0], l[1]]
      const e = encode(raw)
      stack.push({ kind: NodeType.Leaf, raw: [l[0], l[1]], pathIndices: [leafIdx - 1], hash: e.length >= 32 ? keccak256(e) : raw })
      // @ts-ignore
      paths[leafIdx - 1] = removeHexPrefix(stringToNibbles(l[0]))
    } else if (instr.kind === Opcode.Branch) {
      const n = stack.pop()
      if (!n) {
        throw new Error('Stack underflow')
      }
      const children = new Array(16).fill(null)
      children[instr.value as number] = n

      let nh = n.hash
      if (n.kind === NodeType.Branch) {
        nh = hashBranch(nh)
      }
      const sponge = new Array(17).fill(Buffer.alloc(0))
      sponge[instr.value as number] = nh

      stack.push({ kind: NodeType.Branch, raw: children, pathIndices: n.pathIndices.slice(), hash: sponge })

      for (let i = 0; i < n.pathIndices.length; i++) {
        paths[n.pathIndices[i]] = [instr.value as number, ...paths[n.pathIndices[i]]]
      }
    } else if (instr.kind === Opcode.Extension) {
      const n = stack.pop()
      if (!n) {
        throw new Error('Stack underflow')
      }

      // Fetch child's hash from hashStack or compute if
      // it's a branch
      let nh = n.hash
      if (n.kind === NodeType.Branch) {
        nh = hashBranch(nh)
      }
      // Compute the extension node's hash and push to hashStack
      const raw = [nibblesToBuffer(addHexPrefix(instr.value as number[], false)), nh]
      const e = encode(raw)
      const h = e.length >= 32 ? keccak256(e) : raw

      stack.push({ kind: NodeType.Extension, raw: [instr.value, n], pathIndices: n.pathIndices.slice(), hash: h })

      for (let i = 0; i < n.pathIndices.length; i++) {
        paths[n.pathIndices[i]] = [...(instr.value as number[]), ...paths[n.pathIndices[i]]]
      }
    } else if (instr.kind === Opcode.Add) {
      const n1 = stack.pop()
      const n2 = stack.pop()
      if (!n1 || !n2) {
        throw new Error('Stack underflow')
      }
      assert(n2.kind === NodeType.Branch, 'expected branch node on stack')
      assert((instr.value as number) < 17)
      n2.raw[instr.value as number] = n1
      n2.pathIndices = Array.from(new Set([...n1.pathIndices, ...n2.pathIndices]))

      let nh = n1.hash
      if (n1.kind === NodeType.Branch) {
        nh = hashBranch(nh)
      }
      const sponge = n2.hash
      assert(Array.isArray(sponge))
      sponge[instr.value as number] = nh
      n2.hash = sponge
      stack.push(n2)

      for (let i = 0; i < n1.pathIndices.length; i++) {
        paths[n1.pathIndices[i]] = [instr.value as number, ...paths[n1.pathIndices[i]]]
      }
    } else {
      throw new Error('Invalid opcode')
    }
  }

  // Assuming sorted keys
  for (let i = 0; i < paths.length; i++) {
    const addr = nibblesToBuffer(paths[i])
    assert(addr.equals(keys[i]))
  }

  const r = stack.pop()
  if (!r) {
    throw new Error('Expected root node on top of stack')
  }

  let h = r.hash
  // Special case, if trie contains only one leaf
  // and that leaf has length < 32
  if (Array.isArray(h)) {
    h = keccak256(encode(h))
  }

  return h.equals(root)
}

function hashBranch(sponge: any): Buffer {
  assert(Array.isArray(sponge) && sponge.length === 17)
  const e = encode(sponge)
  return e.length >= 32 ? keccak256(e) : sponge
}

export async function makeMultiproof(trie: any, keys: Buffer[]): Promise<Multiproof> {
  if (keys.length === 0) {
    return {
      hashes: [trie.root],
      keyvals: [],
      instructions: [{ kind: Opcode.Hasher }],
    }
  }
  const keysNibbles = []
  for (const k of keys) {
    keysNibbles.push(stringToNibbles(k))
  }

  return _makeMultiproof(trie, trie.root, keysNibbles)
}

async function _makeMultiproof(trie: any, rootHash: any, keys: number[][]): Promise<Multiproof> {
  let proof: Multiproof = {
    hashes: [],
    keyvals: [],
    instructions: [],
  }

  let root
  if (Buffer.isBuffer(rootHash)) {
    root = await lookupNode(trie, rootHash)
  } else if (isRawNode(rootHash)) {
    // Embedded node
    root = new TrieNode(rootHash)
  } else {
    throw new Error('Unexpected root')
  }

  if (root.type === 'branch') {
    // Truncate first nibble of keys
    const table = new Array(16).fill(undefined)
    // Group target keys based by their first nibbles.
    // Also implicitly sorts the keys.
    for (const k of keys) {
      const idx = k[0]
      if (!table[idx]) table[idx] = []
      table[idx].push(k.slice(1))
    }

    let addBranchOp = true
    for (let i = 0; i < 16; i++) {
      if (table[i] === undefined) {
        // Empty subtree, hash it and add a HASHER op
        const child = root.getValue(i)
        if (child) {
          proof.instructions.push({ kind: Opcode.Hasher })
          // TODO: Make sure child is a hash
          // what to do if embedded?
          if (Buffer.isBuffer(child)) {
            proof.hashes.push(child)
          } else if (Array.isArray(child)) {
            proof.hashes.push(encode(child))
          } else {
            throw new Error('Invalid branch child')
          }
          if (addBranchOp) {
            proof.instructions.push({ kind: Opcode.Branch, value: i })
            addBranchOp = false
          } else {
            proof.instructions.push({ kind: Opcode.Add, value: i })
          }
        }
      } else {
        const child = root.getValue(i) as Buffer
        if (!child) {
          throw new Error('Key not in trie')
        }
        const p = await _makeMultiproof(trie, child, table[i])
        
        proof.hashes.push(...p.hashes)
        proof.keyvals.push(...p.keyvals)
        proof.instructions.push(...p.instructions)

        if (addBranchOp) {
          proof.instructions.push({ kind: Opcode.Branch, value: i })
          addBranchOp = false
        } else {
          proof.instructions.push({ kind: Opcode.Add, value: i })
        }
      }
    }
  } else if (root.type === 'extention') {
    const extkey = root.key
    // Make sure all keys follow the extension node
    // and truncate them.
    for (let i = 0; i < keys.length; i++) {
      const k = keys[i]
      if (matchingNibbleLength(k, extkey) !== extkey.length) {
        // TODO: Maybe allow proving non-existent keys
        throw new Error('Key not in trie')
      }
      keys[i] = k.slice(extkey.length)
    }
    const p = await _makeMultiproof(trie, root.value, keys)
    proof.hashes.push(...p.hashes)
    proof.keyvals.push(...p.keyvals)
    proof.instructions.push(...p.instructions)
    proof.instructions.push({ kind: Opcode.Extension, value: extkey })
  } else if (root.type === 'leaf') {
    if (keys.length !== 1) {
      throw new Error('Expected 1 remaining key')
    }
    if (matchingNibbleLength(keys[0], root.key) !== root.key.length) {
      throw new Error("Leaf key doesn't match target key")
    }
    // TODO: Check key matches leaf's key
    proof = {
      hashes: [],
      keyvals: [root.serialize()],
      instructions: [{ kind: Opcode.Leaf }],
    }
  } else {
    throw new Error('Unexpected node type')
  }
  return proof
}

export function decodeMultiproof(raw: Buffer): Multiproof {
  const dec = decode(raw)
  assert(dec.length === 3)

  return {
    // @ts-ignore
    hashes: dec[0],
    // @ts-ignore
    keyvals: dec[1],
    // @ts-ignore
    instructions: decodeInstructions(dec[2]),
  }
}

export function encodeMultiproof(proof: Multiproof, flatInstructions: boolean = false): Buffer {
  return encode(rawMultiproof(proof, flatInstructions))
}

export function rawMultiproof(proof: Multiproof, flatInstructions: boolean = false): any {
  if (flatInstructions) {
    return [proof.hashes, proof.keyvals, flatEncodeInstructions(proof.instructions)]
  } else {
    return [
      proof.hashes,
      proof.keyvals,
      proof.instructions.map(i => {
        if (i.value !== undefined) return [i.kind, i.value]
        return [i.kind]
      }),
    ]
  }
}

export function flatEncodeInstructions(instructions: Instruction[]): Buffer {
  const res: number[] = []
  for (const instr of instructions) {
    res.push(instr.kind)
    if (instr.kind === Opcode.Branch || instr.kind === Opcode.Add) {
      res.push(instr.value as number)
    } else if (instr.kind === Opcode.Extension) {
      const nibbles = instr.value as number[]
      res.push(nibbles.length)
      res.push(...nibbles)
    }
  }
  return Buffer.from(new Uint8Array(res))
}

export function flatDecodeInstructions(raw: Buffer): Instruction[] {
  const res = []
  let i = 0
  while (i < raw.length) {
    const op = raw[i++]
    switch (op) {
      case Opcode.Branch:
        res.push({ kind: Opcode.Branch, value: raw[i++] })
        break
      case Opcode.Hasher:
        res.push({ kind: Opcode.Hasher })
        break
      case Opcode.Leaf:
        res.push({ kind: Opcode.Leaf })
        break
      case Opcode.Extension:
        const length = raw.readUInt8(i++)
        const nibbles = []
        for (let j = 0; j < length; j++) {
          nibbles.push(raw[i++])
        }
        res.push({ kind: Opcode.Extension, value: nibbles })
        break
      case Opcode.Add:
        res.push({ kind: Opcode.Add, value: raw[i++] })
        break
    }
  }
  return res
}

export function decodeInstructions(instructions: Buffer[][]) {
  const res = []
  for (const op of instructions) {
    switch (bufToU8(op[0])) {
      case Opcode.Branch:
        res.push({ kind: Opcode.Branch, value: bufToU8(op[1]) })
        break
      case Opcode.Hasher:
        res.push({ kind: Opcode.Hasher })
        break
      case Opcode.Leaf:
        res.push({ kind: Opcode.Leaf })
        break
      case Opcode.Extension:
        // @ts-ignore
        res.push({ kind: Opcode.Extension, value: op[1].map(v => bufToU8(v)) })
        break
      case Opcode.Add:
        res.push({ kind: Opcode.Add, value: bufToU8(op[1]) })
        break
    }
  }
  return res
}

/*
 * @deprecated
 */
function hashTrie(node: any): Buffer {
  const typ = node[0]
  node = node[1]
  if (typ === NodeType.Branch) {
    const res = new Array(17).fill(Buffer.alloc(0))
    for (let i = 0; i < 16; i++) {
      if (node[i] === null) {
        continue
      }
      res[i] = hashTrie(node[i])
    }
    const e = encode(res)
    if (e.length >= 32) {
      return keccak256(e)
    } else {
      return e
    }
  } else if (typ === NodeType.Leaf) {
    const e = encode(node)
    if (e.length >= 32) {
      return keccak256(e)
    } else {
      return node
    }
  } else if (typ === NodeType.Hash) {
    if (node[0].length < 32) {
      // Embedded node, decode to get correct serialization for parent node
      return decode(node[0]) as Buffer
    }
    return node[0]
  } else if (typ === NodeType.Extension) {
    const hashedNode = hashTrie(node[1])
    node = [nibblesToBuffer(addHexPrefix(node[0], false)), hashedNode]
    const e = encode(node)
    if (e.length >= 32) {
      return keccak256(e)
    } else {
      return e
    }
  } else {
    throw new Error('Invalid node')
  }
}
