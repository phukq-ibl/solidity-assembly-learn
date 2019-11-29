
const Test = artifacts.require("Test");
contract("Test", accounts => {
    var testContract
    before(() => {
        return Test.deployed().then((instance) => {
            testContract = instance;
        })
    })
    // it("Should mstore sucess", async () => {
    //     var total = await testContract.total.call();
    //     assert.equal(total.toString(10), '0', 'Total must be 0');
    //     var changeTx = await testContract.test();
    //     var total = await testContract.total.call();
    //     assert.equal(total.toString(10), '1', 'Total must be 1');

    // });

    // it("Should sub ok", async () => {
    //     var rs = await testContract.split.call(0,64,"0xada4e11f47975aafd9a6bf8eba29f0fbb6c66c8e223428fb157dfeb5a3ea0154ada4e11f47975aafd9a6bf8eba29f0fbb6c66c8e223428fb157dfeb5a3ea0154");
    //     // console.log(rs.toString(10));
    // });
    // it("Should sub ok2", async () => {
    //     // var rs = await testContract.store.call();
    //     // console.log(rs);
    //     // var slot = await testContract.getSlot.call('0x0000000000000000000000000000000000000000000000000000000000000aa', '0x0000000000000000000000000000000000000000000000000000000000000bb');
    //     var slot = await testContract.getSlot.call('0x0000000000000000000000000000000000000000000000000000000000000aa', '0xbb');
    //     console.log("Slot ", slot['0'].toString(10), slot);
    // });
    function slice(start, len, data) {
        if(!data.startsWith('0x')) {
            throw "Data must be started with 0x"
        }
        var expected = data.substr(2+start*2, len * 2);
        return '0x'+expected;
    }
    it("String length", async () => {
        var data = "IBL.ở.Việt.Nam";
        var start = 0;
        var len = 7;
        var sub = await testContract.substring.call(start, len, data);
        
        console.log(sub);

    })
    
});