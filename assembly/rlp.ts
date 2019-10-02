// RLP code is taken from https://github.com/nearprotocol/assemblyscript-rlp
import { ethash_keccak256 } from './keccak'
import { hash } from './util'

export class RLPBranchNode {
  constructor(
    public children: Array<usize>,
    public dirty: Array<u8> | null,
  ) {}
}

const defaultStateRoot: u8[] = [
  86, 232, 31, 23, 27, 204, 85, 166, 255, 131, 69, 230, 146, 192, 248, 110, 91, 72, 224, 27, 153, 108, 173, 192, 1, 98, 47, 181, 227, 99, 180, 33
]
const defaultCodeHash: u8[] = [
  197, 210, 70, 1, 134, 247, 35, 60, 146, 126, 125, 178, 220, 199, 3, 192, 229, 0, 182, 83, 202, 130, 39, 59, 123, 250, 216, 4, 93, 133, 164, 112
]


export function decodeAccount(buf: Uint8Array): Array<Uint8Array> {
  // Data will have length > 55
  // buf[0] == 0xf8
  let dataLen = buf[1]

  let nonce: Uint8Array
  let nonceLen = buf[2]
  let offset = 3
  if (nonceLen == 0x80) {
    nonce = new Uint8Array(0)
  } else if (nonceLen <= 0x7f) {
    nonce = buf.subarray(2, 3)
  } else {
    nonce = buf.subarray(3, 3 + nonceLen - 0x80)
    offset = 3 + nonceLen - 0x80
  }

  let balance: Uint8Array
  let balanceFirstByte = buf[offset]
  if (balanceFirstByte == 0x80) {
    balance = new Uint8Array(0)
    offset++
  } else if (balanceFirstByte <= 0x7f) {
    balance = buf.subarray(offset, offset + 1)
    offset++
  } else {
    offset++
    balance = buf.subarray(offset, offset + balanceFirstByte - 0x80)
    offset = offset + balanceFirstByte - 0x80
  }

  // stateRoot and codeHash are 32 byte hashes
  offset++
  let stateRoot = buf.subarray(offset, offset + 32)
  offset += 33
  let codeHash = buf.subarray(offset, offset + 32)

  return [nonce, balance, stateRoot, codeHash]
}

export function encodeAccount(nonce: Uint8Array, balance: Uint8Array): Uint8Array {
  // Nonce and balance are buffers with 0 <= length <= 32
  // We assume stateRoot and codeHash to be constant hashes
  let nonceLen = nonce.length <= 1 ? 1 : nonce.length + 1
  let balanceLen = balance.length <= 1 ? 1 : balance.length + 1
  let dataLen = nonceLen + balanceLen + 33 + 33

  let buf = new Uint8Array(2 + dataLen)
  buf[0] = 0xf8
  buf[1] = dataLen
  let offset = 2

  if (nonce.length == 0) {
    buf[offset++] = 0x80
  } else if (nonce.length == 1) {
    buf[offset++] = nonce[0]
  } else {
    buf[offset++] = 0x80 + nonce.length as u8
    memory.copy(buf.buffer as usize + buf.byteOffset + offset, nonce.buffer as usize + nonce.byteOffset, nonce.length)
    offset += nonce.length
  }

  if (balance.length == 0) {
    buf[offset++] = 0x80
  } else if (balance.length == 1) {
    buf[offset++] = balance[0]
  } else {
    buf[offset++] = 0x80 + balance.length as u8
    memory.copy(buf.buffer as usize + buf.byteOffset + offset, balance.buffer as usize + balance.byteOffset, balance.length)
    offset += balance.length
  }

  // The first value in an array reference is a pointer
  // to the backing buffer. See the memory layout of arrays for more info.
  let defaultStateRootPtr: usize = load<usize>(defaultStateRoot as usize)
  buf[offset++] = 0xa0 // 0x80 + 0x20
  memory.copy(buf.buffer as usize + buf.byteOffset + offset, defaultStateRootPtr, 32)
  offset += 32

  let defaultCodeHashPtr: usize = load<usize>(defaultCodeHash as usize)
  buf[offset++] = 0xa0
  memory.copy(buf.buffer as usize + buf.byteOffset + offset, defaultCodeHashPtr, 32)

  return buf
}

export function encodeLeaf(key: Uint8Array, value: Uint8Array): Uint8Array {
  // Key is buffer with 1 < length < 32
  // Value is a buffer with 64 <= length <= 128
  let keyBufLen: u8 = key.length == 1 ? 1 : key.length as u8 + 1
  let valueBufLen: u8 = value.length as u8 + 2
  let dataLen: u8 = keyBufLen + valueBufLen

  // We need 1 byte to express length of length
  // and 1 byte to express length of list
  let buf = new Uint8Array(2 + dataLen)
  buf[0] = 0xf8
  buf[1] = dataLen
  let offset = 2

  // Encode key
  if (key.length == 1) {
    buf[offset++] = key[0]
  } else {
    buf[offset++] = 0x80 + key.length
    memory.copy(buf.buffer as usize + buf.byteOffset + offset, key.buffer as usize + key.byteOffset, key.length)
    offset += key.length
  }

  // Encode value
  buf[offset++] = 0xb8
  buf[offset++] = value.length as u8
  memory.copy(buf.buffer as usize + buf.byteOffset + offset, value.buffer as usize + value.byteOffset, value.length)

  return buf
}

export function hashExtension(key: Uint8Array, value: Uint8Array): Uint8Array {
  // Key is buffer with 1 < length < 32
  // Value is a hash with length == 32
  // If key.length >= 21, then rlp structure changes

  // Each buffer with length < 55 needs 1 byte of metadata (0x80 + length)
  let keyBufLen: u8 = key.length == 1 ? 1 : key.length as u8 + 1
  let dataLen: u8 = keyBufLen + 33

  let buf: Uint8Array
  let offset: u8 = 0
  if (dataLen > 55) {
    // We need 1 byte to express length of length
    // and 1 byte to express length of list
    buf = new Uint8Array(2 + dataLen)
    buf[0] = 0xf8
    buf[1] = dataLen
    offset = 2
  } else {
    // We need 1 byte to express list's length
    buf = new Uint8Array(1 + dataLen)
    buf[0] = 0xc0 + dataLen
    offset = 1
  }

  // Encode key
  if (key.length == 1) {
    buf[offset++] = key[0]
  } else {
    buf[offset] = 0x80 + key.length
    memory.copy(buf.buffer as usize + buf.byteOffset + offset, key.buffer as usize + key.byteOffset, key.length)
    offset += keyBufLen
  }

  // Encode value
  buf[offset++] = 0xa0 // 0x80 + 0x20
  memory.copy(buf.buffer as usize + buf.byteOffset + offset, value.buffer as usize + value.byteOffset, 32)

  return hash(buf)
}

export function hashBranch(children: Array<Uint8Array | null>): Uint8Array {
  let dataLen: u32 = 0
  for (let i = 0; i < 17; i++) {
    let c = children[i]
    if (c == null) {
      dataLen++
    } else {
      if (c.length == 32) {
        // Needs 1 byte for encoding length and 32 bytes of data
        dataLen += 33
      } else {
        throw new Error('Invalid branch child')
      }
    }
  }

  // How many bytes do we need to encode length?
  let lenOfLen = dataLen > 255 ? 2 : 1
  let totalLen = 1 + lenOfLen + dataLen
  let buf = new Uint8Array(totalLen)
  let offset = 0
  buf[0] = 0xf7 + lenOfLen
  if (lenOfLen == 1) {
    buf[1] = dataLen
    offset = 2
  } else {
    let dv = new DataView(buf.buffer)
    dv.setUint16(1, dataLen as u16)
    offset = 3
  }

  for (let i = 0; i < 17; i++) {
    let c = children[i]
    if (c == null) {
      buf[offset++] = 0x80
    } else {
      buf[offset++] = 0xa0 // 0x80 + 0x20
      memory.copy(buf.buffer as usize + buf.byteOffset + offset, c.buffer as usize + c.byteOffset, 32)
      offset += 32
    }
  }

  return hash(buf)
}

export function hashBranchNode(branchNodeChildren: Array<usize>): usize {
  // manually construct the encoded branch node
  /*
  // here's an encoded branch node with 4 child hashes:
  f891808080808080a09f48e0438e53d55e53bb935c4a80e294ff56055cc4b584635b4bafbf894226088080a04216caf9df3c72b105e86b5b75ecb16e09e4a6a718bb27b0b83ec6fd79bb6c0c80a0e17ee4374bd5002160209877201836362b93a75ce5813bf4789053dd613d22e08080a0b82fb32a26c22edc12788287a7d157a5be2443a4ea2a0722c77f5b995ef40d038080
  // it's 147 bytes. the 4 children are 32 * 4 == 128 bytes
  // the branch node is an RLP list of 17 elements, so 13 elements are empty. an empty element is `80`, so that's 13 bytes. 128 + 13 = 141 bytes.
  // that leaves 6 bytes for encoding (2 for 0xf891, 4 of 0xa0)
  f8 ;; RLP list over 55 bytes. length of byte length is (0xf8 - 0xf7 = 1)
  91 ;; list length = 145
  80 ;; branch index 0
  80 ;; 1
  80 ;; 2
  80 ;; branch index 3
  80 ;; branch index 4
  80 ;; branch index 5
  a0 ;; length of string is (0xa0 - 0x80) = 32
  9f48e0438e53d55e53bb935c4a80e294ff56055cc4b584635b4bafbf89422608 ;; hash at branch index 6
  80 ;; branch index 7
  80 ;; branch index 8
  a0 ;; length of string
  4216caf9df3c72b105e86b5b75ecb16e09e4a6a718bb27b0b83ec6fd79bb6c0c ;; branch index 9
  80 ;; branch index a
  a0
  e17ee4374bd5002160209877201836362b93a75ce5813bf4789053dd613d22e0 ;; branch index b
  80 ;; c
  80 ;; d
  a0
  b82fb32a26c22edc12788287a7d157a5be2443a4ea2a0722c77f5b995ef40d03 ;; branch index e
  80 ;; f
  80 ;; 17th element
  */

  // branch node will always have at least 2 children, so its length will always be at least 64 bytes
  // first byte of a branch node will be either f8 (<= 7 children) or f9 (>= 8 children)
  // two children: length is 81 bytes (0x51)
  // three children: length is 113 bytes (0x71)
  // four children: length is 145 bytes (0x91)
  // five children: length is 177 bytes (0xb1)

  // bytes for hashes = len(0xa0 + hash) = 33*branch_num_children
  // bytes for empty nodes (0x80) = (17 - branch_num_children)


  let child_indexes = Array.create<u8>(17);
  let child_hash_ptrs = Array.create<usize>(17);
  for (let i = 0; i < 17; i++) {
    // read child index
    if (branchNodeChildren[i] > 0) {
      child_indexes.push(i as u8);
      child_hash_ptrs.push(branchNodeChildren[i]);
    }
  }

  let branch_num_children = child_indexes.length;

  // allocate buffer for branch node
  let list_bytes_len = (33 * branch_num_children) + (17 - branch_num_children);
  let branch_node_bytes: usize;
  let branch_node_bytes_len: usize;
  let branch_node_datastart: usize;
  if (branch_num_children < 8) {
    //0xf8 + (list_len as u8) + bytes..
    branch_node_bytes = changetype<usize>(new ArrayBuffer(list_bytes_len + 2));
    branch_node_bytes_len = list_bytes_len + 2;
    store<u8>(branch_node_bytes, 0xf8);
    store<u16>(branch_node_bytes + 1, (list_bytes_len as u8));
    branch_node_datastart = branch_node_bytes + 2;
  } else {
    //0xf9 + (list_len as u16) + bytes..
    branch_node_bytes = changetype<usize>(new ArrayBuffer(list_bytes_len + 3));
    branch_node_bytes_len = list_bytes_len + 3;
    store<u8>(branch_node_bytes, 0xf9);
    store<u16>(branch_node_bytes + 1, bswap<u16>(list_bytes_len as u16));
    branch_node_datastart = branch_node_bytes + 3;
  }


  let children_copied = 0;
  let next_child: u8;

  let branch_node_offset = branch_node_datastart;
  let i: u8 = 0;
  while (i < 17) {

    if (children_copied < branch_num_children) {
      next_child = child_indexes[children_copied];
      // first insert all the 0x80's for empty slots
      if (i < next_child) {
        // TODO: maybe the check isn't necessary if memory.fill accepts 0 length inputs

        let num_empties = next_child - i;
        memory.fill(branch_node_offset, 0x80, num_empties);
        branch_node_offset = branch_node_offset + num_empties;

        i = next_child;
      }

      // could be optimized to reduce memory copying. might require a different sequence of opcodes / hashes
      // or using keccak.update() might be better

      // now copy the child
      // insert 0xa0 byte
      store<u8>(branch_node_offset, 0xa0);
      branch_node_offset++;
      // copy the child hash
      let child_hash_ptr = child_hash_ptrs[children_copied];
      memory.copy(branch_node_offset, child_hash_ptr, 32);
      branch_node_offset = branch_node_offset + 32;
      children_copied++;

    } else {
      // children_copied >= branch_num_children
      // we've copied all children and still haven't filled all 17 slots
      // copy empties to the end
      let num_empties = 17 - i;
      memory.fill(branch_node_offset, 0x80, num_empties);
      branch_node_offset = branch_node_offset + num_empties;
      break;
    }

    i = i + 1;
  }

  // branch node is constructed, now hash it and push hash back on stack

  //debug_mem(branch_node_bytes, branch_node_bytes_len);

  let branchHashOutputPtr = changetype<usize>(new ArrayBuffer(32));
  ethash_keccak256(branchHashOutputPtr, branch_node_bytes, branch_node_bytes_len);
  //debug_mem(branchHashOutputPtr, 32);

  return branchHashOutputPtr;
}


/**
 * class that represents data in rlp format. Due to the lack of support for recursive
 * data types, we have to use a class instead.
 */
export class RLPData {
    buffer: Uint8Array;
    children: RLPData[];

    constructor(input: Uint8Array | null, children: RLPData[] | null) {
        if (input) {
            this.buffer = input;
        } else {
            this.buffer = new Uint8Array(0);
        }

        if (children) {
            this.children = children;
        } else {
            this.children = new Array<RLPData>();
        }
    }
}

const hexAlphabet = '0123456789abcdef';

export class Decoded {
    data: RLPData;
    remainder: Uint8Array;

    constructor(data: RLPData, remainder: Uint8Array) {
        this.data = data;
        this.remainder = remainder;
    }
}

/**
 * Parse integers. Check if there is no leading zeros
 * Note that this is NOT safe in assemblyscript due to
 * the lack of error handling.
 * @param v The value to parse
 * @param base The base to parse the integer into
 */
function safeParseInt(v: string, base: u32): u32 {
    if (v.slice(0, 2) == '00') {
        throw new Error('invalid RLP: extra zeros');
    }
    return I32.parseInt(v, base) as u32;
}

/** Transform an integer into its hexadecimal value */
function intToHex(integer: u32): string {
    let res = new Array<string>();
    do {
        let t = integer / 16;
        let r = integer % 16;
        integer = t;
        res.push(hexAlphabet[r]);
    } while (integer);
    let hex = res.reverse().join('');
    return hex.length % 2 ? "0" + hex : hex;
}

function bytesToHex(bytes: Uint8Array): string {
    let res = new Uint8Array(bytes.length * 2);
    for (let i = 0; i < bytes.length; i++) {
        let hex = intToHex(bytes[i]);
        res[i*2] = hex.charCodeAt(0);
        res[i*2+1] = hex.charCodeAt(1);
    }
    return String.UTF8.decodeUnsafe((res.buffer as usize) + res.byteOffset, res.byteLength);
}

function hexToBytes(hex: string): Uint8Array {
    if (!hex.length) {
        return new Uint8Array(0);
    }
    assert(hex.length % 2 == 0);
    let byteLength = hex.length / 2;
    let res = new Uint8Array(byteLength);
    for (let i = 0; i < byteLength; i++) {
        res[i] = I32.parseInt(hex.substring(i*2, 2), 16) as u8;
    }
    return res;
}

function concatUint8Array(arr1: Uint8Array, arr2: Uint8Array): Uint8Array {
    let len = arr1.byteLength + arr2.byteLength;
    let res = new Uint8Array(len);
    memory.copy((res.buffer as usize) + res.byteOffset, (arr1.buffer as usize) + arr1.byteOffset, arr1.byteLength);
    memory.copy((res.buffer as usize) + res.byteOffset + arr1.byteLength, (arr2.buffer as usize) + arr2.byteOffset, arr2.byteLength);
    return res;
}

function concatUint8Arrays(arrays: Array<Uint8Array>): Uint8Array {
    let len = arrays.reduce<u32>(((acc, x) => acc + x.byteLength), 0);
    let res = new Uint8Array(len);
    let counter = 0;
    for (let i = 0; i < arrays.length; i++) {
        // TODO: check that arrays[1].byteOffset is right and covered by tests
        memory.copy((res.buffer as usize) + res.byteOffset + counter, (arrays[i].buffer as usize) + arrays[i].byteOffset, arrays[i].byteLength);
        counter += arrays[i].byteLength;
    }
    return res;
}

/**
 * RLP Encoding based on: https://github.com/ethereum/wiki/wiki/%5BEnglish%5D-RLP
 * This function takes in an argument of type Input and returns the rlp encoding of it.
 * @param input: a Uint8Array or an array of inputs.
 * @returns returns rlp encoded byte array.
 **/
export function encode(input: RLPData): Uint8Array {
    if (input.children.length) {
        let output = new Array<Uint8Array>();
        output.push(new Uint8Array(0));
        let totalLen = 0
        for (let i = 0; i < input.children.length; i++) {
            let e = encode(input.children[i]);
            output.push(e);
            totalLen += output[i + 1].byteLength
        }
        output[0] = encodeLength(totalLen, 192)
        return concatUint8Arrays(output)
    } else {
        //debug_mem((input.buffer.buffer as usize) + input.buffer.byteOffset, input.buffer.byteLength);
        if (input.buffer.length == 1 && input.buffer[0] < 128) {
            return input.buffer;
        }
        let len_encoded = encodeLength(input.buffer.length, 128);
        //debug_mem(len_encoded.dataStart, len_encoded.byteLength);
        return concatUint8Array(len_encoded, input.buffer);
    }
}

function encodeLength(len: u32, offset: u32): Uint8Array {
    if (len < 56) {
        //let hex_from_int = intToHex(len + offset);
        let int = len + offset;
        //debug(int);
        if (int < 256) {
          let int_as_bytes = new Uint8Array(1);
          int_as_bytes[0] = int as u8;
          return int_as_bytes;
        }
        if (int < 65536) {
          let int_as_bytes = new Uint8Array(2);
          //let int_view = DataView.wrap(int_as_bytes.buffer, 0, 2);
          let int_view = new DataView(int_as_bytes.buffer, 0, 2);
          int_view.setUint16(0, int as u16, false);
          return int_as_bytes;
        }
        throw new Error('longer lengths unsupported');
        //return hexToBytes(intToHex(len + offset));
        return hexToBytes(intToHex(len + offset));
    } else {
        /*
        let hexLength = intToHex(len);
        let lLength = hexLength.length / 2;
        let firstByte = intToHex(offset + 55 + lLength);
        return concatUint8Array(hexToBytes(firstByte), hexToBytes(hexLength));
        */
        let len_as_bytes: Uint8Array;
        let lLength: u32;
        //debug(len);
        if (len < 256) {
          lLength = 1;
          len_as_bytes = new Uint8Array(1);
          len_as_bytes[0] = len as u8;
        } else if (len < 65536) {
          lLength = 2;
          len_as_bytes = new Uint8Array(2);
          let len_view = new DataView(len_as_bytes.buffer, 0, 2);
          len_view.setUint16(0, len as u16, false);
        } else {
          throw new Error('longer lengths unsupported');
        }

        let firstByte_as_bytes: Uint8Array;
        let firstByte = offset + 55 + lLength;
        //debug(firstByte);
        if (firstByte < 256) {
          firstByte_as_bytes = new Uint8Array(1);
          firstByte_as_bytes[0] = firstByte as u8;
          //return int_as_bytes;
        } else if (firstByte < 65536) {
          firstByte_as_bytes = new Uint8Array(2);
          //let int_view = DataView.wrap(int_as_bytes.buffer, 0, 2);
          let int_view = new DataView(firstByte_as_bytes.buffer, 0, 2);
          int_view.setUint16(0, firstByte as u16, false);
          //return int_as_bytes;
        } else {
          throw new Error('longer lengths unsupported');
        }

        return concatUint8Array(firstByte_as_bytes, len_as_bytes);
    }
}

/**
 * RLP Decoding based on: {@link https://github.com/ethereum/wiki/wiki/%5BEnglish%5D-RLP|RLP}
 * @param input - Uint8Array
 * @returns - returns RLPData containing the original message
 **/
export function decode(input: Uint8Array): RLPData {
    let res = _decode(input);
    if (res.remainder.length != 0) {
        throw new Error('invalid remainder');
    }
    return res.data;
}

export function _decode(input: Uint8Array): Decoded {
    let length: u32;
    if (!input.length) {
        throw new Error('invalid input: cannot be empty');
    }
    let firstByte = input[0];
    if (firstByte <= 0x7f) {
        // a single byte whose value is in the [0x00, 0x7f] range, that byte is its own RLP encoding.
        return new Decoded(new RLPData(input.subarray(0, 1), null), input.subarray(1));
    } else if (firstByte <= 0xb7) {
        length = firstByte - 0x7f;
        if (firstByte == 0x80) {
            //return new Decoded(new RLPData(new Uint8Array(0), null), new Uint8Array(0));
            return new Decoded(new RLPData(new Uint8Array(0), null), input.subarray(length));
        }
        let data = input.subarray(1, length);
        if (length == 2 && data[0] < 0x80) {
            throw new Error('invalid rlp encoding: byte must be less 0x80');
        }
        return new Decoded(new RLPData(data, null), input.subarray(length));
    } else if (firstByte <= 0xbf) {

        let llength = firstByte - 0xb6;
        length = safeParseInt(bytesToHex(input.subarray(1, llength)), 16);
        let data = input.subarray(llength, length + llength);
        if ((data.length as u32) < length) {
            throw new Error('invalid RLP');
        }
        return new Decoded(new RLPData(data, null), input.subarray(length + llength));


        /*
        // a string longer than 55 bytes
        // firstByte is between 0xb7 and 0xbf

        //sayHello(96);
        //sayHello(input.length);
        let input_ptr = changetype<usize>(input.buffer);
        //debug(input_ptr + input.byteOffset);
        let llength = firstByte - 0xb6;
        // 0xb6 is used because the slice/subarray operator  exclusive and wants length + 1;
        let len_length = llength - 1;
        // if the string is longer than 256 bytes, then the length needs to be read from two bytes
        // if its longer than 65536 then it needs three bytes
        // llength is the "length of the length"

        //sayHello(33);
        //sayHello(llength); 

        //length = safeParseInt(bytesToHex(input.subarray(1, llength)), 16);
        //length = i32(input.subarray(1, llength));

        var length_view = new DataView(input.buffer, input.byteOffset + 1, llength);

        //sayHello(77);
        //sayHello(length_view.byteLength);
        //debug(length_view.dataStart);

        if (len_length == 1) { // read length from one byte
          length = length_view.getUint8(0);
        }
        if (len_length == 2) { // read length from two bytes
          length = length_view.getUint16(0);
        }
        //sayHello(length);
        if (llength > 3) {
          throw new Error('TODO');
        }

        let data = input.subarray(llength, length + llength);
        if ((data.length as u32) < length) {
            //sayHello(666);
            throw new Error('invalid RLP');
        }
        return new Decoded(new RLPData(data, null), input.subarray(length + llength));
        */
    } else if (firstByte <= 0xf7) {
        length = firstByte - 0xbf;
        let remainder = input.subarray(1, length);
        let decoded: RLPData[] = [];
        while (remainder.length) {
            let d = _decode(remainder);
            decoded.push(d.data);
            remainder = d.remainder;
        }
        return new Decoded(new RLPData(null, decoded), input.subarray(length));
    } else {
        // a list over 55 bytes long

        let llength = firstByte - 0xf6;
        length = safeParseInt(bytesToHex(input.subarray(1, llength)), 16);
        let totalLength = llength + length;
        if (totalLength > (input.length as u32)) {
            throw new Error('invalid rlp: total length is larger than the data');
        }

        let remainder = input.subarray(llength, totalLength);
        if (remainder.length == 0) {
            throw new Error('invalid rlp, List has a invalid length');
        }
        let decoded: RLPData[] = [];
        while (remainder.length) {
            let d = _decode(remainder);
            decoded.push(d.data);
            remainder = d.remainder;
        }
        return new Decoded(new RLPData(null, decoded), input.subarray(totalLength));


        /*
        let llength = firstByte - 0xf6;

        // TODO: use a DataView here to read the length, for better clarity
        length = i32(input.subarray(1, llength));

        // old code, not sure if safeParseInt is actually necessary
        //length = safeParseInt(bytesToHex(input.subarray(1, llength)), 16);

        let totalLength = i32(llength + length);

        //sayHello(1);
        //if (totalLength > i32(input.length)) {
        if (totalLength == 0) { // TODO: check this
            throw new Error('invalid rlp: total length is larger than the data');
        }

        //sayHello(2);
        let remainder = input.subarray(llength, totalLength);

        if (remainder.length == 0) {
            throw new Error('invalid rlp, List has a invalid length');
        }

        //sayHello(3);
        let decoded: RLPData[] = [];
        while (remainder.length) {
            //sayHello(remainder.length)
            //sayHello(4);
            let d = _decode(remainder);
            //sayHello(6);
            decoded.push(d.data);
            remainder = d.remainder;
            //sayHello(7);
        }
        //sayHello(5);
        return new Decoded(new RLPData(null, decoded), input.subarray(totalLength));
        */
    }
}
