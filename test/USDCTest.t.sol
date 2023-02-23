// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {Test} from "forge-std/Test.sol";
import {BlurExchange} from "../src/BlurExchange.sol";
import "./Common.sol";
import {Input, Order, Execution, SignatureVersion, Fee} from "../src/lib/OrderStructs.sol";
import "forge-std/console.sol";

contract USDCTest is Test, Common {
    function setUp() public {
        // setup mainnet fork
        uint256 forkId = vm.createFork("https://eth-mainnet.g.alchemy.com/v2/PIJ-XWn0szDM65qMpM2SZsfi3GlIWPbo");
        vm.rollFork(forkId, blocknumber);
        vm.selectFork(forkId);
        // check block number
        assertEq(block.number, blocknumber);
    }

    function testExecute() public {
        callBlurExchange(executeCaller, executeValue, executeCalldata);
    }

    function testBulkExecute() public {
        callBlurExchange(bulkExecuteCaller, bulkExecuteValue, bulkExecuteCalldata);
    }
}
