// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title BORAToken
 * @dev Blockora Token with deflationary burning mechanism
 */
contract BORAToken {
    string public name = "Blockora";
    string public symbol = "BORA";
    uint8 public decimals = 18;
    uint256 public totalSupply;
    
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    
    address public owner;
    uint256 public constant BURN_RATE = 20; // 20% burn rate
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    
    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply * 10 ** uint256(decimals);
        balanceOf[msg.sender] = totalSupply;
        owner = msg.sender;
    }
    
    function transfer(address _to, uint256 _value) public returns (bool) {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");
        require(_to != address(0), "Invalid address");
        
        // Calculate burn amount
        uint256 burnAmount = (_value * BURN_RATE) / 100;
        uint256 transferAmount = _value - burnAmount;
        
        // Update balances
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += transferAmount;
        
        // Burn tokens
        totalSupply -= burnAmount;
        emit Burn(msg.sender, burnAmount);
        emit Transfer(msg.sender, _to, transferAmount);
        
        return true;
    }
    
    function approve(address _spender, uint256 _value) public returns (bool) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require(balanceOf[_from] >= _value, "Insufficient balance");
        require(allowance[_from][msg.sender] >= _value, "Allowance exceeded");
        require(_to != address(0), "Invalid address");
        
        // Calculate burn amount
        uint256 burnAmount = (_value * BURN_RATE) / 100;
        uint256 transferAmount = _value - burnAmount;
        
        // Update balances and allowance
        balanceOf[_from] -= _value;
        balanceOf[_to] += transferAmount;
        allowance[_from][msg.sender] -= _value;
        
        // Burn tokens
        totalSupply -= burnAmount;
        emit Burn(_from, burnAmount);
        emit Transfer(_from, _to, transferAmount);
        
        return true;
    }
    
    function mint(address _to, uint256 _amount) public onlyOwner {
        totalSupply += _amount;
        balanceOf[_to] += _amount;
        emit Transfer(address(0), _to, _amount);
    }
}
