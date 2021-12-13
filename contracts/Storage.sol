// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <=0.9.0;

import "@chainlink/contracts/src/v0.6/ChainlinkClient.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
    提供 document 的增删改查
    增：由其他方式提供，本合约不提供
    删：设置注销状态或者合约自毁
    改：提供更新合约内容、更新合约地址功能
    查：验证凭证、签名

 */
contract Storage is ChainlinkClient, Ownable {
    bytes32 public fileHash;

    constructor(bytes32 _fileHash) public {
        fileHash = _fileHash;
    }
    
}
