pragma solidity ^0.5;

contract Test {
    uint public total;
    function test() public {
        assembly {
            let pos := mload(0x40)
            pos := sub(pos, 0x20)
            sstore(total_slot, 10)
        }

    }
    function split(uint start, uint len, bytes memory data) public returns(uint){
        require(start+len <= data.length, "Out of range");
        uint rs;
        bytes memory rsBytes;
        assembly {
            let size32 := div(len,32)
            let mod32 := mod(len,32)
            if gt(mod32,0) {
                size32 := add(size32,1)
            }
            rs := size32
            mstore(rsBytes, size32)
        }
        return rs;
    }

    function store() public view returns (bytes memory) {
        bytes memory m;
        assembly {
            m:=mload(0x40)

            // mstore(add(offset,32), 0x1)
            // // mstore(add(m,64), 0xbb)
            // mstore(offset,1)
            mstore(m,2)
            mstore(add(m,32), 0xaa)
        }
        return m;
    }

    function getSlot(bytes memory x, bytes memory y) public view returns (uint, bytes  memory, bytes memory) {
        bytes memory m;// = hex"aa";
        uint slot;
        bytes32 y1;
        assembly {
            slot := mload(0x40)
            m := mload(0x40)
            // mstore(add(slot,32), shl(248,0xdd))
            mstore(add(slot,32), byte(30,0xdd))
            mstore(slot,add(1,0))
            mstore(0x40, add(slot,64))
        }
        return (slot, m, y);
    }

    function slice(uint start, uint len, bytes memory data) public view returns(bytes memory) {
        require(start+len <= data.length, "Out of range");
        bytes memory rsBytes;

        assembly {
            rsBytes := mload(0x40)
            let size32 := div(len,32)
            let mod32 := mod(len,32)
            if gt(mod32,0) {
                size32 := add(size32,1)
            }
            let readPointer := add(add(data,32), start)
            let writePointer := add(rsBytes, 32)

            for { let i := 0 } or(lt(i, size32),eq(i, size32)) { i := add(i, 1) } {
                let writeData := mload(readPointer)
                mstore(writePointer, writeData)
                readPointer := add(readPointer, 32)
                writePointer := add(writePointer, 32)
            }
            mstore(rsBytes, len)
            mstore(0x40, add(rsBytes,add(writePointer, 32)))
        }
        return (rsBytes);
    }

    function getStringLength(string memory s) public pure returns(uint) {
        uint len;
        assembly {
            len := mload(s)
        }
        return len;
    }

    function substring(uint start, uint len, string memory s) public view returns(string memory) {
        uint l = getStringLength(s);
        require(start+len <= l, "Out of range");
        bytes memory input = bytes(s);
        bytes memory temp = slice(start,len,input);
        return string(temp);
    }

    function toAddress(uint start, bytes memory s) public view returns (address) {
        address addr;
        assembly {
            addr := mload(add(add(s,32),start))
            addr := div(addr, 0x1000000000000000000000000)
        }
        return addr;
    }
    
}