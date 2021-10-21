// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

interface IStarknetCore {
    /// @dev Sends a message to an L2 contract.
    function sendMessageToL2(
        uint256 toAddress_,
        uint256 selector_,
        uint256[] calldata payload_
    ) external;

    /// @dev Consumes a message that was sent from an L2 contract.
    function consumeMessageFromL2(uint256 fromAddress_, uint256[] calldata payload_) external;
}