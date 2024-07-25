// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "../interfaces/IERC20.sol";

contract ERC20 is IERC20 {

    string internal  name;
    string internal  symbol;
    uint8 internal   decimals;


    mapping(address => uint256) balances;

    mapping(address => mapping (address => uint256)) allowed;

    uint256 totalSupply_;
    address contractOwner;


   constructor(uint256 _initialSupply, address _owner, string memory _name, string memory _symbol, uint8 _decimals) {
    totalSupply_ = _initialSupply;
    contractOwner = _owner;
    name = _name;
    symbol = _symbol;
    decimals = _decimals;
    balances[_owner] = _initialSupply;
    }

    modifier onlyAccHaveAccess {
        require(msg.sender == contractOwner, "Only contract owner allow to use this function");
        _;
    }

    function getName() external override view returns (string memory){
        return name;
    }

    function getSymbol() external override view returns (string memory){
        return symbol;
    }

    function getDecimals() external override view returns (uint8){
        return decimals;
    }

    function totalSupply() public override view returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address tokenOwner) public override view returns (uint256) {
        return balances[tokenOwner];
    }

    function mint(address mintAddress, uint256 numTokens) public onlyAccHaveAccess override returns (bool){
        balances[mintAddress] = balances[mintAddress] + numTokens;
        totalSupply_ = totalSupply_ + numTokens;
        return true;
    }

    function burn(uint256 numTokens) public override returns (bool){
        balances[msg.sender] = balances[msg.sender] - numTokens;
        totalSupply_ = totalSupply_ - numTokens;
        return true;
    }

    function transfer(address recipient, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[msg.sender], "Not enough balances to spend");
        balances[msg.sender] = balances[msg.sender]-numTokens;
        balances[recipient] = balances[recipient]+numTokens;

        emit Transfer(msg.sender, recipient, numTokens);
        return true;
    }

    function batchTransfer(address [] memory recipient, uint256 [] memory numTokens) public override returns (bool){
        for(uint256 i = 0; i<=recipient.length - 1 ; i++){
            transfer(recipient[i], numTokens[i]);
        }

        return true;
    }

    function approve(address spender, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[msg.sender], "Not enough balances to spend");


        allowed[msg.sender][spender] += numTokens;
        emit Approval(msg.sender, spender, numTokens);
        return true;
    }

    function deapprove(address spender, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[msg.sender], "Not enough balances to cancel");
        require(numTokens <= allowed[msg.sender][spender], "Not enough allowance to cancel");


        allowed[msg.sender][spender] = allowed[msg.sender][spender] - numTokens;
        emit Deapproval(msg.sender, spender, numTokens);
        return true;
    }

    function allowance(address owner, address spender) public override view returns (uint) {
        return allowed[owner][spender];
    }

    function transferFrom(address sender, address recipient, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[sender], "Not enough balances to spend");
        require(numTokens <= allowed[sender][msg.sender], "Not enough allowance to spend");
        balances[sender] = balances[sender] - numTokens;
        allowed[sender][msg.sender] = allowed[sender][msg.sender] - numTokens;
        balances[recipient] = balances[recipient] + numTokens;
        emit Transfer(sender, recipient, numTokens);
        return true;
    }
}