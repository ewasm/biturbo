
import { ethash_keccak256 } from "./keccak";
import { RLPData, decode } from "./rlp";

/** debugging functions
export declare function sayHello(a: i32): void;

@external("main", "debug")
export declare function debug(a: i32): void;
*/

@external("env", "debug_log")
export declare function debug(a: i32): void;

@external("env", "debug_mem")
export declare function debug_mem(a: i32): void;

@external("env", "eth2_blockDataSize")
export declare function eth2_blockDataSize(): i32;

@external("env", "eth2_blockDataCopy")
export declare function eth2_blockDataCopy(outputOffset: i32, srcOffset: i32, length: i32): void;

@external("env", "eth2_loadPreStateRoot")
export declare function eth2_loadPreStateRoot(offset: i32): void;

@external("env", "eth2_savePostStateRoot")
export declare function eth2_savePostStateRoot(offset: i32): void;


export function main(): i32 {


/** these globals were defined above as top level statements
 * but AS compiled them to a start function (which Scout won't run).
 *
 * There is an @global decorator, but looks like its only for functions, not variables
*/

// define two globals for using keccak: the context and the output buffer
// both will be reused repeatedly when calling keccak

// allocate keccak context buffer
let keccakCtx = new ArrayBuffer(650); // more than 616 (see the docs in keccak.tx)
let keccakCtxBuf = changetype<usize>(keccakCtx);

// allocate keccak output buffer
let hashOutputBuf = new ArrayBuffer(32);
let hashOutput = Uint64Array.wrap(hashOutputBuf, 0, 4);
// another option is Uint8Array.wrap(hashOutputBuf, 0, 32)
// we use Uint64Array so we can test equivalence of hashes by checking 4 elements rather than 32
let hashOutputPtr = changetype<usize>(hashOutputBuf);




  // INPUT 1: root hash (the pre-state root), hardcoded for testing TODO: fetch from EEI
  let root_hash_buf = new ArrayBuffer(32);
  // 0x65b7b9ccb7a4d828986e488e081bc11bfa5ef6141fb06b0af2e9a0bda273a753
  let root_hash_data = Uint64Array.wrap(root_hash_buf, 0, 4);
  eth2_loadPreStateRoot(root_hash_buf as usize);



  // INPUT 3: get proof data from the EEI
  let input_data_len = eth2_blockDataSize();
  let input_data_buff = new ArrayBuffer(input_data_len);
  let input_data_buff_ptr = changetype<usize>(input_data_buff);
  eth2_blockDataCopy(input_data_buff_ptr, 0, input_data_len);
  let input_data = Uint8Array.wrap(input_data_buff, 0, input_data_len);

  // input data is RLP
  let input_decoded = decode(input_data);
  // input_decoded is type RLPData: { buffer: Uint8Array, children: RLPData[] }

  let accounts_sequence_encoded = input_decoded.children[0]; // accounts array to be further decoded
  let hashes_data = input_decoded.children[1].buffer; // 32-byte hashes, simply concatenated
  let multiproof_opcodes = input_decoded.children[2].buffer;

  debug(hashes_data.length);
  debug(multiproof_opcodes.length);

  let hashes_data_start_ptr = (hashes_data.buffer as usize) + hashes_data.byteOffset;

  let accounts_sequence = decode(accounts_sequence_encoded.buffer).children;
  debug(accounts_sequence.length);


  const LEAF: u8 = 0x80;
  const BRANCHHASH: u8 = 0x81;
  const HASHES: u8 = 0x82;


  let pc: i32 = 0;

  let accounts_seq_i = 0;
  let hashes_seq_i = 0;

  let multiproofStack = new Uint32Array(100);
  // stack will hold pointers to memory locations
  let stackTop = 0;

  debug(777);
  debug(multiproof_opcodes.length);

  while (pc < multiproof_opcodes.length) {
    debug(111);
    debug(pc);

    let opcode: u8 = multiproof_opcodes[pc];
    debug(opcode);
    pc++;

    switch (opcode) {
      case LEAF:
        debug(80);
        // hash the leaf and push hash onto stack
        let leaf_node = accounts_sequence[accounts_seq_i].buffer;
        accounts_seq_i += 1;
        
        // get the key for the account leaf (the hash of the address)
        //let leafHashOutput = new ArrayBuffer(32);
        let leafHashOutputPtr = changetype<usize>(new ArrayBuffer(32));
        ethash_keccak256(leafHashOutputPtr, (leaf_node.buffer as usize) + leaf_node.byteOffset, leaf_node.byteLength);

        debug_mem(leafHashOutputPtr);
        multiproofStack[stackTop] = leafHashOutputPtr;
        stackTop++;

        pc++; // advance pc past leaf operand
        break;

      case BRANCHHASH:
        debug(81);
        // TODO: pop hashes from `multiproofStack` and construct branch node
        break;

      case HASHES:
        debug(82);
        // pulls hashes from the input data and puts them on the stack
        // don't bother trying to optimize the layout here, because in BRANCHHASH  they will be RLP encoded and into branche nodes
        // and rlp encoding does memory copying
        // this could be optimized to reduce memory copying, but it might require a different opcode / data sequenc
        let hashes_operand = (multiproof_opcodes[pc] as i32);
        debug(hashes_operand);
        pc++; // advance pc past hashes operand
        for (let i = 0; i < hashes_operand; i++) {
          let hash_ptr = hashes_data_start_ptr + hashes_seq_i*32;
          hashes_seq_i += 1;
          //let hashPtr = (hash.buffer as usize) + hash.byteOffset;
          debug_mem(hash_ptr);
          multiproofStack[stackTop] = hash_ptr;
          stackTop++;
        }

        break;

      default:
        break;
    }

  }




  eth2_savePostStateRoot(root_hash_buf as usize);
  return 1;

}
