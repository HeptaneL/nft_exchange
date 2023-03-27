// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

 
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Airdrop721 is ERC721, Ownable  {

  string  public baseURI;
  uint256 public lastTokenId;
  mapping (address => bool) public _minters;

  constructor(string memory _name,string memory _symbol,string memory _base) 
  ERC721(_name, _symbol) {
      baseURI = _base;
      _minters[msg.sender] = true;
  }

  function _baseURI() internal view override returns (string memory) {
      return baseURI;
  }

  function airdrop(address[] calldata whiteList) external {

      require(_minters[msg.sender], "!minter");

      for (uint i=0; i<whiteList.length; i++) {
            address to = whiteList[i];
            require(to != address(0),"Address is not valid");
            super._mint(to,lastTokenId+i+1);
      }
      lastTokenId = lastTokenId+whiteList.length;
  }

  function setURIPrefix(string memory _baseURI) public onlyOwner{
      baseURI = _baseURI;
  }

  function addMinter(address minter) public onlyOwner 
  {
      _minters[minter] = true;
  }
  
  function removeMinter(address minter) public onlyOwner 
  {
      _minters[minter] = false;
  }
}

