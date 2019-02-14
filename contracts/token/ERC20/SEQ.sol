pragma solidity ^0.5.2;

import "./IERC20.sol";
import "../../math/SafeMath.sol";
import "../../ownership/Ownable.sol";

// SEQRegistry interface file
import "../../../../seq-registry/contracts/service/RegistryInterface.sol";

contract SEQ is IERC20, Ownable {
    using SafeMath for uint256;

    address private _registryAddress;

    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowed;

    uint256 private _totalSupply;

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address owner) public view returns (uint256) {
        return _balances[owner];
    }

    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowed[owner][spender];
    }

    function transfer(address to, uint256 value) public returns (bool) {
        _transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) public returns (bool) {
        _approve(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        _transfer(from, to, value);
        _approve(from, msg.sender, _allowed[from][msg.sender].sub(value));
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        _approve(msg.sender, spender, _allowed[msg.sender][spender].add(addedValue));
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        _approve(msg.sender, spender, _allowed[msg.sender][spender].sub(subtractedValue));
        return true;
    }

    function _transfer(address from, address to, uint256 value) internal {
        require(to != address(0));

        // Registry check 
        RegistryInterface _registry = RegistryInterface(_registryAddress);
        require(_registry.check(to) >= 0x10);

        _balances[from] = _balances[from].sub(value);
        _balances[to] = _balances[to].add(value);
        emit Transfer(from, to, value);
    }

    function _mint(address account, uint256 value) internal {
        require(account != address(0));

        _totalSupply = _totalSupply.add(value);
        _balances[account] = _balances[account].add(value);
        emit Transfer(address(0), account, value);
    }

    function _approve(address owner, address spender, uint256 value) internal {
        require(spender != address(0));
        require(owner != address(0));

        _allowed[owner][spender] = value;
        emit Approval(owner, spender, value);
    }


    function _changeRegistry(address registry) internal {
        require(registry != address(0));
        _registryAddress = registry;
        emit ChangeRegistry(registry, msg.sender);
    }
    event ChangeRegistry(address indexed registry, address indexed executor);
    function changeRegistry(address registry) public onlyOwner returns (bool) {
        _changeRegistry(registry);
        return true;
    }

    function registryAddress() public view returns (address) {
        return _registryAddress;
    }

    function registryCheck(address account) public view returns (uint256) {
        RegistryInterface _registry = RegistryInterface(_registryAddress);
        return _registry.check(account);
    }
}