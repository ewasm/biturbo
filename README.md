# Turbo token

Turbo token is a fork of @cdetrio's [turbo-mpas](https://github.com/cdetrio/scout.ts/tree/turbo-mpas). It adapts Alexey's Akhunov's [turboproof](https://github.com/ledgerwatch/turbo-geth/blob/master/docs/programmers_guide/guide.md) as implemented by @gballet in [multiproof-rs](https://github.com/gballet/multiproof-rs) and the Typescript [version](https://github.com/ethereumjs/merkle-patricia-tree/pull/101).

## Install

Clone scout.ts locally and install it locally by running `npm link` in its dir and running `npm run link scout.ts` in turbo-token's dir.

`#!/usr/bin/env node` needs to be added to the first line of `node_modules/.bin/scout.ts`.

## Run

```sh
npx gulp && npx scout.ts turboproof.yaml
```
