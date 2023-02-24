// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import {FiatTokenV2_1} from "../src/USDC.sol";
import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";

contract Common is Test {
    // blur exchange proxy contract
    address internal owner = 0xFcb19e6a322b27c06842A71e8c725399f049AE3a;
    address internal proxy = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address internal whale = 0x28C6c06298d514Db089934071355E5743bf21d60;
    address internal minter = 0x5B6122C109B78C6755486966148C1D70a50A47D7;
    address internal circle = 0x55FE002aefF02F77364de339a1292923A15844B8;
    string RPC = "https://eth-mainnet.g.alchemy.com/v2/PIJ-XWn0szDM65qMpM2SZsfi3GlIWPbo";
    uint256 internal blocknumber = 16692500;
    // original and optimized share same functions
    FiatTokenV2_1 internal _usdc = FiatTokenV2_1(proxy);

    // unit tests

    function _mint(address to, uint256 amount) internal {
        uint256 preBalance = _usdc.balanceOf(to);
        vm.startPrank(minter);
        __mint(to, amount);
        uint256 postBalance = _usdc.balanceOf(to);
        assertEq(postBalance - preBalance, amount, "failed mint!");
    }

    function _burn(uint256 amount) public {
        assertTrue(_usdc.balanceOf(minter) >= amount);
        uint256 preBalance = _usdc.balanceOf(minter);
        vm.startPrank(minter);
        __burn(amount);
        uint256 postBalance = _usdc.balanceOf(minter);
        assertEq(preBalance - postBalance, amount, "failed burn!");
    }

    function _increaseAllowance(address from, address to, uint256 amount) public {
        uint256 preAllowance = _usdc.allowance(from, to);
        vm.startPrank(from);
        __increaseAllowance(to, amount);
        uint256 postAllowance = _usdc.allowance(from, to);
        assertEq(postAllowance - preAllowance, amount, "failed increase allowance!");
    }

    function _transferFrom(address from, address to, uint256 amount) public {
        assertTrue(_usdc.balanceOf(from) >= amount);
        uint256 preFromBalance = _usdc.balanceOf(from);
        uint256 preToBalance = _usdc.balanceOf(to);
        vm.startPrank(from);
        _usdc.approve(to, amount);
        vm.stopPrank();
        uint256 preAllowance = _usdc.allowance(from, to);
        vm.startPrank(to);
        __transferFrom(from, to, amount);
        uint256 postAllowance = _usdc.allowance(from, to);
        uint256 postFromBalance = _usdc.balanceOf(from);
        uint256 postToBalance = _usdc.balanceOf(to);
        assertEq(preAllowance - postAllowance, amount, "failed allowance accounting!");
        assertEq(preFromBalance - postFromBalance, amount, "failed from transferFrom!");
        assertEq(postToBalance - preToBalance, amount, "failed to transferFrom!");
    }

    function _transfer(address from, address to, uint256 amount) public {
        assertTrue(_usdc.balanceOf(from) >= amount);
        uint256 preFromBalance = _usdc.balanceOf(from);
        uint256 preToBalance = _usdc.balanceOf(to);
        vm.startPrank(from);
        __transfer(to, amount);
        uint256 postFromBalance = _usdc.balanceOf(from);
        uint256 postToBalance = _usdc.balanceOf(to);
        assertEq(preFromBalance - postFromBalance, amount, "failed from transfer!");
        assertEq(postToBalance - preToBalance, amount, "failed to transfer!");
    }

    // helpers functions to profile gas consumption

    function __transfer(address to, uint256 amount) private {
        uint256 pre = gasleft();
        _usdc.transfer(to, amount);
        uint256 post = gasleft();
        console.log("transfer", pre - post);
    }

    function __transferFrom(address from, address to, uint256 amount) private {
        uint256 pre = gasleft();
        _usdc.transferFrom(from, to, amount);
        uint256 post = gasleft();
        console.log("transferFrom", pre - post);
    }

    function __increaseAllowance(address to, uint256 amount) private {
        uint256 pre = gasleft();
        _usdc.increaseAllowance(to, amount);
        uint256 post = gasleft();
        console.log("increaseAllowance", pre - post);
    }

    function __mint(address to, uint256 amount) private {
        uint256 pre = gasleft();
        _usdc.mint(to, amount);
        uint256 post = gasleft();
        console.log("mint", pre - post);
    }

    function __burn(uint256 amount) private {
        uint256 pre = gasleft();
        _usdc.burn(amount);
        uint256 post = gasleft();
        console.log("burn", pre - post);
    }
}
