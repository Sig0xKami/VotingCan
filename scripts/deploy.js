// const { ethers } = require("hardhat");

// async function main() {
//   const [deployer] = await ethers.getSigners();

//   console.log("Desplegando el contrato con la cuenta:", deployer.address);

//   const PugaCoinGob = await ethers.getContractFactory("PugaCoinGob");

//   // const initalOwner = "0x1d38B83c23Be0a1A0beC8b92c0b13f9D3E9EbAeB";
//   // const initialSupply = ethers.parseUnits("1000000", 18); // 1 millón de tokens
//   // Pasamos la dirección del deployer como owner inicial
//   const contrato = await PugaCoinGob.deploy(); // No se pasan argumentos porque el constructor no los requiere
//   await contrato.deployed();

//   console.log("Contrato desplegado en:", contrato.target);
// }

// main().catch((error) => {
//   console.error("Error al desplegar el contrato:", error);
//   process.exit(1);
// });


// scripts/deploy.js
const { ethers } = require("hardhat");

async function main() {
  // Obtenemos las cuentas disponibles. La primera será la cuenta que despliega el contrato.
  const [deployer] = await ethers.getSigners();

  console.log("------------------------------------------");
  console.log("🚀 Iniciando despliegue de contrato...");
  console.log(`👤 Desplegando desde la cuenta: ${deployer.address}`);
  console.log(`💰 Balance de la cuenta: ${ethers.formatEther(await ethers.provider.getBalance(deployer.address))} ETH`);
  console.log("------------------------------------------\n");

  // Obtenemos la "fábrica" de contratos para 'VotingCandidatso'.
  // El nombre debe coincidir exactamente con el nombre de tu contrato Solidity.
  const VotingCandidatsoFactory = await ethers.getContractFactory("VotingCandidatso");

  // Desplegamos el contrato. Como el constructor no recibe argumentos,
  // simplemente llamamos a deploy() sin parámetros.
  console.log("✨ Desplegando el contrato VotingCandidatso...");
  const votingCandidatso = await VotingCandidatsoFactory.deploy();

  // Esperamos a que la transacción de despliegue se confirme en la blockchain.
  await votingCandidatso.waitForDeployment();

  // Obtenemos la dirección final del contrato desplegado.
  const contractAddress = await votingCandidatso.getAddress();

  console.log("\n------------------------------------------");
  console.log(`✅ ¡Contrato VotingCandidatso desplegado exitosamente!`);
  console.log(`📍 Dirección del contrato: ${contractAddress}`);
  console.log("------------------------------------------");
}

// Manejo de errores para que Hardhat sepa si el script falla.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("❌ Error al desplegar el contrato:", error);
    process.exit(1);
  });