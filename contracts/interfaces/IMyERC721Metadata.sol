// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

interface IMyERC721Metadata {
    function name() external view returns (string memory _name);
    function symbol() external view returns (string memory _symbol);
}