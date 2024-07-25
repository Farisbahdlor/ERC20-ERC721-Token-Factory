// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "../interfaces/IERC721.sol";

contract ERC721 is IERC721 {

    string private _name;

    string private _symbol;

    mapping(uint256 tokenId => address) private _owners;

    mapping(address owner => uint256) private _balances;

    mapping(uint256 tokenId => string) private _tokenURIs;

    address private _contractOwner;


    constructor(address contractOwner_, string memory name_, string memory symbol_) {
        _contractOwner = contractOwner_;
        _name = name_;
        _symbol = symbol_;
    }

    modifier onlyOwner {
        require(msg.sender == _contractOwner, "only contract owner can access this function.");
        _;
    }

    function balanceOf(address owner) public view override returns (uint256) {
        require(owner != address(0), "Address 0 is invalid ");

        return _balances[owner];
    }

    function ownerOf(uint256 tokenId) public view override returns (address) {
        return _requireOwned(tokenId);
    }

    function getName() public view override returns (string memory) {
        return _name;
    }

    function getSymbol() public view override returns (string memory) {
        return _symbol;
    }

    function getTokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId);

        return _tokenURIs[tokenId];
    }

    function _ownerOf(uint256 tokenId) internal view returns (address) {
        return _owners[tokenId];
    }

    function mint(address to, uint256 tokenId, string calldata uri) external onlyOwner override returns (address, uint256){
        require(to != address(0), "Address 0 is invalid ");

        _owners[tokenId] = to;
        _balances[to] += 1;
        _tokenURIs[tokenId] = uri;

        emit Mint(to, tokenId);

        return (to, tokenId);
    }

    function burn(uint256 tokenId) external override returns (bool){
        require(_owners[tokenId] == msg.sender, "Only owner of token can burn.");

        _owners[tokenId] = address(0);
        _balances[msg.sender] -= 1;
        _tokenURIs[tokenId] = "";

        emit Mint(msg.sender, tokenId);

        return true;
    }


    function _requireOwned(uint256 tokenId) internal view returns (address) {
        address owner = _ownerOf(tokenId);
        require(owner != address(0), "Address 0 is invalid ");
        
        return owner;
    }
}