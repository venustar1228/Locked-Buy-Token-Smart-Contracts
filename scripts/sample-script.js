// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  const [owner, account1, account2] = await hre.ethers.getSigners();
  const lockedSale = await hre.ethers.getContractFactory("lockedSale");
  const instance_lockedSale = await lockedSale.deploy("0x669c40dec7135f8f6dda00eb8d2e3937a83549fc", 10, 1000);
  await instance_lockedSale.deployed();
  console.log("TestCC deployed to:", instance_lockedSale.address);
} 

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
