// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "../lib/eigenlayer-contracts/src/contracts/interfaces/IAllocationManager.sol";

contract TinyAVS {
    IAllocationManager public immutable allocationManager;

    constructor(address _allocationManager) {
        allocationManager = IAllocationManager(_allocationManager);
    }

    function getAmIAnAVS() public pure returns (string memory) {
        return "yes, I am a tiny AVS";
    }

    function updateMetadataURI(string calldata newMetadataURI) external {
        // Call the AllocationManager to update the metadata URI for this AVS
        allocationManager.updateAVSMetadataURI(address(this), newMetadataURI);
    }
}