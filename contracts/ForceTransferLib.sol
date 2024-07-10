// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SelfDestructContract} from "./SelfDestructContract.sol";

/// @title ForceTransferLib
/// @author @YamenMerhi @PatronumLabs
/// @notice A library that provides a method to forcefully send value to any address
/// @dev Utilizes a self-destructing contract to bypass recipient limitations
/// @custom:security EIP-6049 deprecated selfdestruct as it may be subject to breaking changes in the future, use on your own risk
library ForceTransferLib {
    /// @notice Forces value transfer to a specified recipient
    /// @dev Creates a new SelfDestructContract with the specified amount and recipient
    /// @param recipient The address to receive the value
    /// @param amount The amount of wei to send
    /// @custom:security This function will always succeed, given enough gas, even if the recipient
    /// is a contract without a receive function
    function force(address payable recipient, uint256 amount) internal {
        new SelfDestructContract{value: amount}(recipient);
    }
}
