# Overview

This repo is aimed to suggest gas optimization proposal for USDC implementation contract, since usdc is commonly used by users, so any gas saving would significantly save users on extra fees for the long-run, which would overall allow for the users to get the most out of USDC. the optimizations were mainly targeting common practicies, and also inspired by [Solmate](https://github.com/transmissions11/solmate) approach of checking for overflow and underflow efficiently for ERC20 tokens. we mainly have 2 contracts, one that has the original usdc contract `USDC.sol`, and the other one which has the optimized version `OptimizedUSDC.sol`. we have multiple test cases that target the functions which were optimized. the original usdc testing is in `USDCTest.t.sol` and the optimized testing version is in `OptimizedUSDCTest.t.sol`, we have `./Common.sol/` that has common testing helpers that are shared by both testing files.

overall, users would saved on the following functions:

mint: 332 gas
burn: 344 gas
increaseAllowance: 5 gas
transfer: 512 gas
transferFrom: 921 gas

### Setup

```sh
forge install
```

### Run Tests

**Note that the gas being consumed is displayed in the console for each unit test**

```sh
forge test -vv
```