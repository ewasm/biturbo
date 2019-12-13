import { debug, debugMem } from './debug'
import { bignum_add256, debug_print32 } from './env'
import { Opcodes } from './opcodes'

export function interpret(code: Uint8Array): void {
  // stack size is 100 elements
  // each stack element is 32 bytes
  const stackSize = 100
  const stackElementSize = 32
  let stack = new ArrayBuffer(stackElementSize * stackSize)
  let stackPtr = changetype<usize>(stack)
  let stackElements = new Array<Uint8Array>(stackSize)

  for (let i = 0; i < stackSize; i++) {
    stackElements[i] = Uint8Array.wrap(stack, i * stackElementSize, stackElementSize)
  }

  const memorySize = 100
  const memoryElementSize = 16
  let memory = new ArrayBuffer(memoryElementSize * memorySize)
  let memoryPtr = changetype<usize>(memory)
  let memoryElements = new Array<Uint8Array>(memorySize)

  for (let i = 0; i < memorySize; i++) {
    memoryElements[i] = Uint8Array.wrap(memory, i * memoryElementSize, memoryElementSize)
  }

  let stackTop: i32 = 0

  let pc: i32 = 0

  while (pc < code.length) {
    let opcode: u8 = code[pc]
    pc++

    debug_print32(opcode)
    switch (opcode) {
      case Opcodes.Push1:
        let push_val = code[pc]
        pc++
        let stack_slot = stackElements[stackTop]
        stack_slot.fill(0, 0, 32)

        // 1 byte goes in the last byte of the 32-byte stack slot
        stack_slot[31] = push_val

        stackTop++

        break
      case Opcodes.Add:
        let a_pos = stackPtr + 32 * (stackTop - 1)
        let b_pos = stackPtr + 32 * (stackTop - 2)

        bignum_add256(a_pos, b_pos, b_pos)

        stackTop--
        break
      case Opcodes.SStore:
        // TODO:
        // store(position, value)
        break
      default:
        debug_print32(404)
        pc = code.length // unknown opcode, finish execution
        break
    }
  }
}
