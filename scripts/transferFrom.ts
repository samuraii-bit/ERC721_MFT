import { ethers } from "hardhat";
import readline from "readline-sync";
import {contractAddress} from '../addresses.json';
import {name} from "../tokenInit";

async function main() {
    let transferFromAddress: string;
    let transferToAddress: string;
    let tokenId: bigint;

    transferFromAddress = ethers.getAddress(readline.question("Please enter address from which u want to transfer token: "));
    while (!ethers.isAddress(transferFromAddress)){
        transferFromAddress = ethers.getAddress(readline.question("An invalid adddress was entered. Please, try again: "));
    }

    transferToAddress = ethers.getAddress(readline.question("Please enter address to which u want to transfer token: "));
    while (!ethers.isAddress(transferToAddress)){
        transferToAddress = ethers.getAddress(readline.question("An invalid adddress was entered. Please, try again: "));
    }

    tokenId = BigInt(readline.question("Please enter the token Id: "));
    while (tokenId < 0){
        tokenId = BigInt(readline.question("Invalid token Id was entered: "));
    }

    const MyFirstToken = await ethers.getContractAt(name, contractAddress);
    const users = await ethers.getSigners();

    const tx = await MyFirstToken.connect(users[1]).transferFrom(transferFromAddress, transferToAddress, tokenId);
    const receipt = await tx.wait();

    if (receipt?.status === 1) {
        console.log(`token with Id ${tokenId} successfully transfered from ${transferFromAddress} to ${transferToAddress}`);
    } else {
        console.error("Transaction failed");
    }
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});