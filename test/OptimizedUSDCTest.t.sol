// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "./Common.sol";
import {Test} from "forge-std/Test.sol";
import {FiatTokenV2_1} from "../src/USDC.sol";
import "../src/IProxy.sol";
import {FiatTokenV2_1_Optimized} from "../src/OptimizedUSDC.sol";
import "forge-std/console.sol";
import "forge-std/console.sol";

contract USDCOptimizedTest is Test, Common {
    FiatTokenV2_1_Optimized usdc;

    function setUp() public {
        // setup mainnet fork
        uint256 forkId = vm.createFork(RPC);
        vm.rollFork(forkId, blocknumber);
        vm.selectFork(forkId);
        assertEq(blocknumber, block.number, "wrong block number!");
        usdc = FiatTokenV2_1_Optimized(proxy);
        // deploy new implementation
        address newImplementation = address(new FiatTokenV2_1_Optimized());
        // use proxy owner
        address _owner = address(
            uint160(uint256(vm.load(proxy, 0x10d6a54a4754c8869d6886b5f5d7fbfa5b4522237ea5c60d11bc4e7a1ff9390b)))
        );
        vm.prank(_owner);
        // upgrade to new implementation
        IProxy(address(usdc)).upgradeTo(newImplementation);
    }

    function testMintOptimized() public {
        _mint(circle, 1 ** 6);
    }

    function testBurnOptimized() public {
        _burn(100);
    }

    function testIncreaseAllowanceOptimized() public {
        _increaseAllowance(whale, address(1), 1 ** 6);
    }

    function testTransferFromOptimized() public {
        _transferFrom(whale, address(1), 1 ** 6);
    }

    function testTransferOptimized() public {
        _transfer(whale, address(1), 1 ** 6);
    }
}
