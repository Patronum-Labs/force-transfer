// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {ForceTransfer} from "../contracts/ForceTransfer.sol";

contract ForceTransferTest is Test {
    ForceTransfer public forceTransfer;
    address payable public recipient;
    uint256 public constant INITIAL_BALANCE = 100 ether;
    uint256 public constant TRANSFER_AMOUNT = 1 ether;

    function setUp() public {
        forceTransfer = new ForceTransfer();
        recipient = payable(address(0x1234));
        vm.deal(address(this), INITIAL_BALANCE);
    }

    function testForceTransferToEOA() public {
        uint256 initialBalance = recipient.balance;
        forceTransfer.force{value: TRANSFER_AMOUNT}(recipient);
        assertEq(
            recipient.balance,
            initialBalance + TRANSFER_AMOUNT,
            "Transfer to EOA failed"
        );
    }

    function testForceTransferToContractWithoutReceive() public {
        ContractWithoutReceive targetContract = new ContractWithoutReceive();
        uint256 initialBalance = address(targetContract).balance;
        forceTransfer.force{value: TRANSFER_AMOUNT}(
            payable(address(targetContract))
        );
        assertEq(
            address(targetContract).balance,
            initialBalance + TRANSFER_AMOUNT,
            "Transfer to contract without receive failed"
        );
    }

    function testForceTransferZeroAmount() public {
        uint256 initialBalance = recipient.balance;
        forceTransfer.force{value: 0}(recipient);
        assertEq(
            recipient.balance,
            initialBalance,
            "Zero amount transfer should not change balance"
        );
    }

    function testForceTransferMultipleTimes() public {
        uint256 initialBalance = recipient.balance;
        for (uint i = 0; i < 5; i++) {
            forceTransfer.force{value: TRANSFER_AMOUNT}(recipient);
        }
        assertEq(
            recipient.balance,
            initialBalance + (5 * TRANSFER_AMOUNT),
            "Multiple transfers failed"
        );
    }

    function testForceTransferEntireBalance() public {
        uint256 initialBalance = address(this).balance;
        forceTransfer.force{value: initialBalance}(recipient);
        assertEq(
            recipient.balance,
            initialBalance,
            "Transfer of entire balance failed"
        );
        assertEq(address(this).balance, 0, "Sender balance should be zero");
    }

    function testForceTransferWithInsufficientBalance() public {
        uint256 excessAmount = address(this).balance + 1 ether;
        vm.expectRevert();
        forceTransfer.force{value: excessAmount}(recipient);
    }

    function testForceTransferGasUsage() public {
        uint256 gasStart = gasleft();
        forceTransfer.force{value: TRANSFER_AMOUNT}(recipient);
        uint256 gasUsed = gasStart - gasleft();
        assertTrue(gasUsed < 100000, "Gas usage is higher than expected");
    }

    receive() external payable {}
}

contract ContractWithoutReceive {
    // This contract intentionally has no receive or fallback function
}
