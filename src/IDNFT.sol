// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IIDNFT} from "./interfaces/IIDNFT.sol";
import "./math/ERC7725.sol";
import "./math/SafeCast.sol";

/// @title Isonomic Degradable NFT
/// @author 0xneves
/// @notice This contract implements a governance system where voting power varies based on active contribution.
/// A user's voting power is represented by their token balance and its validity is tracked by the `lastParticipation` timestamp.
/// The voting power remains stable for a period after each contribution, then gradually decays if no new contributions are made.
/// This system ensures that governance power reflects recent and active participation in the ecosystem.
///
/// System Rules:
/// - Voting power remains stable for the duration of the stable period after each contribution
/// - After the stable period ends, voting power linearly decays over the decay period
/// - If no new contributions are made during the decay period, voting power reaches zero
/// - New contributions reset both the stable and decay periods
/// - Lost voting power cannot be recovered without new contributions
///
/// @dev Implementers of IDNFT should configure the desired mechanics or override with their own. The standard version provides
/// the voting power calculation that can be used for decision making in the ecosystem, with time-based degradation to ensure
/// active participation.
///
/// Requirements:
/// - The contract requires stable period and decay period to function but their values can be overridden
/// - The contract relies on ERC-7725 for exponential curve decay, but another logic can override the behaviour
///
abstract contract IDNFT is IIDNFT {
    /// @dev Number of seconds in a day
    uint32 private constant SECONDS_PER_DAY = 86400;

    /// Mapping from accounts addresses to their last participation timestamp
    mapping(address => uint32) private _lastParticipation;

    /// Configuration of the active and inactive time of users (in days)
    uint32 private _stablePeriod;
    uint32 private _decayPeriod;

    /// @dev Amount of time while the voting power is stable and won't decay.
    /// @return The duration of the stable period in days.
    function stablePeriod() public view virtual returns (uint256) {
        return _stablePeriod;
    }

    /// @dev Amount of time it takes for voting power to decay from full to zero.
    /// @return The duration of the decay period in days.
    function decayPeriod() public view virtual returns (uint256) {
        return _decayPeriod;
    }

    /// @dev Returns the raw last participation timestamp of an account without any decay adjustments.
    function accountStats(address account) public view virtual returns (uint32) {
        return _lastParticipation[account];
    }

    /// @dev Updates the last participation timestamp for an account.
    function _updateLastParticipation(address account) internal virtual {
        _lastParticipation[account] = SafeCast.toUint32(block.timestamp);
    }

    /// @dev Set a new stable period in days
    function _setStablePeriod(uint32 stablePeriod_) internal virtual {
        _stablePeriod = stablePeriod_;
    }

    /// @dev Set a new decay period in days
    function _setDecayPeriod(uint32 decayPeriod_) internal virtual {
        _decayPeriod = decayPeriod_;
    }

    /// @dev Returns the balance of the account. This function must be implemented by the inheriting contract.
    function balanceOf(address account) public view virtual returns (uint256);
}
