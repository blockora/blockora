import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from "dotenv";

dotenv.config();

const config: HardhatUserConfig = {
  solidity: {
      version: "0.8.23",
          settings: {
                optimizer: { enabled: true, runs: 200 },
                    },
                      },

                        networks: {
                            blockora: {
                                  url: process.env.RPC_URL || "",
                                        accounts:
                                                process.env.VALIDATOR_PRIVATE_KEY !== undefined
                                                          ? [process.env.VALIDATOR_PRIVATE_KEY]
                                                                    : [],
                                                                        },
                                                                          },
                                                                          };

                                                                          export default config;
