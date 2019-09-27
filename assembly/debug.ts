export declare function debug(a: i32): void;
export declare function debug_mem(pos: i32, len: i32): void;

export function debugMem(buf: Uint8Array): void {
  debug_mem(buf.buffer as usize + buf.byteOffset, buf.length)
}
