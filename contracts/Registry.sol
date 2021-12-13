// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22;

import "./strings.sol";

import {Storage} from "./Storage.sol";

/**
  DID Registry
 */
contract Registry {
    using strings for *;
    event RegisterEvent(string id, address docContract);
    event RecieveEth(address addr, uint256 amount);
    event DocContractCreation(
        address from,
        address contractAddr,
        bytes32 fileHash
    );
    // event DebugLog(string id, bytes32 hash);
    modifier hasCorrectPrefix(string memory _str) {
        require(
            _str.toSlice().startsWith("did:".toSlice()),
            "DID must begin with did"
        );
        _;
    }

    modifier hasThreeParts(string memory _id) {
        require(true, "Did must consist of three parts");
        _;
    }

    /*
      mapping issuer to it's document of ipfs address 
      address like 'did:dns:123' actual depends on did:dns which means the method identification is ignored.
      so,the function using this proprty needs to check the validation of input value
    */
    mapping(string => address) public issuer2addr;

    modifier hasNotRegister(string memory id) {
        require(issuer2addr[id] == address(0), "id already register");
        _;
    }
    /**
        返回 ID 对应的 控制 document 的智能合约地址
    */
    function resolveDocuemnt(string memory id)
        public
        view
        hasCorrectPrefix(id)
        returns (address)
    {
        return issuer2addr[id];
    }

    function register(string memory id, bytes32 ipfsHash)
        public
        hasNotRegister(id)
        hasCorrectPrefix(id)
    {
        address doc = createDoc(ipfsHash);
        issuer2addr[id] = doc;
        emit RegisterEvent(id, doc);
        return;
    }

    function createDoc(bytes32 fileHash) private returns (address) {
        Storage doc = new Storage(fileHash);
        address docAddr = address(doc);
        emit DocContractCreation(msg.sender, docAddr, fileHash);
        return docAddr;
    }

    receive() external payable {
        emit RecieveEth(msg.sender, msg.value);
    }

    fallback() external payable {
        emit RecieveEth(msg.sender, msg.value);
    }
}

// contract Storage {
//     bytes32 public fileHash;

//     constructor(bytes32 _fileHash) public {
//         fileHash = _fileHash;
//     }
// }
