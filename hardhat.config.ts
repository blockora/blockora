import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-verify";
import * as dotenv from "dotenv";
dotenv.config();

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.23",
    settings: {
      optimizer: { enabled: true, runs: 200 },
    },
  },

  paths: {
    sources: "./contracts/contracts",
    tests: "./contracts/test",
    cache: "./contracts/cache",
    artifacts: "./contracts/artifacts",
  },

  defaultNetwork: "hardhat",

  networks: {
    hardhat: {},

    blockora: {
      url: process.env.RPC_URL || "",
      accounts:
        process.env.VALIDATOR_PRIVATE_KEY
          ? [process.env.VALIDATOR_PRIVATE_KEY]
          : [],
    },

    polygonAmoy: {
      url: process.env.RPC_URL || "",
      accounts:
        process.env.VALIDATOR_PRIVATE_KEY
          ? [process.env.VALIDATOR_PRIVATE_KEY]
          : [],
      chainId: 80002,
    },
  },

  etherscan: {
    apiKey: {
      polygonAmoy: process.env.POLYGONSCAN_API || "",
    },
    customChains: [
      {
        network: "polygonAmoy",
        chainId: 80002,
        urls: {
          apiURL: "https://api-amoy.polygonscan.com/api",
          browserURL: "https://amoy.polygonscan.com",
        },
      },
    ],
  },
};

export default config;
