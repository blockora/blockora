// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

//  BORA token: 100,000,000 fixed supply.
//  30% Founder ke liye, 70% Rewards ke liye.

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BORA is ERC20, Ownable {
        uint256 public constant MAX_SUPPLY = 100_000_000 ether;

            // founder = owner of token + founder allocation address
                // rewardsReceiver = jisko 70% rewards tokens milenge
                    constructor(address founder, address rewardsReceiver)
                            ERC20("BORA", "BORA")     // ERC20 constructor
                                    Ownable(founder)          // Ownable v5 constructor
                                        {
                                                    require(
                                                                    founder != address(0) && rewardsReceiver != address(0),
                                                                                "BORA: zero address"
                                                    );

                                                            // 30% founder, 70% rewards
                                                                    uint256 founderAmount = (MAX_SUPPLY * 30) / 100;
                                                                            uint256 rewardsAmount = MAX_SUPPLY - founderAmount;

                                                                                    // safety check (optional)
                                                                                            require(
                                                                                                            founderAmount + rewardsAmount == MAX_SUPPLY,
                                                                                                                        "BORA: bad allocation"
                                                                                            );

                                                                                                    _mint(founder, founderAmount);
                                                                                                            _mint(rewardsReceiver, rewardsAmount);
                                        }
}
                                                                                            )
                                                    )
                                        }
}