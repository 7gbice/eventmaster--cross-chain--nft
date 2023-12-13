# eventmaster--cross-chain--nft

# Technology Stack & Tools

- Solidity (Writing Smart Contracts & Tests)
- Javascript (React & Testing)
- [Hardhat](https://hardhat.org/) (Development Framework)
- [Ethers.js](https://docs.ethers.io/v5/) (Blockchain Interaction)
- [React.js](https://reactjs.org/) (Frontend Framework)
- [MetaMask](https://metamask.io/)

## Requirements For Initial Setup
- Install [NodeJS](https://nodejs.org/en/). Recommended to use the LTS version.
- Install [MetaMask](https://metamask.io/) on your browser.

## Setting Up
### 1. Clone/Download the Repository
`$ git clone https://github.com/your-username/EventMaster_Cross_Chain_Nft.git `
`$ cd EventMaster_Cross_Chain_Nft`

### 2. Install Dependencies:
`$ npm install`

### Install Chainlink Dependencies

`$ npm install @chainlink/contracts-ccip@0.8 @openzeppelin/contracts`

### 3. Run tests
`$ npx hardhat test`

### 4. Start Hardhat node
`$ npx hardhat node`

### 5. Run deployment script
In a separate terminal execute:
`$ npx hardhat run ./scripts/deploy.js --network localhost`

### 6. Start frontend
`$ npm run start`

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.ts
```
# eventMaster-multiChain--nft
