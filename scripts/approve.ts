import { ethers } from "hardhat";
import readline from "readline-sync";
import {contractAddress} from '../addresses.json';
import {name} from "../tokenInit";

async function main() {
    let allowAddress: string;
    let tokenId: bigint;

    allowAddress = ethers.getAddress(readline.question("Please enter address u want to allow to transfer your tokens: "));
    while (!ethers.isAddress(allowAddress)){
        allowAddress = ethers.getAddress(readline.question("An invalid adddress was entered. Please, try again: "));
    }

    tokenId = BigInt(readline.question("Please enter the token ID: "));
    while (tokenId < 0){
        tokenId = BigInt(readline.question("Invalid toke ID was entered: "));
    }

    const MyERC721 = await ethers.getContractAt(name, contractAddress);
    const users = await ethers.getSigners();

    const tx = await MyERC721.connect(users[1]).approve(allowAddress, tokenId);
    const receipt = await tx.wait();

    if (receipt?.status === 1) {
        console.log(`Now ${allowAddress} can transfer ${tokenId} from ${users[1].address}`);
    } else {
        console.error("Transaction failed");
    }
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});