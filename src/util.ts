export function bufToU8(b: Buffer): number {
  // RLP decoding of 0 is empty buffer
  if (b.length === 0) {
    return 0
  }
  return b.readUInt8(0)
}

export function lookupNode(trie: any, hash: any) {
  return new Promise((resolve, reject) => {
    try {
      trie._lookupNode(hash, (v: any) => resolve(v))
    } catch (e) {
      reject(e)
    }
  })
}

/**
 * Prepends hex prefix to an array of nibbles.
 * @method addHexPrefix
 * @param {Array} Array of nibbles
 * @returns {Array} - returns buffer of encoded data
 **/
export function addHexPrefix(key: number[], terminator: boolean): number[] {
  const res = key.slice()
  // odd
  if (res.length % 2) {
    res.unshift(1)
  } else {
    // even
    res.unshift(0)
    res.unshift(0)
  }

  if (terminator) {
    res[0] += 2
  }

  return res
}

/**
 * Removes hex prefix of an array of nibbles.
 * @method removeHexPrefix
 * @param {Array} Array of nibbles
 * @private
 */
export function removeHexPrefix(val: number[]): number[] {
  let res = val.slice()

  if (res[0] % 2) {
    res = val.slice(1)
  } else {
    res = val.slice(2)
  }

  return res
}
