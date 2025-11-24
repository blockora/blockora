import { ethers } from "ethers";
import { cfg } from "../config.js";
const rewardAbi = [
    { "inputs": [{ "internalType": "address", "name": "user", "type": "address" }, { "internalType": "uint256", "name": "amount", "type": "uint256" }], "name": "credit", "outputs": [], "stateMutability": "nonpayable", "type": "function" },
    { "inputs": [], "name": "currentRate", "outputs": [{ "internalType": "uint256", "name": "yearly", "type": "uint256" }], "stateMutability": "view", "type": "function" },
    { "inputs": [{ "internalType": "address", "name": "", "type": "address" }], "name": "authorized", "outputs": [{ "internalType": "bool", "name": "", "type": "bool" }], "stateMutability": "view", "type": "function" }
];
const lockAbi = [
    { "inputs": [{ "internalType": "address", "name": "u", "type": "address" }], "name": "viewStake", "outputs": [{ "components": [{ "internalType": "uint256", "name": "amount", "type": "uint256" }, { "internalType": "uint64", "name": "start", "type": "uint64" }, { "internalType": "uint64", "name": "daysLocked", "type": "uint64" }], "internalType": "struct LockupStaking.Stake", "name": "", "type": "tuple" }], "stateMutability": "view", "type": "function" }
];
const kycAbi = [
    { "inputs": [{ "internalType": "address", "name": "", "type": "address" }], "name": "verified", "outputs": [{ "internalType": "bool", "name": "", "type": "bool" }], "stateMutability": "view", "type": "function" }
];
export function getProvider() {
    return new ethers.JsonRpcProvider(cfg.rpc);
}
export function getSigner() {
    return new ethers.Wallet(cfg.pk, getProvider());
}
export function getContracts() {
    const signer = getSigner();
    const reward = new ethers.Contract(cfg.rewardDistributor, rewardAbi, signer);
    const lock = new ethers.Contract(cfg.lockup, lockAbi, signer);
    const kyc = new ethers.Contract(cfg.kyc, kycAbi, signer);
    return { reward, lock, kyc };
}
