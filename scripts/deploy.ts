import { ethers } from "hardhat";


async function deployContract(contractName, ...args) {
    const Contract = await ethers.getContractFactory(contractName);
    const contract = await Contract.deploy(...args);
    await contract.deployed();
    console.log(`${contractName} deployed to:`  , contract.address);
    return contract;
}

async function main() {
    // Mock addresses for demonstration
    const feeToSetter = '0x0a395e6B3B276fE0eFe4Cf157bD64e7478941A85'; // Replace with actual address
    const WETHAddress = '0xeb72756ee12309Eae82a0deb9787e69f5b62949c'; // Replace with actual WETH address


    const quantumCoinPair1 = await deployContract("QuantumCoinRouter", "0x4A708e86bE7b1b53cB0B876dFb97187AB7b9Cd88", WETHAddress);

}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
