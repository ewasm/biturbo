import * as fs from 'fs'
import axios from 'axios'

// Based on @cdetrio's python script:
// https://github.com/ewasm/biturbo/blob/7dccdbcff4e01e3ed7bec2659a9a377a4703565d/test/fetch_realistic_rpc.py

const ENDPOINT = 'http://localhost:8545'
const blockNumber = 9125141

async function getBlockByNumber(n: number): Promise<any> {
  const res = await axios.post(ENDPOINT, {
    method: 'eth_getBlockByNumber',
    params: [toHex(blockNumber), true],
    id: 1,
  })

  return res.data
}

async function getProof(n: number, addr: string): Promise<any> {
  const res = await axios.post(ENDPOINT, {
    method: 'eth_getProof',
    params: [addr, [], toHex(n)],
    id: 1,
  })

  const data = res.data
  if (data.error) {
    throw new Error(`eth_getProof error (${data.error.code}): ${data.error.message}`)
  }

  return data
}

async function getBlockWitnesses(n: number): Promise<any> {
  const res = await getBlockByNumber(n)
  const block = res.result
  const txes = []
  const accounts: any = {}
  for (const tx of block.transactions) {
    // Skip create txes
    if (!tx.to) continue
    txes.push(tx)

    if (accounts[tx.to] === undefined) {
      accounts[tx.to] = await getProof(n - 1, tx.to)
    }
    if (accounts[tx.from] === undefined) {
      accounts[tx.from] = await getProof(n - 1, tx.from)
    }
  }

  return { transactions: txes, accounts: Object.values(accounts) }
}

async function main() {
  const res = await getBlockWitnesses(blockNumber)
  let path = 'test/fixture/eth_getproof_result.json'
  if (process.argv.length === 3) {
    path = process.argv[2]
  }
  fs.writeFileSync(path, JSON.stringify(res, null, 2))
}

function toHex(n: number): string {
  return '0x' + n.toString(16)
}

main()
  .then()
  .catch(e => {
    throw new Error(e)
  })
