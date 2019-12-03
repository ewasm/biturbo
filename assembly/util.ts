import { ethash_keccak256 } from "./keccak";

export function parseU8(buf: Uint8Array): u8 {
  if (buf.length == 0) return 0
  return (new DataView(buf.buffer, buf.byteOffset, buf.byteLength)).getUint8(0)
}

export function bufEq(buf: Uint8Array, other: Uint8Array): boolean {
  if (buf.length != other.length) return false
  for (let i = 0; i < buf.length; i++) {
    if (buf[i] != other[i]) return false
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
  memory.copy((res as usize + diff), buf.buffer as usize + buf.byteOffset, buf.length)
  return Uint8Array.wrap(res, 0, length)
}

export function cmpBuf(buf: Uint8Array, other: Uint8Array): usize {
  if (buf.length > other.length) return 1
  if (buf.length < other.length) return -1
  let res = 0
  // Assume Big-endian
  for (let i = 0; i < buf.length; i++) {
    let a = buf[i]
    let b = other[i]
    if (a == b) {
      continue
    } else if (a < b) {
      res = -1
    } else {
      res = 1
    }
  }
  return res
}

export function stripBuf(buf: Uint8Array): Uint8Array {
  let start = 0
  for (let i = 0; i < buf.length; i++) {
    if (buf[i] != 0) {
      start = i
      break
    }
  }
  return buf.subarray(start)
}

@inline
export function hash(buf: Uint8Array): Uint8Array {
  let hashBuf = new ArrayBuffer(32)
  ethash_keccak256(hashBuf as usize, buf.buffer as usize + buf.byteOffset, buf.byteLength)
  return Uint8Array.wrap(hashBuf)
}

export function removeHexPrefix(nib_arr: Array<u8>): Array<u8> {
  // the hex prefix is merkle-patricia-trie encoding, not RLP
  if (nib_arr[0] % 2) {
    return nib_arr.slice(1);
  } else {
    return nib_arr.slice(2);
  }
}

export function addHexPrefix(key_nib_arr: Array<u8>, terminator: bool): Array<u8> {
  if (key_nib_arr.length % 2) {
    // odd
    key_nib_arr.unshift(1);
  } else {
    // even
    key_nib_arr.unshift(0);
    key_nib_arr.unshift(0);
  }

  if (terminator) {
    key_nib_arr[0] = key_nib_arr[0] + 2;
  }

  return key_nib_arr;
}

export function u8ArrToNibbleArr(u8_arr: Array<u8>): Array<u8> {
  var len = u8_arr.length;

  var nib_arr = Array.create<u8>(len * 2); // length is num of hex chars for address_hash
  // TODO: we might not need to convert the whole thing to nibbles, just enough chars to follow the path to the proof

  let q = 0;
  for (let i = 0; i < len; i++) {
    q = i * 2;
    nib_arr[q] = u8_arr[i] >> 4;
    q = q + 1;
    nib_arr[q] = u8_arr[i] % 16;
  }

  return nib_arr;
}

export function uintArrToNibbleArr(uint_arr: Uint8Array): Array<u8> {
  var len = uint_arr.length;

  var nib_arr = Array.create<u8>(len * 2); // length is num of hex chars for address_hash
  // TODO: we might not need to convert the whole thing to nibbles, just enough chars to follow the path to the proof

  let q = 0;
  for (let i = 0; i < len; i++) {
    q = i * 2;
    nib_arr[q] = uint_arr[i] >> 4;
    q = q + 1;
    nib_arr[q] = uint_arr[i] % 16;
  }

  return nib_arr;
}

export function nibbleArrToUintArr(arr: Array<u8>): Uint8Array {
  let buf = new Uint8Array(arr.length / 2);

  for (let i = 0; i < buf.length; i++) {
    let q = i * 2;
    buf[i] = (arr[q] << 4) + arr[++q];
  }

  return buf;
}

export function u8ArrToUintArr(arr: Array<u8>): Uint8Array {
  let buf = new Uint8Array(arr.length)

  for (let i = 0; i < arr.length; i++) {
    buf[i] = arr[i]
  }

  return buf
}
