import { generateTestSuite, TestSuite } from './lib'
const fs = require('fs')
const yaml = require('js-yaml')

async function main () {
  const testSuite = await generateTestSuite()
  writeScoutConfig(testSuite)
}

function writeScoutConfig (data: TestSuite) {
  const testSuite = {
    'beacon_state': {
      'execution_scripts': [
        'build/main_with_keccak.wasm'
      ],
    },
    'shard_pre_state': {
      'exec_env_states': [
        data.preStateRoot.toString('hex')
      ]
    },
    'shard_blocks': [
      { env: 0, data: data.blockData.toString('hex') }
    ],
    'shard_post_state': {
      'exec_env_states': [
        data.postStateRoot.toString('hex')
      ]
    }
  }

  const serializedTestSuite = yaml.safeDump(testSuite)
  fs.writeFileSync('turboproof.yaml', serializedTestSuite)
}

main().then(() => {}).catch((e: Error) => console.log(e))
