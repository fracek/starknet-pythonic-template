// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "./interfaces/ICounter.sol";
import "./interfaces/IStarknetCore.sol";


contract Counter is ICounter {
    uint256 constant MESSAGE_UPDATE_COUNTER = 0;
    uint256 public count;
    uint256 private l2Counter;
    address private starknetCore;

    constructor(address starknetCore_, uint256 l2Counter_) {
        starknetCore = starknetCore_;
        l2Counter = l2Counter_;
        count = 0;
    }


    // L1 <> L2

    /// @dev Finalize counter update from L2 to L1.
    /// @param count_ new counter value.
    function finalizeUpdateCounter(
        uint256 count_
    )
        external
        virtual
        override
    {
        uint256[] memory payload = new uint256[](4);
        payload[0] = MESSAGE_UPDATE_COUNTER;
        payload[1] = count_;

        // reverts if message does not exist
        IStarknetCore(starknetCore).consumeMessageFromL2(l2Counter, payload);

        count = count_;
    }
}