// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

interface IERC20 {
    
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);
    function getName() external view returns (string memory);
    function getSymbol() external view returns (string memory);
    function getDecimals() external view returns (uint8);

    function mint(address mintAddress, uint256 numTokens) external returns (bool);
    function burn(uint256 numTokens) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function batchTransfer(address [] memory recipient, uint256 [] memory numTokens) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function deapprove(address spender, uint256 numTokens) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Deapproval(address indexed owner, address indexed spender, uint256 value);
}