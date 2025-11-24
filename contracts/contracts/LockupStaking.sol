// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// Lockup = Mining multiplier ke liye stake/lock
contract LockupStaking {
    IERC20 public immutable token;
    struct Stake { uint256 amount; uint64 start; uint64 daysLocked; }
    mapping(address => Stake) public stakes;

    event Locked(address indexed user, uint256 amount, uint64 daysLocked);
    event Unlocked(address indexed user, uint256 amount);

    constructor(IERC20 _token) { token = _token; }

    function lock(uint256 amount, uint64 daysLocked) external {
        require(daysLocked >= 30, "min 30d");
        token.transferFrom(msg.sender, address(this), amount);
        Stake storage s = stakes[msg.sender];
        s.amount += amount; s.start = uint64(block.timestamp); s.daysLocked = daysLocked;
        emit Locked(msg.sender, amount, daysLocked);
    }

    function canUnlock(address u) public view returns (bool) {
        Stake memory s = stakes[u];
        return s.amount > 0 && block.timestamp >= s.start + uint64(s.daysLocked) * 1 days;
    }

    function unlock() external {
        require(canUnlock(msg.sender), "not matured");
        uint256 amt = stakes[msg.sender].amount; delete stakes[msg.sender];
        token.transfer(msg.sender, amt);
        emit Unlocked(msg.sender, amt);
    }

    function viewStake(address u) external view returns (Stake memory) { return stakes[u]; }
}
