import dotenv from "dotenv";
dotenv.config();
export const cfg = {
    port: Number(process.env.PORT || 9090),
    url: process.env.VALIDATOR_URL || "http://localhost:9090",
    rpc: process.env.RPC_URL,
    pk: process.env.VALIDATOR_PRIVATE_KEY,
    rewardDistributor: process.env.REWARD_DISTRIBUTOR_CONTRACT,
    lockup: process.env.LOCKUP_STAKING_CONTRACT,
    kyc: process.env.KYC_ADDRESS,
    pingInterval: Number(process.env.PING_INTERVAL_SEC || 60),
    sigPrefix: process.env.SIG_PREFIX || "blockora-ping",
};
