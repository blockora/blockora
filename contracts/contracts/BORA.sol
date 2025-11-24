// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

/*
  BORA token: 100,000,000 fixed supply.
  30% Founder ke liye, 70% Rewards ke liye.
*/

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BORA is ERC20, Ownable {
    uint256 public constant MAX_SUPPLY = 100_000_000 ether;

    constructor(
        address founder,
        uint256 founderAmount,
        address rewardsReceiver,
        uint256 rewardsAmount
    ) ERC20("BORA Coin", "BORA") {
        require(founder != address(0) && rewardsReceiver != address(0), "zero addr");
        require(founderAmount + rewardsAmount == MAX_SUPPLY, "bad allocations");
        _mint(founder, founderAmount);
        _mint(rewardsReceiver, rewardsAmount);
    }
}
