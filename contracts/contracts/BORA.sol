// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BORA is ERC20, Ownable {
    // Total max supply: 100,000,000 BORA
    uint256 public constant MAX_SUPPLY = 100_000_000 ether;

    constructor(
        address founder,
        uint256 founderAmount,
        address rewardsReceiver,
        uint256 rewardsAmount
    ) ERC20("BORA Token", "BORA") {
        require(founder != address(0), "founder is zero");
        require(rewardsReceiver != address(0), "rewards receiver is zero");

        uint256 total = founderAmount + rewardsAmount;
        require(total <= MAX_SUPPLY, "exceeds max supply");

        _mint(founder, founderAmount);
        _mint(rewardsReceiver, rewardsAmount);
    }
}
