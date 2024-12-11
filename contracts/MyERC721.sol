// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;
import "interfaces/IMyERC721.sol";

contract MyERC721 is IMyERC721{
    address public owner;
    string public name;
    string public symbol;
    uint256 public totalSupply;

    modifier notZeroAddress {
        require()
    }
    mapping (address => uint256) private balances;
    mapping (address => uint256) private owners;
    mapping (address => uint256) public tokenByIndex;
    mapping (uint256 => address) private approved;
    mapping (address => mapping (address => bool)) public isApprovedForAll;

    constructor(string memory _name, string memory _symbol){
        owner = msg.sender;
        name = _name;
        symbol = _symbol;
        totalSupply = 0;
    }

    function mint(address _to, uint256 _tokenId) public{
        require(
            msg.sender == _to ||
            msg.sender == owner, 
            "U cant mint tokens for other users"
        );
        require(tokenByIndex[_tokenId] == 0, "Token with this Id already exists");
        
        totalSupply++;
        balances[_to]++;
        owners[_tokenId] = _to;

        emit Mint(address(0), _to, _tokenId);
    }

    function burn(address _from, _tokenId) public{
        require(
            msg.sender == _from ||
            msg.sender == owner, 
            "U cant burn tokens of other users"
            );
        
        require(tokenByIndex[_tokenId] != 0, "There are no tokens with entered Id");

        totalSupply--;
        balances[_from]--;
        delete owners[_tokenId];
        
        emit Burn(_from, address(0), _tokenId);
    }

    function approve(address _approved, uint256 _tokenId) public {
        address _tokenOwner = owners[_tokenId];
        require(
            msg.sender == _tokenOwner ||
            isApprovedForAll[_tokenOwner][msg.sender] == true, 
            "Only owner of token or operator can approve the transfer"
            );
        approved[_tokenId] = _approved;

        emit Approval(msg.sender, _approved, _tokenId);
    }

    function setApprovalForAll(address _operator, bool _approved) public {
        require(msg.sender == owners[_tokenId], "Only owner can manage the permissions for operator");
        isApprovedForAll[msg.sender][_operator] = _approved;

        emit ApprovalForAll(address msg.sender, address _operator, bool _approved);
    }

    modifier ownerOperatorApprovedUser(address _from, address _to, uint256 _tokenId) {
        address _tokenOwner = owners[_tokenId];
        require(
            msg.sender == approved[_tokenId] ||
            msg.sender == _from ||
            isApprovedForAll[_tokenOwner][msg.sender], 
            "Only owner of token, operator and approved user can transfer tokens"
        );
    }

    modifier safeTransfer() {
        require(_from == owners[_tokenId], "U can transfer tokens only from owner");
        require(_to != address(0), "Invalid receiver address");
        require(owners[_tokenId] != address(0), "Invalid NFT Id");
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public ownerOperatorApprovedUser {     
        transfer(_from, _to, _tokenId);
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) public ownerOperatorApprovedUser safeTransfer{
        transfer(_from, _to, _tokenId);
    }
    
    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data) public  ownerOperatorApprovedUser safeTransfer{
        transfer(_from, _to, _tokenId);
        //написать проверку
        if (_to)
    }

    function transfer(address _from, adress _to, uint256 _tokenId) internal {
        balances[_from]--;
        balances[_to]++;
        owners[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }
}