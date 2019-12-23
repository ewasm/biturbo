import { ethash_keccak256 } from './keccak'

@inline
export function parseU8(buf: Uint8Array): u8 {
  // @ts-ignore
  return buf.length ? load<u8>(buf.dataStart as usize) : 0
}

export function bufEq(buf: Uint8Array, other: Uint8Array): boolean {
  let bufLen = buf.length
  if (bufLen != other.length) return false
  return memory.compare(buf.dataStart as usize, other.dataStart as usize, bufLen) == 0
}

export function padBuf(buf: Uint8Array, length: usize): Uint8Array {
  let diff = length - buf.length
  if (diff < 0) {
    throw new Error('Buffer bigger than expected')
  } else if (diff == 0) {
    return buf
  }
  let res = new ArrayBuffer(length)
  // @ts-ignore
  memory.copy((res as usize) + diff, buf.dataStart as usize, buf.length)
  return Uint8Array.wrap(res, 0, length)
}

export function cmpBuf(buf: Uint8Array, other: Uint8Array): i32 {
  if (buf === other) return 0 // fast compare by references
  let bufLen = buf.length
  let otherLen = other.length
  if (bufLen > otherLen) return 1
  if (bufLen < otherLen) return -1
  // Assume Big-endian
  for (let i = 0; i < bufLen; i++) {
    let a = unchecked(buf[i])
    let b = unchecked(other[i])
    if (a != b) return i32(a > b) - i32(a < b)
  }
  return 0
}

export function stripBuf(buf: Uint8Array): Uint8Array {
  let start = buf.length
  for (let i = 0, len = start; i < len; i++) {
    if (unchecked(buf[i]) != 0) {
      start = i
      break
    }
  }
  return buf.subarray(start)
}

@inline
export function hash(buf: Uint8Array): Uint8Array {
  let res = new Uint8Array(32)
  // @ts-ignore
  ethash_keccak256(res.dataStart as usize, buf.dataStart as usize, buf.byteLength)
  return res
}

@inline
export function removeHexPrefix(nib_arr: Array<u8>): Array<u8> {
  // the hex prefix is merkle-patricia-trie encoding, not RLP
  return nib_arr.slice(1 + i32((nib_arr[0] & 1) == 0))
}

export function addHexPrefix(key_nib_arr: Array<u8>, terminator: bool): Array<u8> {
  if (key_nib_arr.length & 1) {
    // odd
    key_nib_arr.unshift(1)
  } else {
    // even
    key_nib_arr.unshift(0)
    key_nib_arr.unshift(0)
  }

  if (terminator) {
    key_nib_arr[0] += 2
  }

  return key_nib_arr
}

export function u8ArrToNibbleArr(u8_arr: Array<u8>): Array<u8> {
  let len = u8_arr.length

  let nib_arr = new Array<u8>(len * 2) // length is num of hex chars for address_hash
  // TODO: we might not need to convert the whole thing to nibbles, just enough chars to follow the path to the proof
  for (let i = 0; i < len; i++) {
    let byte = u8_arr[i]
    nib_arr[(i << 1) + 0] = byte >> 4
    nib_arr[(i << 1) + 1] = byte & 15
  }
  return nib_arr
}

export function uintArrToNibbleArr(uint_arr: Uint8Array): Array<u8> {
  let len = uint_arr.length
  let nib_arr = new Array<u8>(len * 2) // length is num of hex chars for address_hash
  // TODO: we might not need to convert the whole thing to nibbles, just enough chars to follow the path to the proof
  for (let i = 0; i < len; i++) {
    let byte = uint_arr[i]
    nib_arr[(i << 1) + 0] = byte >> 4
    nib_arr[(i << 1) + 1] = byte & 15
  }
  return nib_arr
}

export function nibbleArrToUintArr(arr: Array<u8>): Uint8Array {
  let len = arr.length / 2
  let buf = new Uint8Array(len)
  for (let i = 0; i < len; i++) {
    unchecked((buf[i] = (arr[i << 1] << 4) + arr[(i << 1) + 1]))
  }
  return buf
}

export function u8ArrToUintArr(arr: Array<u8>): Uint8Array {
  let len = arr.length
  let buf = new Uint8Array(len)
  memory.copy(buf.dataStart as usize, arr.dataStart as usize, len)
  return buf
}
