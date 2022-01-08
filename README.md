# Final project - Token Farm

## Deployed version url:

https://final-project-xyoungsavagex.netlify.app

## Setup

### Prerequisites
- Python
- Yarn
- Node.js
- Brownie and Ganache

### Deploying the Smart Contracts
1. Clone the repo
```
git clone https://github.com/xyoungsavagex242/blockchain-developer-bootcamp-final-project
cd blockchain-developer-bootcamp-final-project
```
2. Add a .env file to the project's root folder with the following:
- [Environment Variables](#environment-variables-not-needed-for-running-tests)

**MAKE SURE TO SAVE YOUR FILE!**

3. In your terminal, run:
```bash
brownie run scripts/deploy.py --network rinkeby
```
### Running Tests
- In the project's root directory run the following in terminal:
`brownie test`

### Frontend

- Change your directory to front_end: `cd front_end`

- Add a .env file in this directory and add the following:
```bash
SKIP_PREFLIGHT_CHECK=true
```
**MAKE SURE TO SAVE YOUR FILE!**

- Install the dependencies: `yarn install`

- View the frontend in your browser: `yarn run start`

- Open `http://localhost:3000`(It should open automatically.)

## Screencast link
https://youtu.be/KHewveZf7OY

## Project description
- This application allow users to stake/deposit their ERC20 token into this TokenFarm contract.
- Users can use this application to invest in a defi protocol to gain interest, build a yield aggregator and more!

## Simple workflow
### To Stake Tokens
1. Open the website
2. Login with MetaMask on the Rinkeby Network
3. To get **Mock DAI(FAU)** in your wallet, visit https://erc20faucet.com/.
4. Input your address, choose any amount of tokens you would like to mint and hit Connect and choose MetaMask as your Web3 Wallet.
5. Select **Mint Free Tokens**.
6. Go back to the **DAI** tab in **My Wallet** Section.
7. Choose an amount of **DAI Tokens** you would like to stake and select the stake button.

### To Unstake All Tokens
1. In **The TokenFarm Contract** section, choose a `token` to unstake.
2. Select the **Unstake all `token`** button to unstake tokens.


## Directory structure
- `contracts`: Smart contracts that are deployed in the Rinkeby testnet.
- `front_end`: Project's React Frontend
- `migrations`: Migration files for deploying contracts in `contracts` directory.
- `test`: Tests for smart contracts.
## Environment variables (not needed for running tests)

```bash
export WEB3_INFURA_PROJECT_ID=<PROJECT_ID>
export PRIVATE_KEY=<PRIVATE_KEY>
export ETHERSCAN_TOKEN=<YOUR_TOKEN>
SKIP_PREFLIGHT_CHECK=true
```

