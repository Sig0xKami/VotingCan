require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config(); // Asegúrate de usar dotenv si usas variables de entorno

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.26",
  
networks: {
    sepolia: {
      url: "https://sepolia.infura.io/v3/2b851038fbe5448e8f32586b018efc71", // RPC público
      accounts: 
      [process.env.PRIVATE_KEY]
    },
    localhost: {
    url:"http://127.0.0.1:8545/"
  },
  amoy: {
      url: "https://rpc-amoy.polygon.technology/",
      accounts: [process.env.PRIVATE_KEY], // SIN el "0x"
      chainId: 80002
    },
  },
  
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY, // Obténla en https://etherscan.io/apidashboard
  },
  polygonscan: {
    apyKey:process.env.POLYGONSCAN_API_KEY,
  }

  
};  
