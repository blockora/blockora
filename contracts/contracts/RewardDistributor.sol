// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// Mining rewards + halving scheduler (simplified)
contract RewardDistributor {
    IERC20 public immutable token;
    uint64 public immutable genesis;        // start timestamp
    uint64 public constant HALVING_SEC = 63072000; // ~2 saal
    uint256 public baseYearly = 2_800_000 ether;   // TODO (Hindi): edit if needed
    uint256 public distributed;             // total distributed for accounting

    mapping(address => uint256) public pending; // demo: off-chain calc -> on-chain claim

    mapping(address=>bool) public authorized;

    modifier onlyAuth(){ require(authorized[msg.sender], "not auth"); _; }

    function setAuthorized(address a, bool ok) external {
        // TODO (Hindi): is function ko DAO/multisig pe shift karo (abhi open for POC)
        authorized[a] = ok;
    }

    constructor(IERC20 _token){ token = _token; genesis = uint64(block.timestamp); }

    function currentRate() public view returns (uint256 yearly) {
        uint256 elapsed = block.timestamp - genesis;
        uint256 halvings = elapsed / HALVING_SEC;
        yearly = baseYearly >> halvings; // divide by 2^halvings
    }

    function credit(address user, uint256 amount) external onlyAuth {
        // TODO (Hindi): is function ko validators/authorized miner-set hi call kar sake (access control add karo)
        pending[user] += amount;
    }

    function claim() external {
        uint256 amt = pending[msg.sender];
        require(amt > 0, "nothing");
        pending[msg.sender] = 0;
        distributed += amt;
        token.transfer(msg.sender, amt);
    }
}
