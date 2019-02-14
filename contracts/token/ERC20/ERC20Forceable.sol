pragma solidity ^0.5.2;

import "./SEQ.sol";
import "../../access/roles/OperatorRole.sol";

contract ERC20Forceable is SEQ, OperatorRole {
    
    function forcedTransfer(address from, address to, uint256 value, uint256 reason) public onlyOperator returns (bool) {
        _forcedTransfer(from, to, value, reason);
    }

    event ForcedTransfer(address indexed from, address indexed to, uint256 value, address indexed operator, uint256 reason);

    function _forcedTransfer(address from, address to, uint256 value, uint256 reason) internal {
        require(to != address(0));
        _transfer(from, to, value);
        emit ForcedTransfer(from, to, value, msg.sender, reason);
    }
}