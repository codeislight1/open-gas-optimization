// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./Common.sol";
import {Test} from "forge-std/Test.sol";
import {FiatTokenV2_1} from "../src/USDC.sol";
import {FiatTokenV2_1_Optimized} from "../src/OptimizedUSDC.sol";
import "forge-std/console.sol";

contract USDCOptimizedTest is Test, Common {
    BlurExchangeOptimized exchange;

    function setUp() public {
        // setup mainnet fork
        uint256 forkId = vm.createFork("https://eth-mainnet.g.alchemy.com/v2/PIJ-XWn0szDM65qMpM2SZsfi3GlIWPbo");
        vm.rollFork(forkId, blocknumber);
        vm.selectFork(forkId);
        // check block number
        assertEq(block.number, blocknumber);
        exchange = BlurExchangeOptimized(proxy);
        // deploy new implementation
        address newImplementation = address(new BlurExchangeOptimized());
        // use proxy owner
        vm.startPrank(owner);
        // upgrade to new implementation
        exchange.upgradeTo(newImplementation);
        // initialize the reentrancyGuards
        exchange.initializeV2();
        vm.stopPrank();
    }

    function testMint() public {}
    function testBurn() public {}
    function testSafeIncreaseAllowance() public {}
    function testIncreaseAllowance() public {}
    function testSafeDecreaseAllowance() public {}
    function testDecreaseAllowance() public {}
    function testApprove() public {}
    function testTransferFrom() public {}
    function testTransfer() public {}

    function testExecuteOptimized() public {
        callBlurExchange(executeCaller, executeValue, executeCalldata);
    }

    function testBulkExecuteOptimized() public {
        callBlurExchange(bulkExecuteCaller, bulkExecuteValue, bulkExecuteCalldata);
    }
}
