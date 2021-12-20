pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SwiftToken is ERC20 {
    constructor() public ERC20("Swift Token", "SWIFT"){
        _mint(msg.sender, 1000000000000000000000000);
    }
}
