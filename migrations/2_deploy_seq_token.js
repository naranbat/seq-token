var SEQToken = artifacts.require("./SEQToken.sol");

module.exports = function(deployer) {
    deployer.deploy(SEQToken);
};