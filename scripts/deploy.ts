import { writeFileSync } from 'fs';
import { ethers } from "hardhat";
import {name, symbol} from "../tokenInit";

async function main() {
    const MyERC721 = await ethers.getContractFactory(name);
    const MyERC721 = await MyERC721.deploy(name, symbol);

    await MyERC721.waitForDeployment();

    console.log(`Contract deployed to: ${MyERC721.target}`);
    const addresses = {contractAddress: MyERC721.target, ownerAddress: MyERC721.deploymentTransaction()?.from};
    writeFileSync("addresses.json", JSON.stringify(addresses, null, 2));
    
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});