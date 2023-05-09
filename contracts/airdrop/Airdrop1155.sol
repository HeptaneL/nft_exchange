// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Airdrop1155 is ERC1155, Ownable {

    using Strings for uint256;

    mapping(uint256 => bool) private mintedTokenIds;
    mapping (address => bool) public _minters;

    constructor(string memory _baseURI)
    ERC1155(_baseURI) {
        _minters[msg.sender] = true;
    }

    function _exists(uint256 tokenId) internal view virtual returns (bool) {
        return mintedTokenIds[tokenId] == true;
    }

    function airdrop(uint256 tokenId,address[] calldata whiteList,uint256[] calldata amounts) external  {

        require(_minters[msg.sender], "!minter");

        require(whiteList.length == amounts.length);
        for (uint i=0; i<whiteList.length; i++) {
            address to = whiteList[i];
            require(to != address(0),"Address is not valid");
            super._mint(to,tokenId,amounts[i],"");
        }
        if (!_exists(tokenId)){
            mintedTokenIds[tokenId] = true;
        }
    }

    function uri(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId),"tokenId not exist");
        string memory baseURI = super.uri(0);
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString())) : "";
    }

    function setURIPrefix(string memory baseURI) public onlyOwner{
        super._setURI(baseURI);
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
