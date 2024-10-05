require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config()

/** @type import('hardhat/config').HardhatUserConfig */
const {LISK_RPC_URL, ACCOUNT_PRIVATE_KEY, ETHER_SCAN} = process.env
module.exports = {
  solidity: "0.8.24",
  networks:{
    "lisk-sepolia":{
      url:LISK_RPC_URL,
      accounts: ACCOUNT_PRIVATE_KEY !== undefined ? [ACCOUNT_PRIVATE_KEY] : []  
    }
    
  },
  etherscan: {
    // Use "123" as a placeholder, because Blockscout doesn't need a real API key, and Hardhat will complain if this property isn't set.
    apiKey: {
      "lisk-sepolia": "123",
    },/*  */
    customChains: [
      {
        network: "lisk-sepolia",
        chainId: 4202,
        urls: {
          apiURL: "https://sepolia-blockscout.lisk.com/api",
          browserURL: "https://sepolia-blockscout.lisk.com/",
        },
      },
    ],
  },
  sourcify: {
    enabled: false,
  },


  
};
