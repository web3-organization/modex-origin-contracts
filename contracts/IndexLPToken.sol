// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract IndexLPToken is ERC20, Ownable {
    constructor(address indexOwnerContract)
        ERC20("Index LP Token", "ILP")
        Ownable(indexOwnerContract)
    {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(address account, uint256 value) public onlyOwner {
        _burn(account, value);
    }
}