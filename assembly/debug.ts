import { debug_print32, debug_printMem } from '../node_modules/scout.ts/assembly/env'

export function debugMem(buf: Uint8Array): void {
  debug_printMem(buf.buffer as usize + buf.byteOffset, buf.length)
}

export function debug(v: i32): void {
  debug_print32(v)
}
