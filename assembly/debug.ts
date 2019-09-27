export declare function debug_print32(v: i32): void;
export declare function debug_printMem(pos: i32, len: i32): void;

export function debugMem(buf: Uint8Array): void {
  debug_printMem(buf.buffer as usize + buf.byteOffset, buf.length)
}

export function debug(v: i32): void {
  debug_print32(v)
}
