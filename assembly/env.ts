// eth2 namespace
export declare function eth2_loadPreStateRoot(offset: u32): void;
export declare function eth2_blockDataSize(): u32;
export declare function eth2_blockDataCopy(outputOffset: u32, offset: u32, length: u32): void;
export declare function eth2_savePostStateRoot(offset: u32): void;
export declare function eth2_pushNewDeposit(offseT: u32): void;
export declare function eth2_setBignumStack(startData: u32): void;
export declare function eth2_setMemoryPtr(startData: u32): void;

// debug namespace
export declare function debug_print32(value: i32): void;
export declare function debug_printMem(ptr: i32, length: i32): void;
export declare function debug_printMemHex(ptr: i32, length: i32): void;


// bignum namespace
export declare function bignum_add256(elem_a: u32, elem_b: u32, result: u32): void
export declare function bignum_mul256(stackTop: u32): u32;
export declare function bignum_sub256(elem_a: u32, elem_b: u32, result: u32): void
export declare function bignum_lt256(stackTop: u32): u32;
export declare function bignum_div256(stackTop: u32): u32;
export declare function bignum_jumpi(stackTop: u32, pc: i32): u32;
