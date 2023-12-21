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
    // const feeToSetter = '0x0a395e6B3B276fE0eFe4Cf157bD64e7478941A85'; // Replace with actual address
    // const WETHAddress = '0xeb72756ee12309Eae82a0deb9787e69f5b62949c'; // Replace with actual WETH address


    // const quantumCoinPair1 = await deployContract("QuantumCoinRouter", "0x4A708e86bE7b1b53cB0B876dFb97187AB7b9Cd88", WETHAddress);


    // steps: 
    // 1. deploy factory
    // 2. deploy router
    // 3. deploy 10 gem tokens and 1 usdt
    // 4. approve 11 tokens to router
    // 5. add 10 gem tokens and 1 usdt to factory as pairs
    // 6. add liquidity for each gem token and usdt pair for half of the total supply of each token and 1% of the usdt
    // 7. deploy pocket index with usdt as base token and router address
    // 8. add all 10 gem tokens to pocket index
    // 9. verify all the contracts
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
