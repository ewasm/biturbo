import * as fs from 'fs'
import axios from 'axios'
import { merge } from 'lodash'

// Based on @cdetrio's python script:
// https://github.com/ewasm/biturbo/blob/7dccdbcff4e01e3ed7bec2659a9a377a4703565d/test/fetch_realistic_rpc.py

const ENDPOINT = 'http://localhost:8545'
//const blockNumber = 9125141

async function request(params: any): Promise<any> {
  const res = await axios.post(ENDPOINT, params)
  const data = res.data
  if (data.error) {
    throw new Error(`${params.method} error (${data.error.code}): ${data.error.message}`)
  }

  return data
}

async function getBlockByNumber(n: number): Promise<any> {
  return request({
    method: 'eth_getBlockByNumber',
    params: [toHex(n), true],
    id: 1,
  })
}

async function getProof(n: number, addr: string): Promise<any> {
  return request({
    method: 'eth_getProof',
    params: [addr, [], toHex(n)],
    id: 1,
  })
}

async function traceTransaction(txHash: string, tracer?: any): Promise<any> {
  const params: any[] = [txHash]
  if (tracer) {
    params.push({ tracer })
  }
  return request({
    method: 'debug_traceTransaction',
    params,
    id: 1
  })
}

async function getTransactionByHash(txHash: string): Promise<any> {
  return request({
    method: 'eth_getTransactionByHash',
    params: [txHash],
    id: 1
  })
}

async function getTransactionReceipt(txHash: string): Promise<any> {
  return request({
    method: 'eth_getTransactionReceipt',
    params: [txHash],
    id: 1
  })
}

async function getCode(addr: string, blockNumber: string): Promise<any> {
  return request({
    method: 'eth_getCode',
    params: [addr, blockNumber],
    id: 1
  })
}

async function getBlockTransferWitnesses(n: number): Promise<any> {
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

async function getTxPreState(txHash: string): Promise<any> {
  const tracer = 'prestateTracer'
  const txData = (await getTransactionByHash(txHash)).result
  const blockNumber = parseInt(txData.blockNumber.slice(2), 16)
  const blockData = (await getBlockByNumber(blockNumber)).result
  blockData.transactions = [txData]
  const txReceipt = (await getTransactionReceipt(txHash)).result
  const preState = (await traceTransaction(txHash, tracer)).result

  return { block: blockData, receipts: [txReceipt], preState }
}

async function getBlockWitnesses(n: number): Promise<any> {
  const block = (await getBlockByNumber(n)).result
  //const tracer = 'prestateTracer'
  const tracer = fs.readFileSync('geth-tracer.js', 'utf8')
  const receipts = []
  let preState: { [k: string]: any } = {}
  const txes = []
  for (const tx of block.transactions) {
    let isTransfer = false
    if (tx.to) {
      const code = (await getCode(tx.to, block.number)).result
      // To is EoA -> only transfer
      if (code === '0x') {
        isTransfer = true
      }
    }
    txes.push(tx)
    const receipt = (await getTransactionReceipt(tx.hash)).result
    receipts.push(receipt)
    const fromProof = (await getProof(n - 1, tx.from)).result
    let pre
    if (!isTransfer) {
      pre = (await traceTransaction(tx.hash, tracer)).result
      // Geth's prestateTracer reduces gas budget from sender's account
      // making the balance wrong.
      pre[tx.from].balance = fromProof.balance
    } else {
      // If transfer only add from and to accounts to pre state
      const toProof = (await getProof(n - 1, tx.to)).result
      pre = {
        [tx.from]: { balance: fromProof.balance, nonce: fromProof.nonce, code: '0x', storage: {} },
        [tx.to]: { balance: toProof.balance, nonce: toProof.nonce, code: '0x', storage: {} },
      }
    }
    // Merge with block's pre state prioritizing pre state
    // of previous txes in block
    //preState = { ...pre, ...preState }
    preState = merge(Object.assign({}, pre), preState)
  }
  block.transactions = txes
  const blockhashes: { [k: string]: string } = {}
  if (preState.blockhashReqs) {
    for (const bn in preState.blockhashReqs) {
      const bh = (await getBlockByNumber(parseInt(bn.slice(2), 16))).result.hash
      blockhashes[bn] = bh
    }
    delete preState.blockhashReqs
  }
  return { block, receipts, preState, blockhashes }
}

async function getBlocksWitnesses(start: number, end: number): Promise<any> {
  const res = []
  for (let i = start; i < end; i++) {
    res.push(await getBlockWitnesses(i))
  }
  return res
}

async function main() {
  const args = process.argv

  let path: string
  let res
  if (args.length === 5 && args[2] === '--blocks-prestate') {
    const startBlock = parseInt(args[3])
    const endBlock = parseInt(args[4])
    res = await getBlocksWitnesses(startBlock, endBlock)
    path = 'test/fixture/blocks-prestate.json'
  } else if (args.length === 4 && args[2] === '--block-prestate') {
    const blockNumber = parseInt(args[3])
    res = await getBlockWitnesses(blockNumber)
    path = 'test/fixture/block-prestate.json'
  } else if (args.length === 4 && args[2] === '--tx-prestate') {
    res = await getTxPreState(args[3])
    path = 'test/fixture/tx-prestate.json'
  } else if (args.length === 4 && args[2] === '--block-transfer-witness') {
    const blockNumber = parseInt(args[3])
    path = 'test/fixture/eth_getproof_result.json'
    res = await getBlockTransferWitnesses(blockNumber)
  } else {
    throw new Error('Invalid args')
  }

  fs.writeFileSync(path!, JSON.stringify(res, null, 2))
}

function toHex(n: number): string {
  return '0x' + n.toString(16)
}

main()
  .then()
  .catch(e => {
    throw new Error(e)
  })
