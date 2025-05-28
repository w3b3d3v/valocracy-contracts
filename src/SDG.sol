// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC7787} from "./interfaces/IERC7787.sol";
import "./math/SafeCast.sol";

/// @title Soulbound Degradable Governance (SDG)
/// @author nomadbitcoin
/// @notice This contract implements the EIP-7787 standard proposed by Guilherme Neves (@0xneves) and Rafael Castaneda
/// for governance systems where voting power is non-transferable and decays over time.
/// The system ensures that governance power reflects recent and active participation in the ecosystem by implementing a two-phase decay mechanism:
/// 1. Stable Period: Voting power remains constant for a fixed duration after each contribution
/// 2. Decay Period: After the stable period ends, voting power linearly decays until it reaches zero
///
/// System Rules:
/// - Voting power remains stable for the duration of the stable period after each contribution
/// - After the stable period ends, voting power linearly decays over the decay period
/// - If no new contributions are made during the decay period, voting power reaches zero
/// - New contributions reset both the stable and decay periods
/// - Lost voting power cannot be recovered without new contributions
///
/// @dev This implementation follows the EIP-7787 specification but uses 'stablePeriod' instead of 'gracePeriod' for clarity.
/// The contract provides the core functionality for calculating voting power with time-based degradation.
///
/// Requirements:
/// - The contract requires stable period and decay period to be configured
/// - The contract implements linear decay as specified in EIP-7787
///
abstract contract SDG is IERC7787 {
    /// @dev Number of seconds in a day
    uint32 private constant SECONDS_PER_DAY = 86400;

    /// @dev Mapping from accounts addresses to their last participation timestamp
    mapping(address => uint32) private _lastParticipation;

    /// @dev Configuration of the stable and decay periods (in days)
    uint32 private _stablePeriod;
    uint32 private _decayPeriod;

    /// @dev Returns the duration of the stable period in days.
    /// @return The duration of the stable period in days.
    function stablePeriod() public view virtual returns (uint256) {
        return _stablePeriod;
    }

    /// @dev Returns the duration of the decay period in days.
    /// @return The duration of the decay period in days.
    function decayPeriod() public view virtual returns (uint256) {
        return _decayPeriod;
    }

    /// @dev Returns the raw last participation timestamp of an account without any decay adjustments.
    /// @param account The address to check for last participation
    /// @return The timestamp of the last participation
    function accountStats(address account) public view virtual returns (uint32) {
        return _lastParticipation[account];
    }

    /// @dev Updates the last participation timestamp for an account.
    /// @param account The address to update the participation timestamp for
    function _updateLastParticipation(address account) internal virtual {
        _lastParticipation[account] = SafeCast.toUint32(block.timestamp);
    }

    /// @dev Sets a new stable period in days
    /// @param stablePeriod_ The new stable period duration in days
    function _setStablePeriod(uint32 stablePeriod_) internal virtual {
        _stablePeriod = stablePeriod_;
    }

    /// @dev Sets a new decay period in days
    /// @param decayPeriod_ The new decay period duration in days
    function _setDecayPeriod(uint32 decayPeriod_) internal virtual {
        _decayPeriod = decayPeriod_;
    }

    /// @dev Returns the balance of the account with decay applied.
    /// @param account The address to check the balance for
    /// @return The current balance with decay applied
    function balanceOf(address account) public view virtual returns (uint256);
}
