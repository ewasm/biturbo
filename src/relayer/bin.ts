// tslint:disable:no-console
import { generateTestSuite, TestSuite, stateTestRunner, RunnerArgs } from './lib'
import { basicEvmTestSuite } from './basic-evm'
import { generateRealisticTestSuite } from './realistic'
import { getStateTest } from './state-test'
const fs = require('fs')
const yaml = require('js-yaml')
const testing = require('ethereumjs-testing')

async function main() {
  const args = process.argv

  if (args.length === 4 && args[2] === '--stateTest') {
    const testName = args[3]
    const runnerArgs: RunnerArgs = {
      stateless: true,
      fork: 'Petersburg',
      test: testName,
      scout: 'true',
      dist: '?',
      forkConfig: 'Petersburg',
      jsontrace: false,
      debug: false,
      data: '',
      gasLimit: 0,
      value: 0,
    }

    const test = await getStateTest(testName)
    const testSuite = await stateTestRunner(runnerArgs, test)
    writeScoutConfig(testSuite, testName + '.yaml', 'build/evm_with_keccak.wasm')
  } else if (args.length === 4 && args[2] === '--realistic') {
    const rpcData = JSON.parse(fs.readFileSync(process.argv[3]))
    const testSuite = await generateRealisticTestSuite(rpcData)
    writeScoutConfig(testSuite, 'turbo-token-realistic.yaml', 'build/token_with_keccak.wasm')
  } else if (args.length >= 3 && args[2] === '--basicEvm') {
    const testSuite = await basicEvmTestSuite(args[3])
    writeScoutConfig(testSuite, 'basic-evm.yaml', 'build/evm_with_keccak.wasm')
  } else {
    const testSuite = await generateTestSuite()
    writeScoutConfig(testSuite, 'turbo-token.yaml', 'build/token_with_keccak.wasm')
  }
}

function writeScoutConfig(data: TestSuite, outPath: string, wasmPath: string) {
  const testSuite = {
    beacon_state: {
      execution_scripts: [wasmPath],
    },
    shard_pre_state: {
      exec_env_states: [data.preStateRoot.toString('hex')],
    },
    shard_blocks: [{ env: 0, data: data.blockData.toString('hex') }],
    shard_post_state: {
      exec_env_states: [data.postStateRoot.toString('hex')],
    },
  }

  const serializedTestSuite = yaml.safeDump(testSuite)
  fs.writeFileSync(outPath, serializedTestSuite)
}

main()
  .then(() => {})
  .catch((e: Error) => console.log(e))
