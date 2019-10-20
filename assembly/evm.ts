import { debug, debugMem } from './debug'
import { bignum_add256,
         debug_print32,
       } from './env'

export function interpret(code: Uint8Array): void {
  // bignum stack size is 100 elements
  // each stack element is 32 bytes
  let BignumStackSize = 100
  let BignumElementSize = 32
  let BignumStack = new ArrayBuffer(BignumElementSize * BignumStackSize)
  let BignumStackPtr = changetype<usize>(BignumStack)
  let BignumStackElements = Array.create<Uint8Array>(100)

  for (let i = 0; i < BignumStackSize; i++) {
    BignumStackElements[i] = Uint8Array.wrap(BignumStack, i*BignumElementSize, 32)
  }

  let MemorySize = 100
  let MemoryElementSize = 16
  let Memory = new ArrayBuffer(MemoryElementSize * MemorySize)
  let MemoryPtr = changetype<usize>(Memory)
  let MemoryElements = Array.create<Uint8Array>(100)

  for (let i = 0; i < MemorySize; i++) {
    MemoryElements[i] = Uint8Array.wrap(Memory, i * MemoryElementSize, 16)
  }

  let BignumStackTop: i32 = 0

  const stop: u8 = 0x00
  const add: u8 = 0x01
  const mul: u8 = 0x02
  const sub: u8 = 0x03
  const div: u8 = 0x04
  const lt: u8 = 0x10
  const eq: u8 = 0x14
  const iszero: u8 = 0x15
  const opnot: u8 = 0x19
  const callvalue: u8 = 0x34
  const calldataload: u8 = 0x35
  const calldatasize: u8 = 0x36
  const codecopy: u8 = 0x39
  const pop: u8 = 0x50
  const mload: u8 = 0x51
  const mstore: u8 = 0x52
  const sstore: u8 = 0x55
  const jump: u8 = 0x56
  const jumpi: u8 = 0x57
  const jumpdest: u8 = 0x5b
  const push1: u8 = 0x60
  const push2: u8 = 0x61
  const push3: u8 = 0x62
  const push4: u8 = 0x63
  const push29: u8 = 0x7c
  const dup1: u8 = 0x80
  const dup2: u8 = 0x81
  const dup3: u8 = 0x82
  const swap1: u8 = 0x90
  const swap2: u8 = 0x91
  const swap3: u8 = 0x92
  const opreturn: u8 = 0xf3
  const revert: u8 = 0xfd
  const invalid: u8 = 0xfe

  let pc: i32 = 0
  
  while (pc < code.length) {
    let opcode: u8 = code[pc]
    pc++

    debug_print32(opcode)
    switch(opcode) {
    case push1: // 0x60
      let push_val = code[pc]
      pc++
      let stack_slot = BignumStackElements[BignumStackTop]
      stack_slot.fill(0, 0, 32)

      // 1 byte goes in the last byte of the 32-byte stack slot
      stack_slot[31] = push_val

      BignumStackTop++

      break
    case add: // 0x01
      let a_pos = BignumStackPtr + 32 * (BignumStackTop - 1)
      let b_pos = BignumStackPtr + 32 * (BignumStackTop - 2)

      bignum_add256(a_pos, b_pos, b_pos)

      BignumStackTop--
      break
    case sstore:
      // TODO:
      // store(position, value)
      break
    default:
      debug_print32(404)
      pc = code.length   // unknown opcode, finish execution
      break
    }
  }
}