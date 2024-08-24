const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");



module.exports = buildModule("CrowdFundingModule", (m) => {
  
  const fund = m.contract("CrowdFunding", [], {
  });

  return { fund };
});