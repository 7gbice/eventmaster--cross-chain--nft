// Import necessary modules
import * as dotenv from "dotenv";
dotenv.config();
import { HardhatUserConfig } from "hardhat/config";

// Import Hardhat plugins
import "@nomicfoundation/hardhat-toolbox";
import "hardhat-deploy";
import "@matterlabs/hardhat-zksync-solc";
import "@matterlabs/hardhat-zksync-verify";
import "@nomiclabs/hardhat-waffle";
import "@nomiclabs/hardhat-ethers";
import "hardhat-deploy";
import "hardhat-deploy-ethers";

// Define Hardhat configuration
const config: HardhatUserConfig = {
  // Solidity compiler settings
  solidity: {
    version: "0.8.19",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200, // Number of runs for the optimizer
      },
      // Additional paths for importing contracts
      paths: ["@chainlink/contracts-ccip/src/v0.8"],
    },
  },
  
  // Default network settings
  defaultNetwork: "localhost",
  
  // Named accounts configuration
  namedAccounts: {
    deployer: {
      default: 0, // Use the first Hardhat account as the deployer by default
    },
  },
  
  // Network configurations
  networks: {
    // Hardhat network forking settings
    hardhat: {
      forking: {
        url: `https://eth-mainnet.alchemyapi.io/v2/${process.env.ALCHEMY_API_KEY || "oKxs-03sij-U_N0iOlrSsZFr29-IqbuF"}`,
        enabled: process.env.MAINNET_FORKING_ENABLED === "true",
      },
    },
    
    // Mainnet configuration
    mainnet: {
      url: `https://eth-mainnet.alchemyapi.io/v2/${process.env.ALCHEMY_API_KEY || "oKxs-03sij-U_N0iOlrSsZFr29-IqbuF"}`,
      accounts: [process.env.DEPLOYER_PRIVATE_KEY || "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"],
    },
    
    // ... Other network configurations ...

    // ZkSync testnet configuration
    zkSyncTestnet: {
      url: "https://testnet.era.zksync.dev",
      zksync: true,
      accounts: [process.env.DEPLOYER_PRIVATE_KEY || ""],
      verifyURL: "https://zksync2-testnet-explorer.zksync.dev/contract_verification",
    },
    
    // ... Other network configurations ...

    // Public Goods Network testnet configuration
    pgnTestnet: {
      url: "https://sepolia.publicgoods.network",
      accounts: [process.env.DEPLOYER_PRIVATE_KEY || ""],
    },
  },
  
  // Verification settings
  verify: {
    etherscan: {
      apiKey: `${process.env.ETHERSCAN_API_KEY || "DNXJA8RX2Q3VZ4URQIWP7Z68CJXQZSC6AW"}`,
    },
  },
};

// Export the configuration
export default config;
