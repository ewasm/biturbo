import { ethash_keccak256 } from "./keccak";
import { hashBranchNode, RLPBranchNode, RLPData, decode, encode } from "./rlp";

@external("env", "debug_log")
export declare function debug(a: i32): void;

@external("env", "debug_mem")
export declare function debug_mem(pos: i32, len: i32): void;

@external("env", "eth2_blockDataSize")
export declare function eth2_blockDataSize(): i32;

@external("env", "eth2_blockDataCopy")
export declare function eth2_blockDataCopy(outputOffset: i32, srcOffset: i32, length: i32): void;

@external("env", "eth2_loadPreStateRoot")
export declare function eth2_loadPreStateRoot(offset: i32): void;

@external("env", "eth2_savePostStateRoot")
export declare function eth2_savePostStateRoot(offset: i32): void;


enum NodeType {
  Leaf,
  Branch,
};



// for Map<UintArray,Node> binaryen toText generates function names with commas, which wabt doesn't like.

var Trie = new Map<usize,Node>();


class Node {
  constructor(
    //public type: u8,
    public type: NodeType,

    public branchBody: RLPBranchNode | null,
    public leafBody: Uint8Array | null,
    // a leaf body is just the rlp encoded account

  ) {}
}


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


  // INPUT 1: pre-state root
  let prestate_root_hash_buf = new ArrayBuffer(32);
  let prestate_root_hash_data = Uint64Array.wrap(prestate_root_hash_buf, 0, 4);
  eth2_loadPreStateRoot(prestate_root_hash_buf as usize);


  // INPUT 2: proof data from the EEI
  let input_data_len = eth2_blockDataSize();
  let input_data_buff = new ArrayBuffer(input_data_len);
  let input_data_buff_ptr = changetype<usize>(input_data_buff);
  eth2_blockDataCopy(input_data_buff_ptr, 0, input_data_len);
  let input_data = Uint8Array.wrap(input_data_buff, 0, input_data_len);

  // input data is RLP
  let input_decoded = decode(input_data);
  // input_decoded is type RLPData: { buffer: Uint8Array, children: RLPData[] }


  let verified_prestate_root_ptr = verifyMultiproof(input_decoded);

  let verifiedPrestateRootBuf = new ArrayBuffer(32);
  // doing memory.copy here because we don't have the reference to the original backing buffer of verified_prestate_root_ptr, only the pointer
  // TODO: try dereferencing the pointer instead of recreating an arraybuffer
  memory.copy((verifiedPrestateRootBuf as usize), verified_prestate_root_ptr, 32);
  let verified_prestate_root = Uint64Array.wrap(verifiedPrestateRootBuf, 0, 4);

  // TODO: make helper for hash comparison, and use @inline
  if (  (verified_prestate_root[0] != prestate_root_hash_data[0])
      || (verified_prestate_root[1] != prestate_root_hash_data[1])
      || (verified_prestate_root[2] != prestate_root_hash_data[2])
      || (verified_prestate_root[3] != prestate_root_hash_data[3]) ) {
    throw new Error('hashes dont match!');
  }



  /*
  // **** loop just verifying the prestate
  // verifyMultiproof does 4 calls to keccak256
  // 50 iterations does 200 calls to keccak256
  for (let i = 0; i < 49; i++) {
    verified_prestate_root_ptr = verifyMultiproof(input_decoded);
  }
  eth2_savePostStateRoot(verified_prestate_root_ptr);
  */


  // **** update post-state
  // INPUT 2: address is another input, also hardcoded for testing.
  let address_hash = Array.create<u8>(32);
  // keccak("eb79aa62d6433e0a23efeb3c859eae7b3c74e850")
  address_hash = [14, 141, 0, 120, 132, 143, 54, 115, 94, 135, 183, 110, 98, 144, 35, 193, 245, 40, 118, 164, 66, 9, 192, 120, 221, 66, 131, 45, 8, 208, 15, 177];

  let key_nibbles = u8ArrToNibbleArr(address_hash);
  //debug_mem((key_nibbles.buffer as usize) + key_nibbles.byteOffset, key_nibbles.byteLength);

  let new_leaf_account_rlp_array = Array.create<u8>(73);
  //let new_leaf_account_rlp = new Uint8Array(73);
  // f8478083ffffffa056e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421a0c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470
  new_leaf_account_rlp_array = [248, 71, 128, 131, 255, 255, 255, 160, 86, 232, 31, 23, 27, 204, 85, 166, 255, 131, 69, 230, 146, 192, 248, 110, 91, 72, 224, 27, 153, 108, 173, 192, 1, 98, 47, 181, 227, 99, 180, 33, 160, 197, 210, 70, 1, 134, 247, 35, 60, 146, 126, 125, 178, 220, 199, 3, 192, 229, 0, 182, 83, 202, 130, 39, 59, 123, 250, 216, 4, 93, 133, 164, 112];

  let new_leaf_account_rlp = Uint8Array.wrap(new_leaf_account_rlp_array.buffer, 0, 73);
  //debug_mem((new_leaf_account_rlp.buffer as usize) + new_leaf_account_rlp.byteOffset, new_leaf_account_rlp.byteLength);

  insertNewLeafNewBranch(verified_prestate_root_ptr, key_nibbles, new_leaf_account_rlp);

  let new_root_ptr = rehashNode(verified_prestate_root_ptr);
  //debug_mem(new_root_ptr, 32);

  // **** verify pre-state + update post-state
  // 9 calls to keccak256 in the first verify + update
  // 22 iterations total to 198 calls to keccak256
  for (let i = 0; i < 21; i++) {
    let calculated_prestate_root_ptr = verifyMultiproof(input_decoded);
    insertNewLeafNewBranch(calculated_prestate_root_ptr, key_nibbles, new_leaf_account_rlp);
    let calculated_poststate_ptr = rehashNode(verified_prestate_root_ptr);
    new_root_ptr = calculated_poststate_ptr;
  }
  eth2_savePostStateRoot(new_root_ptr);



  return 1;
}



function verifyMultiproof(input_decoded: RLPData): usize {

  let accounts_sequence_encoded = input_decoded.children[0]; // accounts array to be further decoded
  let hashes_data = input_decoded.children[1].buffer; // 32-byte hashes, simply concatenated
  let multiproof_opcodes = input_decoded.children[2].buffer;

  let hashes_data_start_ptr = (hashes_data.buffer as usize) + hashes_data.byteOffset;

  let accounts_sequence = decode(accounts_sequence_encoded.buffer).children;

  const LEAF: u8 = 0x80;
  const BRANCHHASH: u8 = 0x81;
  const HASHES: u8 = 0x82;


  let pc: i32 = 0;

  // seq counters track how much of the input data has been read
  let accounts_seq_i = 0;
  let hashes_seq_i = 0;

  // stack will hold pointers to memory locations
  let multiproofStack = new Uint32Array(100);
  let stackTop = 0;

  while (pc < multiproof_opcodes.length) {

    let opcode: u8 = multiproof_opcodes[pc];
    pc++;

    switch (opcode) {
      case LEAF:
        // hash the leaf and push hash onto stack
        let leaf_node = accounts_sequence[accounts_seq_i].buffer;
        accounts_seq_i += 1;
        //debug_mem((leaf_node.buffer as usize) + leaf_node.byteOffset, leaf_node.byteLength);

        // leaf operand is the key length for the account leaf
        // key lenght might be useful for verifying an exclusion proof for a new leaf
        // TODO: handle new leaf / exclusion proof

        let leafHashOutput = new ArrayBuffer(32);
        let leafHashOutputPtr = changetype<usize>(leafHashOutput);
        ethash_keccak256(leafHashOutputPtr, (leaf_node.buffer as usize) + leaf_node.byteOffset, leaf_node.byteLength);
        //debug_mem(leafHashOutputPtr, 32);

        let leaf_node_obj = new Node(NodeType.Leaf, null, leaf_node);
        Trie.set(leafHashOutputPtr, leaf_node_obj);

        multiproofStack[stackTop] = leafHashOutputPtr;
        stackTop++;

        pc++; // advance pc past leaf operand
        break;



      case BRANCHHASH:
        // construct branch node for RLP encoder

        let branch_num_children = (multiproof_opcodes[pc] as i32);
        pc++; // advance past length byte (number of branch children)

        // first pop all the hash pointers off the stack, so we can process them in ascending order
        let child_indexes = new Array<u8>(branch_num_children);
        for (let i = 0; i < branch_num_children; i++) {
          // read child index
          child_indexes[i] = (multiproof_opcodes[pc] as u8);
          pc++; // advance pc only branch_num_children times
        }

        // reverse the child indexes and hashes, keeps `while (i < 17)` loop and offset numbers simpler
        // TODO: tweak multiproof format so we don't have to do this
        let child_indexes_ascending = new Array<u8>(branch_num_children);
        let child_hash_ptrs = new Array<usize>(branch_num_children);
        for (let i = 0; i < branch_num_children; i++) {
          let reverse_i = branch_num_children - 1 - i;
          child_indexes_ascending[i] = child_indexes[reverse_i];

          // pop child hash off the stack
          stackTop--;
          child_hash_ptrs[reverse_i] = multiproofStack[stackTop];
        }


        /* *** using RLPData *****/
        /*
        let branch_template = Array.create<RLPData>(17);
        let branch_node = new RLPData(null, branch_template);

        for (let i = 0; i < 17; i++) {
          branch_node.children.push(new RLPData(null, Array.create<RLPData>(0)));
        }

        for (let i = 0; i < branch_num_children; i++) {
          let branch_child_bytes = new Uint8Array(32);
          //debug_mem(child_hash_ptrs[i], 32);
          memory.copy((branch_child_bytes.buffer as usize) + branch_child_bytes.byteOffset, child_hash_ptrs[i], 32);
          //debug_mem((branch_child_bytes.buffer as usize) + branch_child_bytes.byteOffset, branch_child_bytes.byteLength);

          branch_node.children[branch_index] = new RLPData(branch_child_bytes, null);
        }

        let encoded_branch = encode(branch_node);
        //debug_mem((encoded_branch.buffer as usize) + encoded_branch.byteOffset, encoded_branch.byteLength);

        let branchHashOutput = new ArrayBuffer(32);
        let branchHashOutputPtr = changetype<usize>(branchHashOutput);
        ethash_keccak256(branchHashOutputPtr, (encoded_branch.buffer as usize) + encoded_branch.byteOffset, encoded_branch.byteLength);
        //debug_mem(branchHashOutputPtr, 32);
        */


        /* *** using RLPBranchNode *****/
        let branch_node_optim = new RLPBranchNode(new Array<usize>(17), null);

        for (let i = 0; i < branch_num_children; i++) {
          let branch_index = child_indexes_ascending[i];
          branch_node_optim.children[branch_index] = child_hash_ptrs[i];
        }

        let branch_node_obj = new Node(NodeType.Branch, branch_node_optim, null);
        let branchHashOutputPtr = hashBranchNode(branch_node_optim.children);


        Trie.set(branchHashOutputPtr, branch_node_obj);

        multiproofStack[stackTop] = branchHashOutputPtr;
        stackTop++;

        break;

      case HASHES:
        // pulls hashes from the input data and puts them on the stack
        let hashes_operand = (multiproof_opcodes[pc] as i32);
        pc++; // advance pc past hashes operand
        for (let i = 0; i < hashes_operand; i++) {
          let hash_ptr = hashes_data_start_ptr + hashes_seq_i*32;
          hashes_seq_i += 1;
          multiproofStack[stackTop] = hash_ptr;
          stackTop++;
        }

        break;


      default:
        break;
    }

  }


  let verified_prestate_root_ptr = multiproofStack[stackTop - 1];
  return verified_prestate_root_ptr

}




function insertNewLeafNewBranch(prestate_root_hash_ptr: usize, new_leaf_key_nibbles: Array<u8>, new_leaf_account_rlp: Uint8Array): void {

  let currentNode = Trie.get(prestate_root_hash_ptr);

  // hash current_node for debug test
  //let hashOutput = new ArrayBuffer(32);
  //let hashOutputPtr = changetype<usize>(hashOutput);
  //debug(8891);

  //let encoded_node = encode(current_node.bodyrlp);
  //debug(8892);

  //ethash_keccak256(hashOutputPtr, (encoded_node.buffer as usize) + encoded_node.byteOffset, encoded_node.byteLength);
  //debug(8899);
  //debug_mem(hashOutputPtr, 32);


  // current_node.bodyrlp

  // pathStack could be smaller than 40
  let pathStack = Array.create<usize>(40);
  pathStack.push(prestate_root_hash_ptr);



  for (let k_i=0; k_i<40; k_i++) {
    let branch_index_i = new_leaf_key_nibbles[k_i];

    if (currentNode.type == NodeType.Leaf) {
      createNewBranchWhereLeafExists(new_leaf_account_rlp, new_leaf_key_nibbles, k_i, currentNode, pathStack);
      return;
    } else if (currentNode.type == NodeType.Branch) {
      if (currentNode.branchBody.dirty == null) {
        currentNode.branchBody.dirty = Array.create<u8>(16);

        // setting the dirty flag to an empty array indicates that no children are dity but the branch node itself needs to be rehashed
        // explanation:
        //   if the next node is a leaf, then it will be converted into a new child branch node with two leafs underneath it (the existing leaf and the new leaf)
        //   the new child branch won't be dirty, since it will be created with the new hash
        //   the current branch (i.e. the parent of the new branch) will have the new hash inserted into the branch index
      }

      let next_node_in_path_hash_ptr = currentNode.branchBody.children[branch_index_i];
      // if next_node_in_path_hash_ptr is 0, then the child is empty

      //debug_mem(next_node_in_path_hash_ptr, 32);


      if (next_node_in_path_hash_ptr == 0) {
        // end of path is an already existing branch node
        // can just insert the leaf into the branch
        throw new Error('Dont yet handle inserting a leaf into an already existing branch (but its easy) ')
      }

      pathStack.push(next_node_in_path_hash_ptr);
      // next node in path is either a leaf or a branch
      let nextNodeInPath = Trie.get(next_node_in_path_hash_ptr);

      // TODO: we already check this types ni the for loop.. merge the logic?
      if (nextNodeInPath.type == NodeType.Branch) {
          // keep walking...
          currentNode.branchBody.dirty.push(branch_index_i);
          currentNode = nextNodeInPath;
        } else if (nextNodeInPath.type == NodeType.Leaf) {
          // next node is a leaf, and so is last node in the path
          // next step will create the new branch node
          currentNode = nextNodeInPath;
        } else {
          throw new Error('extension nodes are unimplemented!')
        }

    } else {
      throw new Error('extension nodes are unimplemented.')
    }

  } // end for loop

}



function createNewBranchWhereLeafExists(new_leaf_account_rlp: Uint8Array, new_key_nibbles: Array<u8>, k_i: u32, existingLeafNode: Node, pathStack: Array<usize>): void {
  //debug_mem((new_leaf_account_rlp.buffer as usize) + new_leaf_account_rlp.byteOffset, new_leaf_account_rlp.byteLength);


  let existing_leaf_key_value = decode(existingLeafNode.leafBody as Uint8Array);
  let existing_leaf_value = existing_leaf_key_value.children[1].buffer;
  //debug_mem((existing_leaf_value.buffer as usize) + existing_leaf_value.byteOffset, existing_leaf_value.byteLength);

  let existing_leaf_key_nibbles = uintArrToNibbleArr(existing_leaf_key_value.children[0].buffer);
  existing_leaf_key_nibbles = removeHexPrefix(existing_leaf_key_nibbles);

  if (new_key_nibbles[k_i] == existing_leaf_key_nibbles[0]) {
    throw new Error('TODO: handle extension node insertion')
  }

  // recreate existing leaf

  let new_key_for_existing_leaf_nibbles = existing_leaf_key_nibbles;
  // first nibble of the existing leaf key becomes its branch index in the new branch
  let branch_index_for_existing_leaf = new_key_for_existing_leaf_nibbles.shift()

  let new_key_for_existing_leaf = nibbleArrToUintArr(addHexPrefix(new_key_for_existing_leaf_nibbles, true));


  let new_node_for_existing_leaf_rlp_children = Array.create<RLPData>(2);

  new_node_for_existing_leaf_rlp_children.push(new RLPData(null, Array.create<RLPData>(0)));
  new_node_for_existing_leaf_rlp_children.push(new RLPData(null, Array.create<RLPData>(0)));
  new_node_for_existing_leaf_rlp_children[0].buffer = new_key_for_existing_leaf;
  new_node_for_existing_leaf_rlp_children[1].buffer = existing_leaf_value;
  let new_node_for_existing_leaf_rlp = new RLPData(null, new_node_for_existing_leaf_rlp_children);
  let new_node_for_existing_leaf = encode(new_node_for_existing_leaf_rlp);

  let new_hash_for_existing_leaf_buffer = new ArrayBuffer(32);
  let new_hash_for_existing_leaf_ptr = changetype<usize>(new_hash_for_existing_leaf_buffer);

  ethash_keccak256(new_hash_for_existing_leaf_ptr, (new_node_for_existing_leaf.buffer as usize) + new_node_for_existing_leaf.byteOffset, new_node_for_existing_leaf.byteLength);
  //debug_mem(new_hash_for_existing_leaf_ptr, 32);


  let new_node_for_existing_leaf_obj = new Node(NodeType.Leaf, null, new_node_for_existing_leaf);
  Trie.set(new_hash_for_existing_leaf_ptr, new_node_for_existing_leaf_obj);

  // create new leaf

  let branch_index_for_new_leaf = new_key_nibbles[k_i];
  let key_for_new_leaf = nibbleArrToUintArr(addHexPrefix(new_key_nibbles.slice(k_i+1), true));
  
  let node_for_new_leaf_rlp_children = Array.create<RLPData>(2);

  node_for_new_leaf_rlp_children.push(new RLPData(null, Array.create<RLPData>(0)));
  node_for_new_leaf_rlp_children.push(new RLPData(null, Array.create<RLPData>(0)));
  node_for_new_leaf_rlp_children[0].buffer = key_for_new_leaf;
  node_for_new_leaf_rlp_children[1].buffer = new_leaf_account_rlp;
  let node_for_new_leaf_rlp = new RLPData(null, node_for_new_leaf_rlp_children);
  let node_for_new_leaf = encode(node_for_new_leaf_rlp);

  let hash_for_new_leaf_buffer = new ArrayBuffer(32);
  let hash_for_new_leaf_ptr = changetype<usize>(hash_for_new_leaf_buffer);

  ethash_keccak256(hash_for_new_leaf_ptr, (node_for_new_leaf.buffer as usize) + node_for_new_leaf.byteOffset, node_for_new_leaf.byteLength);
  //debug_mem(hash_for_new_leaf_ptr, 32);

  let node_for_new_leaf_obj = new Node(NodeType.Leaf, null, node_for_new_leaf);
  Trie.set(hash_for_new_leaf_ptr, node_for_new_leaf_obj);

  // both leafs created. now create new branch node.

  let new_branch_node = new RLPBranchNode(new Array<usize>(17), null);

  new_branch_node.children[branch_index_for_existing_leaf] = new_hash_for_existing_leaf_ptr;
  new_branch_node.children[branch_index_for_new_leaf] = hash_for_new_leaf_ptr;


  let new_branch_hash_ptr = hashBranchNode(new_branch_node.children);
  let new_branch_node_obj = new Node(NodeType.Branch, new_branch_node, null);
  Trie.set(new_branch_hash_ptr, new_branch_node_obj);

  // now we have a new branch node. but we need to replace the pointer in the parent branch node
  // parent branch node previously pointed to a leaf
  // in the updated trie, it should point to the new branch node


  let parent_branch_hash_ptr = pathStack[pathStack.length-2];

  let parentBranchNode = Trie.get(parent_branch_hash_ptr);

  let new_branch_node_parent_index = new_key_nibbles[k_i-1];

  parentBranchNode.branchBody.children[new_branch_node_parent_index] = new_branch_hash_ptr;
  //Trie.set(parent_branch_hash_ptr, parentBranchNode);
  // TODO: do we need to reset it with Trie.set?

  return;
}



function rehashNode(staleHashPtr: usize): usize {
  // accepts a hash pointer, returns a pointer to the new hash

  //debug_mem(staleHashPtr, 32);
  // lookup the new node using the stale hash
  let node_with_stale_hash = Trie.get(staleHashPtr);
  if (node_with_stale_hash.type == NodeType.Leaf) {
    throw new Error('TODO: handle dirty leaf');
  }

  if (node_with_stale_hash.type == NodeType.Branch) {
    // recurse on dirty children
    let dirty_indexes = node_with_stale_hash.branchBody.dirty;
    if (dirty_indexes == null)  {
      throw new Error('ERROR: called rehash on a branch node that has no dirty flag');
    }

    for (let i = 0; i < dirty_indexes.length; i++) {
      let dirty_i = dirty_indexes[i];
      let stale_hash_for_dirty_child_ptr = node_with_stale_hash.branchBody.children[dirty_i];
      let new_hash_for_dirty_child_ptr = rehashNode(stale_hash_for_dirty_child_ptr);
      node_with_stale_hash.branchBody.children[dirty_i] = new_hash_for_dirty_child_ptr;
    }

    // if drity_indexes.length == 0, no dirty children (only new children already hashed)
    // branch node itself needs to be rehashed

    // TODO: check if renaming does a deep copy or shallow
    //let new_branch_node = node_with_stale_hash;

    // all child hashes have been updated, so clear the dirty flag
    //node_with_stale_hash.dirty = null

    let new_branch_hash_ptr = hashBranchNode(node_with_stale_hash.branchBody.children);

    Trie.set(new_branch_hash_ptr, node_with_stale_hash);
    return new_branch_hash_ptr;
  }

  // TODO: handle extension nodes
  throw new Error('only branch nodes and leaf nodes are implemented');
}



function removeHexPrefix(nib_arr: Array<u8>): Array<u8> {
  // the hex prefix is merkle-patricia-trie encoding, not RLP
  if (nib_arr[0] % 2) {
    return nib_arr.slice(1);
  } else {
    return nib_arr.slice(2);
  }
}


function addHexPrefix(key_nib_arr: Array<u8>, terminator: bool): Array<u8> {
  if (key_nib_arr.length % 2) {
    // odd
    key_nib_arr.unshift(1);
  } else {
    // even
    key_nib_arr.unshift(0);
    key_nib_arr.unshift(0);
  }

  if (terminator) {
    key_nib_arr[0] += 2;
  }

  return key_nib_arr;
}



function u8ArrToNibbleArr(u8_arr: Array<u8>): Array<u8> {
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


function uintArrToNibbleArr(uint_arr: Uint8Array): Array<u8> {
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


function nibbleArrToUintArr(arr: Array<u8>): Uint8Array {
  let buf = new Uint8Array(arr.length / 2);

  for (let i = 0; i < buf.length; i++) {
    let q = i * 2;
    buf[i] = (arr[q] << 4) + arr[++q];
  }

  return buf;
}

