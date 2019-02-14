pragma solidity ^0.5.2;

import "./token/ERC20/ERC20Mintable.sol";
import "./token/ERC20/ERC20.sol";
import "./token/ERC20/ERC20Detailed.sol";

contract SEQToken is ERC20, ERC20Detailed, ERC20Mintable {

    uint8 public constant DECIMALS = 18;
    uint256 public constant INITIAL_SUPPLY = 10000 * (10 ** uint256(DECIMALS));

    /**
     * @dev Constructor that gives msg.sender all of existing tokens.
     */
    constructor () 
        ERC20Detailed("SEQ Token", "SEQ", DECIMALS) 
        ERC20Mintable()
        ERC20()
        public 
    { }
}