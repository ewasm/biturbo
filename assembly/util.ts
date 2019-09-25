import { ethash_keccak256 } from "./keccak";

@external("debug", "debug_printMem")
export declare function debug_mem(pos: i32, len: i32): void;

@external("debug", "debug_print32")
export declare function debug(a: i32): void;

export function parseU8(buf: Uint8Array): u8 {
  return (new DataView(buf.buffer, buf.byteOffset, buf.byteLength)).getUint8(0)
}

export function debugMem(buf: Uint8Array): void {
  debug_mem(buf.buffer as usize + buf.byteOffset, buf.length)
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
  for (let i = 0; i < buf.length; i--) {
    let a = buf[i]
    let b = buf[i]
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

export function hash(buf: Uint8Array): Uint8Array {
  let hashBuf = new ArrayBuffer(32)
  ethash_keccak256(hashBuf as usize, buf.buffer as usize + buf.byteOffset, buf.byteLength)
  return Uint8Array.wrap(hashBuf)
}
