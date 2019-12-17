import { stripBuf, cmpBuf } from '../util'

describe('stripBuf', () => {
  it('should strip buffer with preceding zeros', () => {
    const buf = new Uint8Array(5)
    buf.fill(0)
    buf[2] = 2
    const res = stripBuf(buf)
    expect(res.length).toBe(3)
  })

  it('shouldnt strip if first byte is nonzero', () => {
    const buf = new Uint8Array(5)
    buf.fill(0)
    buf[0] = 2
    const res = stripBuf(buf)
    expect(res.length).toBe(5)
  })

  it('should strip buffer of all zeros', () => {
    const buf = new Uint8Array(5)
    buf.fill(0)
    const res = stripBuf(buf)
    expect(res.length).toBe(0)
  })
})

describe('cmpBuf', () => {
  it('should return 1 for longer buffer', () => {
    const buf = new Uint8Array(5)
    buf.fill(1)
    const other = new Uint8Array(4)
    other.fill(1)
    expect(cmpBuf(buf, other)).toBe(1)
  })

  it('should return -1 for shorter buffer', () => {
    const buf = new Uint8Array(4)
    buf.fill(1)
    const other = new Uint8Array(5)
    other.fill(1)
    expect(cmpBuf(buf, other)).toBe(-1)
  })

  it('should return 0 for equal buffers', () => {
    const buf = new Uint8Array(5)
    buf.fill(1)
    const other = new Uint8Array(5)
    other.fill(1)
    expect(cmpBuf(buf, other)).toBe(0)
  })

  it('should return 1 for greater buffers', () => {
    const buf = new Uint8Array(5)
    buf.fill(1)
    buf[0] = 2
    const other = new Uint8Array(5)
    other.fill(2)
    other[0] = 1
    expect(cmpBuf(buf, other)).toBe(1)
  })

  it('should return -1 for lesser buffers', () => {
    const buf = new Uint8Array(5)
    buf.fill(2)
    buf[0] = 1
    const other = new Uint8Array(5)
    other.fill(1)
    other[0] = 2
    expect(cmpBuf(buf, other)).toBe(-1)
  })
})
