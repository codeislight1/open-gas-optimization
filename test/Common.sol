// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";

contract Common is Test {
    // blur exchange proxy contract
    address internal owner = 0xFcb19e6a322b27c06842A71e8c725399f049AE3a;
    address internal proxy = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address internal whale = 0x28C6c06298d514Db089934071355E5743bf21d60;

    function callBlurExchange(address caller, uint256 value, bytes memory data) internal {
        // use original tx caller
        vm.startPrank(caller);
        uint256 preCall = gasleft();
        (bool success,) = address(proxy).call{value: value, gas: gasleft()}(data);
        uint256 postCall = gasleft();
        // calculating call gas consumed
        console.log(
            executeCaller == caller ? "execute call gas consumed:" : "bulkExecute call gas consumed:",
            preCall - postCall
        );
        require(success, "!success");
        vm.stopPrank();
    }
}
