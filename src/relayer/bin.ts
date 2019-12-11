// tslint:disable:no-console
import { generateTestSuite, TestSuite, stateTestRunner, RunnerArgs, TestGetterArgs } from './lib'
const fs = require('fs')
const yaml = require('js-yaml')
const testing = require('ethereumjs-testing')

async function main() {
  const args = process.argv

  if ((args.length === 4) && (args[2] == '--stateTest')) {
    const testCase = args[3]
    const testGetterArgs: TestGetterArgs = { test: testCase }
    const runnerArgs: RunnerArgs = {
      stateless: true,
      fork: 'Petersburg',
      test: testCase,
      scout: 'true',
      dist: '?',
      forkConfig: 'Petersburg',
      jsontrace: false,
      debug: false,
      data: '',
      gasLimit: 0,
      value: 0
    }

    await testing.getTestsFromArgs('GeneralStateTests', async (filename: any, testName: any, test: any) => {
      const testSuite =  await stateTestRunner(runnerArgs, test, testName)
      writeScoutConfig(testSuite, testCase + '.yaml', 'build/evm_with_keccak.wasm')
    }, testGetterArgs).then( () => {
    }).catch((err: any) => {
      console.log('Err: ', err)
    })
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
