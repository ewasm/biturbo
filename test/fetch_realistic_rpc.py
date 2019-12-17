#!/usr/bin/env python3

import json
import sys

import requests
head = {"Content-type": "application/json"}
endpoint = "http://localhost:8545"

# based on an old script at https://gist.github.com/cdetrio/874e8e6fd044665ec90fd9473dbc8cd7

# curl --header "Content-Type: application/json" -X POST --data '{"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["0x6b2188"],"id":1}'  http://localhost:8545


def rpc_query(payload):
  # infura does not support eth_getProof, so need to use your own node
  response = requests.post(endpoint, data=json.dumps(payload), headers=head)
  #print("response for payload {}".format(payload))
  #print(response.text)
  r = response.json()
  return r


# note that eth_getProof returns proofs for the post-state of a block
# to prepare stateless blocks, we want proofs for the pre-state, so fetching for
# a block number N gets the prestate proofs for block N+1

def getAccountWitness(account, block_num):
  payload_getproof = {
    'method': 'eth_getProof',
    'params': [account, [], block_num],
    'id': 1
  }
  getproof_response = rpc_query(payload_getproof)
  # TODO: fail if query fails
  return getproof_response



def getAccountWitnessesForBlock(block_num):
  getBlock_payload = {
    'method': 'eth_getBlockByNumber',
    'params': [hex(block_num), True],
    'id': 1
  }
  response = requests.post(endpoint, data=json.dumps(getBlock_payload), headers=head)
  #print(response.text)

  r = response.json()
  block = r['result']

  print("gasUsed: {}".format(block['gasUsed']))
  print("tx count: {}".format(len(block['transactions'])))

  txs_in_block = []

  # use a dict to deduplicate the accounts
  proofs_by_account = {}

  for idx, tx in enumerate(block['transactions']):
    print("doing tx ", idx)
    if tx['to'] is None:
      # print("deploy tx in block!: {}".format(tx))
      # don't include deploy tx's
      continue

    txs_in_block.append(tx)

    if tx['to'] not in proofs_by_account:
      to_account_witness = getAccountWitness(tx['to'], hex(int(tx['blockNumber'], 0) - 1))
      proofs_by_account[tx['to']] = to_account_witness

    if tx['from'] not in proofs_by_account:
      from_account_witness = getAccountWitness(tx['from'], hex(int(tx['blockNumber'], 0) - 1))
      proofs_by_account[tx['from']] = from_account_witness

    # TODO: handle contract txns properly, also need all accounts written to by a contract, e.g. with a CALL. see old gist


  biturbo_getproof_format = {}
  biturbo_getproof_format['accounts'] = list(proofs_by_account.values())
  biturbo_getproof_format['transactions'] = txs_in_block # TODO: transactions might not be the exact same format as expected

  #print(json.dumps(biturbo_getproof_format, indent=2))
  print(json.dumps(biturbo_getproof_format, indent=2),  file=open('fixture/eth_getproof_result.json', 'w'))

  return


getAccountWitnessesForBlock(9121525)
