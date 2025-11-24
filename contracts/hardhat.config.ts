import { HardhatUserConfig } from "hardhat/config";
import dotenv from "dotenv";
dotenv.config();

const config: HardhatUserConfig = {
  solidity: "0.8.20",
  networks: {
    blockora: {
      url: process.env.RPC_URL || "",
      accounts: process.env.VALIDATOR_PRIVATE_KEY ? [process.env.VALIDATOR_PRIVATE_KEY] : [],
    },
  },
};

export default config;

