
const Test = artifacts.require("Test");
contract("Test", accounts => {
    var testContract
    before(() => {
        return Test.deployed().then((instance) => {
            testContract = instance;
        })
    })
    
    it("String length", async () => {
        var zero = "0".repeat(32)
        var addr = "911A6A7CEA63367Eb7F7647F5a0e3054345Cb09a";
        var data = "0x"+zero+addr;
        var start = 16;
        var sub = await testContract.toAddress.call(start, data);
        
        console.log(sub);

        assert.equal('0x'+addr, sub, "Wrong")

    })
    
});