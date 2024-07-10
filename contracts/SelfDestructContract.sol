// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title SelfDestructContract
/// @author @YamenMerhi @PatronumLabs
/// @notice A contract that self-destructs immediately after creation
/// @dev Forces value transfer to a specified address upon deployment using selfdestruct
/// @custom:security EIP-6049 deprecated selfdestruct as it may be subject to breaking changes in the future, use on your own risk
contract SelfDestructContract {
    /// @notice Creates and immediately self-destructs the contract
    /// @dev All native value sent during deployment is transferred to the recipient
    /// @param recipient The address to receive the value upon self-destruction
    constructor(address payable recipient) payable {
        selfdestruct(recipient);
    }
}
