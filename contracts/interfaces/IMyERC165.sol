// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

interface IMyERC165 {
    function supportInterface(bytes4 interfaceID) external view returns (bool);
}