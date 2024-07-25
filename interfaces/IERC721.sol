// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

interface IERC721 {

    event Mint(address indexed to, uint256 indexed tokenId);
    event Burn(address indexed from, uint256 indexed tokenId);
    
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    function getName() external view returns (string memory name);
    function getSymbol() external view  returns (string memory symbol);
    function getTokenURI(uint256 tokenId) external view returns (string memory tokenURI);
    
    function balanceOf(address owner) external view returns (uint256 balance);
    function ownerOf(uint256 tokenId) external view returns (address owner);
    function mint(address to, uint256 tokenId, string calldata uri) external returns (address receiver, uint256);
    function burn(uint256 tokenId) external returns (bool);

}