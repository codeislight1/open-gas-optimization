// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "./Common.sol";
import {Test} from "forge-std/Test.sol";
import {FiatTokenV2_1} from "../src/USDC.sol";
import "../src/IProxy.sol";
import {FiatTokenV2_1_Optimized} from "../src/OptimizedUSDC.sol";
import "forge-std/console.sol";

contract USDCTest is Test, Common {
    function setUp() public {
        // setup mainnet fork
        uint256 forkId = vm.createFork(RPC);
        vm.rollFork(forkId, blocknumber);
        vm.selectFork(forkId);
        assertEq(blocknumber, block.number, "wrong block number!");
    }

    function testMint() public {
        _mint(circle, 1 ** 6);
    }

    function testBurn() public {
        _burn(100);
    }

    function testIncreaseAllowance() public {
        _increaseAllowance(whale, address(1), 1 ** 6);
    }

    function testDecreaseAllowance() public {
        _decreaseAllowance(whale, address(1), 1 ** 6);
    }

    function testTransferFrom() public {
        _transferFrom(whale, address(1), 1 ** 6);
    }

    function testTransfer() public {
        _transfer(whale, address(1), 1 ** 6);
    }
}
