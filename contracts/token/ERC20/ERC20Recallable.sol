pragma solidity ^0.5.2;

import "./SEQ.sol";
import "../../access/roles/OperatorRole.sol";

contract ERC20Recallable is SEQ, OperatorRole {
    
    function recall(address from, address to, uint256 value, uint256 reason) public onlyOperator returns (bool) {
        _recall(from, to, value, reason);
    }

    event Recall(address indexed from, address indexed to, uint256 value, address indexed operator, uint256 reason);

    function _recall(address from, address to, uint256 value, uint256 reason) internal {
        require(to != address(0));
        _transfer(from, to, value);
        emit Recall(from, to, value, msg.sender, reason);
    }
}