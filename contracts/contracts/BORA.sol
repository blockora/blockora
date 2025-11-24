// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title BORA token
/// @notice 100,000,000 fixed supply
///         30% founder ke liye, 70% rewards ke liye
contract BORA is ERC20, Ownable {
    // 100,000,000 * 10^18 (18 decimals)
    uint256 public constant MAX_SUPPLY = 100_000_000 ether;

    /// @param founder           founder ka wallet (30%)
    /// @param rewardsReceiver   rewards / community wallet (70%)
    constructor(address founder, address rewardsReceiver)
        ERC20("BORA", "BORA")
        Ownable(msg.sender) // OZ v5 ke hisaab se owner set
    {
        require(founder != address(0), "BORA: founder is zero");
        require(rewardsReceiver != address(0), "BORA: rewards is zero");

        uint256 founderAmount = (MAX_SUPPLY * 30) / 100; // 30%
        uint256 rewardsAmount = MAX_SUPPLY - founderAmount; // 70%

        _mint(founder, founderAmount);
        _mint(rewardsReceiver, rewardsAmount);
    }
}
