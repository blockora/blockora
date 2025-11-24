// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

// Minimal KYC registry (multi-attestor ready). VC/zero-knowledge later add kar sakte ho.
contract KYCAttestor {
    // TODO (Hindi): Launch ke baad owner ko DAO Governor me shift karo.
    address public owner;
    mapping(address => bool) public attestor;
    mapping(address => bool) public verified;

    event AttestorSet(address indexed a, bool ok);
    event Verified(address indexed user, bool ok);

    constructor(){ owner = msg.sender; }
    modifier onlyOwner(){ require(msg.sender == owner, "not owner"); _; }
    modifier onlyAttestor(){ require(attestor[msg.sender], "not attestor"); _; }

    function setAttestor(address a, bool ok) external onlyOwner {
        attestor[a] = ok; emit AttestorSet(a, ok);
    }
    function setVerified(address user, bool ok) external onlyAttestor {
        verified[user] = ok; emit Verified(user, ok);
    }
}
