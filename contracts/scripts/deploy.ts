import hre from "hardhat";
import { ethers } from "ethers";

async function main() {
  const founder = process.env.FOUNDER_ADDRESS!;
    const rewards = process.env.REWARDS_RECEIVER!;

      const founderAmount = hre.ethers.parseEther("30000000");
        const rewardsAmount = hre.ethers.parseEther("70000000");

          const BORA = await hre.ethers.getContractFactory("BORA");
            const bora = await BORA.deploy(
                founder,
                    founderAmount,
                        rewards,
                            rewardsAmount
                              );
                                await bora.waitForDeployment();
                                  console.log("BORA:", await bora.getAddress());

                                    const Lock = await hre.ethers.getContractFactory("LockupStaking");
                                      const lock = await Lock.deploy(await bora.getAddress());
                                        await lock.waitForDeployment();
                                          console.log("LockupStaking:", await lock.getAddress());

                                            const Fee = await hre.ethers.getContractFactory("FeeManager");
                                              const fee = await Fee.deploy(await bora.getAddress(), founder, rewards);
                                                await fee.waitForDeployment();
                                                  console.log("FeeManager:", await fee.getAddress());

                                                    const KYC = await hre.ethers.getContractFactory("KYCAttestor");
                                                      const kyc = await KYC.deploy();
                                                        await kyc.waitForDeployment();
                                                          console.log("KYCAttestor:", await kyc.getAddress());

                                                            const RD = await hre.ethers.getContractFactory("RewardDistributor");
                                                              const rd = await RD.deploy(await bora.getAddress());
                                                                await rd.waitForDeployment();
                                                                  console.log("RewardDistributor:", await rd.getAddress());
                                                                  }

                                                                  main().catch((e) => {
                                                                    console.error(e);
                                                                      process.exit(1);
                                                                      });