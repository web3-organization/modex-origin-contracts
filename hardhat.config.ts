import "@nomiclabs/hardhat-ethers";
import "@nomicfoundation/hardhat-verify";

import { HardhatUserConfig } from "hardhat/config";

const config: HardhatUserConfig = {
  networks: {
    "mode": {
      url: "https://sepolia.mode.network/",
      chainId: 919,
      accounts: ["2ab873b2fe04dcb06dfea8538b348e0c0d67d70e57f5c6e94f3b518117140970"] //BE VERY CAREFUL, DO NOT PUSH THIS TO GITHUB
    }
  },
  etherscan: {
    apiKey: {
      "mode": "MODE-NETWORK-TESTNET",
    },
    customChains: [
      {
        network: "mode",
        chainId: 919,
        urls: {
          apiURL: "https://sepolia.explorer.mode.network/api",
          browserURL: "https://sepolia.explorer.mode.network",
        },
      },
    ],
  },
  sourcify: {
    enabled: false,
  },
  solidity: {
    compilers: [
      {
        version: "0.8.0",
        settings: {
          optimizer: {
            enabled: true,
            runs: 99999,
          },
        },
      },
        {
            version: "0.8.20",
            settings: {
            optimizer: {
                enabled: true,
                runs: 99999,
            },
            },
        },
      {
        version: "0.8.4",
        settings: {
          optimizer: {
            enabled: true,
            runs: 99999,
          },
        },
      },
      {
        version: "0.6.6",
        settings: {
          optimizer: {
            enabled: true,
            runs: 99999,
          },
        },
      },
      {
        version: "0.5.16",
        settings: {
          optimizer: {
            enabled: true,
            runs: 99999,
          },
        },
      },
      {
        version: "0.4.18",
        settings: {
          optimizer: {
            enabled: true,
            runs: 99999,
          },
        },
      },
    ],
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts",
  }
};

export default config;
