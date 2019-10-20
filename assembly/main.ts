import { ethash_keccak256 } from "./keccak"
import {
  hashBranchNode,
  RLPBranchNode,
  RLPData,
  decode,
  encode,
  hashExtension,
  hashBranch,
  encodeLeaf,
  encodeAccount,
  decodeAccount
} from "./rlp"
import { parseU8, padBuf, cmpBuf, stripBuf, hash, nibbleArrToUintArr, addHexPrefix, uintArrToNibbleArr, removeHexPrefix } from './util'
import { debug, debugMem } from './debug'

import {
  eth2_blockDataSize,
  eth2_blockDataCopy,
  eth2_loadPreStateRoot,
  eth2_savePostStateRoot,
  bignum_add256,
  bignum_sub256
} from './env'


import { interpret } from "./evm"

export enum Opcode {
  Branch = 0,
  Hasher = 1,
  Leaf = 2,
  Extension = 3,
  Add = 4,
}

export enum NodeType {
  Branch = 0,
  Leaf = 1,
  Extension = 2,
  Hash = 3,
}

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

export function main(): void {
  // INPUT 1: pre-state root
  let preStateRootBuf = new ArrayBuffer(32)
  let preStateRoot = Uint8Array.wrap(preStateRootBuf, 0, 32)
  eth2_loadPreStateRoot(preStateRootBuf as usize)
  
  // INPUT 2: proof data from the EEI
  let blockDataSize = eth2_blockDataSize()
  let blockDataBuf = new ArrayBuffer(blockDataSize)
  eth2_blockDataCopy(blockDataBuf as usize, 0, blockDataSize)
  let blockData = Uint8Array.wrap(blockDataBuf, 0, blockDataSize)

  let postStateRoot = processBlock(preStateRoot, blockData)

  eth2_savePostStateRoot(postStateRoot.buffer as usize + postStateRoot.byteOffset)
}

export function processBlock(preStateRoot: Uint8Array, blockData: Uint8Array): Uint8Array {
  // input data is RLP
  let input_decoded = decode(blockData);
  // input_decoded is type RLPData: { buffer: Uint8Array, children: RLPData[] }
  // [txes, addrs, codeHashes, bytecode, hashes, leaves, instructions]
  
  let hash1: Uint8Array = new Uint8Array(0)
  if (input_decoded.children[2].buffer.length !== 0) {
    hash1 = input_decoded.children[2].children[0].buffer
  }
  
  let txes = input_decoded.children[0].children       // txes
  let addrs = input_decoded.children[1].children      // addrs
  let codeHashes = input_decoded.children[2].children // codeHashes
  let bytecode = input_decoded.children[3].children   // bytecode
  let hashes = input_decoded.children[4].children     // hashes
  let leafKeys = input_decoded.children[5].children   // leaves
  let accounts = input_decoded.children[6].children   // accounts
  
  // Instructions are flat-encoded
  let instructions = input_decoded.children[7].buffer // instructions

  if (addrs.length !== leafKeys.length || addrs.length !== accounts.length) {
    throw new Error('invalid multiproof')
  }
  let updatedAccounts = new Array<Uint8Array | null>(accounts.length)
  
  for (let i = 0; i < txes.length; i++) {
    let tx = txes[i]
    // [toIdx, value, nonce, fromIdx]
    let toIdx = parseU8(tx.children[0].buffer)
    let fromIdx = parseU8(tx.children[3].buffer)
    let value = tx.children[1].buffer
    let nonce = tx.children[2].buffer

    // TODO: Hash unsigned tx, recover from address, check against fromIdx
    let fromAccountRaw = accounts[fromIdx].buffer
    // If `from` has been modified by previous txes
    // load the updated one.
    if (updatedAccounts[fromIdx] != null) {
      fromAccountRaw = updatedAccounts[fromIdx] as Uint8Array
    }

    let toAccountRaw = accounts[toIdx].buffer
    if (updatedAccounts[toIdx] != null) {
      toAccountRaw = updatedAccounts[toIdx] as Uint8Array
    }

    let fromAccount = decodeAccount(fromAccountRaw)
    let toAccount = decodeAccount(toAccountRaw)

    // Sender's nonce should match tx's nonce
    if (cmpBuf(fromAccount[0], nonce) != 0) {
      throw new Error('Invalid nonce')
    }

    // Sender has enough balance
    if (cmpBuf(fromAccount[1], value) == -1) {
      throw new Error('Insufficient funds')
    }

    // Update nonce and balances
    value = padBuf(value, 32)
    let fromBalance = padBuf(fromAccount[1], 32)
    let newFromBalance = new ArrayBuffer(32)
    bignum_sub256(fromBalance.buffer as usize, value.buffer as usize, newFromBalance as usize)

    let toBalance = padBuf(toAccount[1], 32)
    let newToBalance = new ArrayBuffer(32)
    bignum_add256(toBalance.buffer as usize, value.buffer as usize, newToBalance as usize)

    let paddedNonce = padBuf(nonce, 32)
    let fromNonce = padBuf(fromAccount[0], 32)
    let newFromNonce = new ArrayBuffer(32)
    let one256 = new ArrayBuffer(32)
    let onedv = new DataView(one256)
    onedv.setUint8(31, 1)
    bignum_add256(fromNonce.buffer as usize, one256 as usize, newFromNonce as usize)

    // Encode updated accounts
    let newFromAccount = encodeAccount(stripBuf(Uint8Array.wrap(newFromNonce)), stripBuf(Uint8Array.wrap(newFromBalance)))
    let newToAccount = encodeAccount(toAccount[0], stripBuf(Uint8Array.wrap(newToBalance)))

    updatedAccounts[fromIdx] = newFromAccount
    updatedAccounts[toIdx] = newToAccount

    
    // check if to account is contract
    if (isContract(toAccount)) {
      let code = getCode(toAccount, codeHashes, bytecode)
      interpret(code)                  // TODO: interpret code, interpret function should be on its own module
    }
    //printCodeHash(toAccount)
  }

  let keys = Array.create<Uint8Array>(addrs.length)
  for (let i = 0; i < addrs.length; i++) {
    keys.push(hash(addrs[i].buffer))
  }


  let postStateRoot = verifyMultiproofAndUpdate(preStateRoot, hashes, leafKeys, accounts, updatedAccounts as Uint8Array[], instructions, keys)

  return postStateRoot


  /*
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
  */
}

class StackItem {
  constructor(
    public kind: NodeType,
    public pathIndices: Array<usize>,
    public hash: Uint8Array | null,
    public sponge: Array<Uint8Array | null> | null,
    public newHash: Uint8Array | null,
    public newSponge: Array<Uint8Array | null> | null,
  ) {}

}

function verifyMultiproofAndUpdate(
  preStateRoot: Uint8Array,
  hashes: RLPData[],
  leafKeys: RLPData[],
  accounts: RLPData[],
  updatedAccounts: Uint8Array[],
  instructions: Uint8Array,
  keys: Uint8Array[]
): Uint8Array {
  let pc = 0
  let hashIdx = 0
  let leafIdx = 0
  let stack = Array.create<StackItem>(100)
  let stackTop = 0

  let paths = Array.create<Array<u8>>(leafKeys.length)
  for (let i = 0; i < leafKeys.length; i++) {
    paths[i] = new Array<u8>()
  }


  while (pc < instructions.length) {
    let op = instructions[pc++]
    switch (op) {
    case Opcode.Hasher:
        if (hashIdx >= hashes.length) {
          throw new Error('Not enough hashes in multiproof')
        }
        let h = hashes[hashIdx++].buffer
        stack[stackTop++] = new StackItem(NodeType.Hash, [], h, null, h, null)
        break
    case Opcode.Leaf:
        if (leafIdx >= leafKeys.length) {
          throw new Error('Not enough leaves in multiproof')
        }
        let path = removeHexPrefix(uintArrToNibbleArr(leafKeys[leafIdx].buffer))
        paths[leafIdx] = path
        let l = encodeLeaf(leafKeys[leafIdx].buffer, accounts[leafIdx].buffer)
        let ul = encodeLeaf(leafKeys[leafIdx].buffer, updatedAccounts[leafIdx])
        leafIdx++
        let h = hash(l)
        let nh = hash(ul)
        stack[stackTop++] = new StackItem(NodeType.Leaf, [leafIdx - 1], h, null, nh, null)
        break
    case Opcode.Branch:
        let idx = instructions[pc++]
        let n = stack[--stackTop]

        let children = new Array<Uint8Array | null>(17)
        let newChildren = new Array<Uint8Array | null>(17)
        let ch: Uint8Array
        let nch: Uint8Array
        if (n.kind == NodeType.Branch) {
          ch = hashBranch(n.sponge as Array<Uint8Array | null>)
          nch = hashBranch(n.newSponge as Array<Uint8Array | null>)
        } else {
          ch = n.hash as Uint8Array
          nch = n.newHash as Uint8Array
        }
        children[idx] = ch
        newChildren[idx] = nch

        stack[stackTop++] = new StackItem(NodeType.Branch, n.pathIndices.slice(0), null, children, null, newChildren)
        for (let i = 0; i < n.pathIndices.length; i++) {
          paths[n.pathIndices[i]].unshift(idx)
        }
        break
    case Opcode.Extension:
        let nibblesLen = instructions[pc++]
        let nibbles = Array.create<u8>(nibblesLen)
        for (let i = 0; i < (nibblesLen as i32); i++) {
          nibbles[i] = instructions[pc + i]
        }
        pc += nibblesLen

        let n = stack[--stackTop]
        let childHash: Uint8Array
        let newChildHash: Uint8Array
        if (n.kind == NodeType.Branch) {
          childHash = hashBranch(n.sponge as Array<Uint8Array | null>)
          newChildHash = hashBranch(n.newSponge as Array<Uint8Array | null>)
        } else {
          childHash = n.hash as Uint8Array
          newChildHash = n.newHash as Uint8Array
        }

        let key = nibbleArrToUintArr(addHexPrefix(nibbles, false))
        let h = hashExtension(key, childHash)
        let nh = hashExtension(key, newChildHash)

        stack[stackTop++] = new StackItem(NodeType.Extension, n.pathIndices.slice(0), h, null, nh, null)
        for (let i = 0; i < n.pathIndices.length; i++) {
          paths[n.pathIndices[i]] = nibbles.concat(paths[n.pathIndices[i]])
        }
        break
    case Opcode.Add:
        let n1 = stack[--stackTop]
        let n2 = stack[--stackTop]
        let idx = instructions[pc++]

        if (n2.kind != NodeType.Branch) {
          throw new Error('Expected branch on top of stack')
        }

        let childHash: Uint8Array
        let newChildHash: Uint8Array
        if (n1.kind == NodeType.Branch) {
          childHash = hashBranch(n1.sponge as Array<Uint8Array | null>)
          newChildHash = hashBranch(n1.newSponge as Array<Uint8Array | null>)
        } else {
          childHash = n1.hash as Uint8Array
          newChildHash = n1.newHash as Uint8Array
        }

        for (let i = 0; i < n1.pathIndices.length; i++) {
          let pathIdx = n1.pathIndices[i]
          if (!n2.pathIndices.includes(pathIdx)) {
            n2.pathIndices.push(pathIdx)
          }
        }
        n2.sponge[idx] = childHash
        n2.newSponge[idx] = newChildHash
        stack[stackTop++] = n2

        for (let i = 0; i < n1.pathIndices.length; i++) {
          paths[n1.pathIndices[i]].unshift(idx)
        }
        break
    }
  }

  let r = stack[stackTop - 1]
  let rootHash: Uint8Array
  let newRootHash: Uint8Array
  if (r.kind == NodeType.Branch) {
    rootHash = hashBranch(r.sponge as Array<Uint8Array | null>)
    newRootHash = hashBranch(r.newSponge as Array<Uint8Array | null>)
  } else {
    rootHash = r.hash as Uint8Array
    newRootHash = r.newHash as Uint8Array
  }

  if (cmpBuf(rootHash, preStateRoot) != 0) {
    throw new Error('invalid root hash')
  }

  // Verify given keys match computed paths
  for (let i = 0; i < paths.length; i++) {
    let path = nibbleArrToUintArr(paths[i])
    if (cmpBuf(path, keys[i]) != 0) {
      throw new Error('invalid key')
    }
  }

  return newRootHash
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

function isContract(account: Array<Uint8Array>): bool {
  let emptyBuf = Array.create<u8>(32)
  emptyBuf = [197, 210, 70, 1, 134, 247, 35, 60, 146, 126, 125, 178, 220, 199, 3, 192, 229, 0, 182, 83, 202, 130, 39, 59, 123, 250, 216, 4, 93, 133, 164, 112]
  let empty = Uint8Array.wrap(emptyBuf.buffer, 0, 32)

  
  if (eqBuffer(account[3], empty)) {
    return false
  } else {
    return true
  }

}

function eqBuffer(buff1: Uint8Array, buff2: Uint8Array): bool {
  if (buff1.length != buff2.length)
    return false

  for (let i = 0; i < buff1.length; i++) {
    if (buff1[i] != buff2[i])
      return false
  }

  return true
}

function getCode(account: Array<Uint8Array>, codeHashes: RLPData[], bytecode: RLPData[]): Uint8Array {
  let codeHash = account[3]
  let index = -1

  for (let i = 0; i < codeHashes.length; i++) {
    if (eqBuffer(codeHash, codeHashes[i].buffer)) {
      index = i
      break
    }
  }

  if (index >= 0) {
    return bytecode[index].buffer
  } else {
    return new Uint8Array(0)
  }
}
