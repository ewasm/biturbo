import { stripBuf } from '../util'

describe('stripBuf', () => {
  it('should strip buffer with preceding zeros', () => {
    const buf = new Uint8Array(5)
    buf.fill(0)
    buf[2] = 2
    const res = stripBuf(buf)
    expect(res.length).toBe(3)
  })

  it('shouldn\'t strip if first byte is nonzero', () => {
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
