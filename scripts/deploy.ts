import { ethers } from "hardhat";


async function deployContract(contractName: any, ...args: any[]) {
    const Contract = await ethers.getContractFactory(contractName);
    const contract = await Contract.deploy(...args);
    await contract.deployed();
    console.log(`${contractName} deployed to:`  , contract.address);
    return contract;
}

async function main() {
    // deployer and weth address
    const WETHAddress = '0xeb72756ee12309Eae82a0deb9787e69f5b62949c'; // Replace with actual WETH address
    const deployer = (await ethers.getSigners())[0];
    // steps: 
    // 1. deploy factory
    const factory = await deployContract("QuantumCoinFactory", deployer.address);
    console.log("factory address: ", factory.address);
    // 2. deploy router
    const router = await deployContract("QuantumCoinRouter", factory.address, WETHAddress);
    console.log("router address: ", router.address);
    // 3. deploy 10 gem tokens and 1 usdt
    const gemTokens = ["DiamondToken", "EmberToken", "GarnateToken", "GLDToken", "JadeToken", "OpalToken", "PearlToken", "RubyToken", "SaphireToken", "SilverToken", "USDTToken"];
    const gemTokenAddresses = [];
    for (let i = 0; i < gemTokens.length; i++) {
        const gemToken = await deployContract(gemTokens[i]);
        console.log(`${gemTokens[i]} address: `, gemToken.address);
        gemTokenAddresses.push(gemToken.address);
    }
    // 4. approve 11 tokens to router
    for (let i = 0; i < gemTokenAddresses.length; i++) {
        const gemToken = await ethers.getContractAt(gemTokens[i], gemTokenAddresses[i]);
        await gemToken.approve(router.address, ethers.constants.MaxUint256);
    }
    // 5. add 10 gem tokens and 1 usdt to factory as pairs
    for (let i = 0; i < gemTokenAddresses.length - 1; i++) {
        await factory.createPair(gemTokenAddresses[i], gemTokenAddresses[10]);
    }
    // 6. add liquidity for each gem token and usdt pair for half of the total supply of each token and 1% of the usdt
    for (let i = 0; i < gemTokenAddresses.length - 1; i++) {
        await router.addLiquidity(
            gemTokenAddresses[i], 
            gemTokenAddresses[10], 
            ethers.utils.parseEther("5000000000000000000000000"), 
            ethers.utils.parseEther("10000000000000000000000000"), 
            ethers.utils.parseEther("5000000000000000000000000"), 
            ethers.utils.parseEther("10000000000000000000000000"), 
            deployer.address, 
            Date.now() + 1000 * 60 * 10
            );
    }
    // 7. deploy pocket index with usdt as base token and router address
    const pocketIndex = await deployContract("PocketIndex", gemTokenAddresses[10], router.address);
    // 8. add all 10 gem tokens to pocket index
    for (let i = 0; i < gemTokenAddresses.length - 1; i++) {
        await pocketIndex.addAsset(gemTokenAddresses[i]);
    }
    // 9. verify all the contracts

}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
