import { ethash_keccak256 } from './keccak'

@inline
export function parseU8(buf: Uint8Array): u8 {
  // @ts-ignore
  return buf.length ? load<u8>(buf.dataStart as usize) : 0
}

export function bufEq(buf: Uint8Array, other: Uint8Array): boolean {
  let bufLen = buf.length
  if (bufLen != other.length) return false
  for (let i = 0; i < bufLen; i++) {
    if (unchecked(buf[i]) != unchecked(other[i])) return false
  }
  return true
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

export function cmpBuf(buf: Uint8Array, other: Uint8Array): usize {
  let bufLen = buf.length
  if (bufLen > other.length) return 1
  if (bufLen < other.length) return -1
  let res = 0
  // Assume Big-endian
  for (let i = 0; i < bufLen; i++) {
    let a = buf[i]
    let b = other[i]
    if (a == b) {
      continue
    } else if (a < b) {
      res = -1
    } else {
      res = 1
    }
    // Break after first un-equal byte encountered
    break
  }
  return res
}

export function stripBuf(buf: Uint8Array): Uint8Array {
  let start = buf.length
  for (let i = 0, len = buf.length; i < len; i++) {
    if (unchecked(buf[i]) != 0) {
      start = i
      break
    }
  }
  return buf.subarray(start)
}

@inline
export function hash(buf: Uint8Array): Uint8Array {
  let hashBuf = new ArrayBuffer(32)
  // @ts-ignore
  ethash_keccak256(hashBuf as usize, buf.dataStart as usize, buf.byteLength)
  return Uint8Array.wrap(hashBuf)
}

export function removeHexPrefix(nib_arr: Array<u8>): Array<u8> {
  // the hex prefix is merkle-patricia-trie encoding, not RLP
  if (nib_arr[0] & 1) {
    return nib_arr.slice(1)
  } else {
    return nib_arr.slice(2)
  }
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
    key_nib_arr[0] = key_nib_arr[0] + 2
  }

  return key_nib_arr
}

export function u8ArrToNibbleArr(u8_arr: Array<u8>): Array<u8> {
  let len = u8_arr.length

  let nib_arr = new Array<u8>(len * 2) // length is num of hex chars for address_hash
  // TODO: we might not need to convert the whole thing to nibbles, just enough chars to follow the path to the proof

  let q = 0
  for (let i = 0; i < len; i++) {
    q = i * 2
    nib_arr[q] = u8_arr[i] >> 4
    q = q + 1
    nib_arr[q] = u8_arr[i] & 15
  }

  return nib_arr
}

export function uintArrToNibbleArr(uint_arr: Uint8Array): Array<u8> {
  let len = uint_arr.length
  let nib_arr = new Array<u8>(len * 2) // length is num of hex chars for address_hash
  // TODO: we might not need to convert the whole thing to nibbles, just enough chars to follow the path to the proof

  let q = 0
  for (let i = 0; i < len; i++) {
    q = i << 1
    nib_arr[q] = uint_arr[i] >> 4
    q = q + 1
    nib_arr[q] = uint_arr[i] & 15
  }

  return nib_arr
}

export function nibbleArrToUintArr(arr: Array<u8>): Uint8Array {
  let buf = new Uint8Array(arr.length / 2)
  for (let i = 0, len = buf.length; i < len; i++) {
    let q = i << 1
    unchecked((buf[i] = (arr[q] << 4) + arr[++q]))
  }
  return buf
}

export function u8ArrToUintArr(arr: Array<u8>): Uint8Array {
  let buf = new Uint8Array(arr.length)
  for (let i = 0, len = arr.length; i < len; i++) {
    unchecked((buf[i] = arr[i]))
  }
  return buf
}
