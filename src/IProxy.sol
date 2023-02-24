pragma solidity ^0.6.12;

interface IProxy {
    function upgradeTo(address newImplementation) external;
    function admin() external view returns (address);
}
