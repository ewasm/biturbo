SHELL := /bin/bash

all: relayer evm

relayer:
	npx ts-node src/relayer/bin.ts --stateTest add11

evm: evm-build evm-run

evm-build:
	npx gulp
evm-run:
	npx scout.ts add11.yaml



