// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "./ERC20.sol";
import "./ERC721.sol";


contract Factory {

    ERC20 private ERC20Factory;
    ERC721 private ERC721Factory;

    event ERC20TokenCreated(address indexed tokenAddress, address indexed owner, uint256 initialSupply);
    event ERC721TokenCreated(address indexed tokenAddress, address indexed owner, string name, string symbol);

    function createERC20 (uint256 _initialSupply, string memory _name, string memory _symbol, uint8 _decimals) external returns (address) {
        ERC20Factory = new ERC20(_initialSupply, msg.sender, _name, _symbol, _decimals);

        emit ERC20TokenCreated(address(ERC20Factory), msg.sender, _initialSupply);
        return address(ERC20Factory);
    }

    function createERC721 (string memory _name, string memory _symbol) external returns (address) {
        ERC721Factory = new ERC721(msg.sender, _name, _symbol);

        emit ERC721TokenCreated(address(ERC721Factory), msg.sender, _name, _symbol);
        return address(ERC721Factory);
    }
}