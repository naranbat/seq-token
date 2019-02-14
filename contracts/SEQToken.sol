pragma solidity ^0.5.2;

import "./token/ERC20/ERC20Mintable.sol";
import "./token/ERC20/ERC20Forceable.sol";
import "./token/ERC20/ERC20Recallable.sol";
import "./token/ERC20/SEQ.sol";
import "./token/ERC20/ERC20Detailed.sol";
import "./ownership/Ownable.sol";


contract SEQToken is Ownable, SEQ, ERC20Detailed, ERC20Mintable, ERC20Forceable, ERC20Recallable {

    uint8 public constant DECIMALS = 0;
    uint256 public constant INITIAL_SUPPLY = 10000 * (10 ** uint256(DECIMALS));

    constructor () 
        ERC20Detailed("SEQ Token", "SEQ", DECIMALS) 
        ERC20Mintable()
        ERC20Forceable()
        ERC20Recallable()
        SEQ()
        Ownable()
        public 
    { }
}