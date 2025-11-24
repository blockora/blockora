// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// Fee split: burn + rewardPool + daoTreasury
contract FeeManager {
    IERC20 public immutable token;
    address public daoTreasury;
    address public rewardPool;
    uint16 public burnBps = 5000;    // 50% burn
    uint16 public rewardBps = 3000;  // 30% reward pool
    uint16 public treasuryBps = 2000;// 20% treasury

    event FeeProcessed(uint256 fee, uint256 burned, uint256 reward, uint256 treasury);
    event SplitsChanged(uint16 burn, uint16 reward, uint16 treasury);

    constructor(IERC20 _token, address _rewardPool, address _daoTreasury) {
        token = _token; rewardPool = _rewardPool; daoTreasury = _daoTreasury;
    }

    function setSplits(uint16 _burn, uint16 _reward, uint16 _treasury) external {
        // TODO (Hindi): Production me DAO Governor ke through hi badalna.
        require(_burn + _reward + _treasury == 10000, "bad sum");
        burnBps = _burn; rewardBps = _reward; treasuryBps = _treasury;
        emit SplitsChanged(_burn, _reward, _treasury);
    }

    function process(uint256 amount) external {
        uint256 burned = amount * burnBps / 10000;
        uint256 toReward = amount * rewardBps / 10000;
        uint256 toTreasury = amount - burned - toReward;
        token.transfer(address(0x000000000000000000000000000000000000dEaD), burned);
        token.transfer(rewardPool, toReward);
        token.transfer(daoTreasury, toTreasury);
        emit FeeProcessed(amount, burned, toReward, toTreasury);
    }
}
