# Biturbo

[![Greenkeeper badge](https://badges.greenkeeper.io/ewasm/biturbo.svg)](https://greenkeeper.io/)

Biturbo is an Eth1 EE prototype, which uses Alexey Akhunov's [turboproof](https://github.com/ledgerwatch/turbo-geth/blob/master/docs/programmers_guide/guide.md) scheme as witness format. It started as a fork of @cdetrio's [turbo-mpas](https://github.com/cdetrio/scout.ts/tree/turbo-mpas) called Turbo Token, which aimed to prototype a token transfer EE compatible with Eth1 (i.e. MPT as accumulator, RLP for serialization and the same account structure). It's now being extended with EVM support, but we intend to maintain the token EE to allow for further experimentation and benchmarking. Therefore the repo contains both TurboEVM and TurboToken.

In addition to the AS EE implementation, the repo also includes an [implementation](src/multiproof.ts) of Turboproof in typescript, a [relayer](src/relayer/lib.ts) which can generate scout test suites to simulate a shard block, and an [implementation](src/ee.ts) of the high-level EE logic in typescript.

## Install

After cloning the repo, install the dependencies via npm:

```sh
npm install
```

## Run

If you simply want to try one of the EEs, run:

```sh
# To run token EE
npm run token

# To run EVM EE
npm run evm
```

Each of the above commands does 3 things. It runs a simluated relayer to generate input data for the EE, then compiles the AssemblyScript source code, and finally runs the resulting Wasm module with the generated input data. To run each of the steps separately you can use the corresponding npm scripts:

```sh
npm run token:relayer
npm run token:build
npm run token:run
```

## Test

There are some unit tests for the multiproof generation/verification and encoding. You can run them via:

```sh
npm t
```
