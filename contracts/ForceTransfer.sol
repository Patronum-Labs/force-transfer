// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SelfDestructContract} from "./SelfDestructContract.sol";

/// @title ForceTransfer
/// @author @YamenMerhi @PatronumLabs
/// @notice A contract that provides a method to forcefully send value to any address
/// @dev Utilizes a self-destructing contract to bypass recipient limitations
/// @custom:security EIP-6049 deprecated selfdestruct as it may be subject to breaking changes in the future, use on your own risk
contract ForceTransfer {
    /// @notice Emitted when a forced transfer is executed
    /// @param sender The address that initiated the force transfer
    /// @param recipient The address that received the forced transfer
    /// @param amount The amount of value that was transferred
    event ForcedTransfer(
        address indexed sender,
        address indexed recipient,
        uint256 amount
    );

    /// @notice Forces value transfer to a specified recipient
    /// @dev Creates a new SelfDestructContract with the amount being sent and the specified recipient
    /// @param recipient The address to receive the value
    /// @custom:security This function will always succeed, given enough gas, even if the recipient
    /// is a contract without a receive function
    function force(address payable recipient) external payable {
        new SelfDestructContract{value: msg.value}(recipient);
        emit ForcedTransfer(msg.sender, recipient, msg.value);
    }
}
