// RLP code is taken from https://github.com/nearprotocol/assemblyscript-rlp
// a couple of bugs in the original code are fixed here.

/** debugging functions
@external("main", "sayHello")
export declare function sayHello(a: i32): void;

@external("main", "debug")
export declare function debug(a: i32): void;
*/


@external("env", "debug_log")
export declare function debug(a: i32): void;


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
        memory.copy((res.buffer as usize) + res.byteOffset + counter, (arrays[i].buffer as usize) + arrays[1].byteOffset, arrays[i].byteLength);
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
        for (let i = 0; i < input.children.length; i++) {
            output.push(encode(input.children[i]));
        }
        let buf = concatUint8Arrays(output);
        return concatUint8Array(encodeLength(buf.length, 192), buf);
    } else {
        if (input.buffer.length == 1 && input.buffer[0] < 128) {
            return input.buffer;
        }
        return concatUint8Array(encodeLength(input.buffer.length, 128), input.buffer);
    }
}

function encodeLength(len: u32, offset: u32): Uint8Array {
    if (len < 56) {
        return hexToBytes(intToHex(len + offset));
    } else {
        let hexLength = intToHex(len);
        let lLength = hexLength.length / 2;
        let firstByte = intToHex(offset + 55 + lLength);
        return concatUint8Array(hexToBytes(firstByte), hexToBytes(hexLength));
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
        return new Decoded(new RLPData(input.subarray(0, 1),null), input.subarray(1));
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
