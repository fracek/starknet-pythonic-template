// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

interface ICounter {
    event CounterUpdated (uint256 new_count);

    function finalizeUpdateCounter(uint256 count_) external;
}