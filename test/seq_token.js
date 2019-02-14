const SEQToken = artifacts.require("./SEQToken.sol");

contract("SEQ Token test", accounts => {
    it("SEQ Token Contract is okay", async () => {
        let instance = await SEQToken.deployed();

        let r0 = await instance.totalSupply.call();
        assert.equal(r0, 1337, "initial total supply should be 1337!");
    });
});