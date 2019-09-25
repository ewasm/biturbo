# Turbo token

Turbo token is a fork of @cdetrio's [turbo-mpas](https://github.com/cdetrio/scout.ts/tree/turbo-mpas). It adapts Alexey's Akhunov's [turboproof](https://github.com/ledgerwatch/turbo-geth/blob/master/docs/programmers_guide/guide.md) as implemented by @gballet in [multiproof-rs](https://github.com/gballet/multiproof-rs) and the Typescript [version](https://github.com/ethereumjs/merkle-patricia-tree/pull/101).

In addition to the AS EE implementation, the repo also includes an [implementation](src/multiproof.ts) of Turboproof in typescript, a [relayer](src/relayer/lib.ts) which can generate scout test suites to simulate a shard block, and an [implementation](src/ee.ts) of the high-level EE logic in typescript.

## Install

After cloning the repo, install the dependencies via npm:

```sh
npm install
```

## Run

To run the EE in AssemblyScript, run:

```sh
npx gulp && npx scout.ts turboproof.yaml
```

The repo also includes a simple relayer which generates new scout test suites for the EE:

```sh
npx ts-node src/relayer/bin.ts
```

## Test

There are some unit tests for the multiproof generation/verification and encoding. You can run them via:

```sh
npm t
```
