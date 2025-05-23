// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// import {IIDNFT} from "./interfaces/IIDNFT.sol";
import "./math/ERC7725.sol";
import "./math/SafeCast.sol";

/// @title Isonomic Degradable NFT
/// @author 0xneves
/// @notice This contract provides a gamefied system for tracking account's progress and their respectful energy eficiency.
/// Character progress is known as the account's `Level` and energy as their `Mana`. Addresses health bar is their reputation
/// record, it's immortal and will always live on the blockchain but the Level can fluctuate deppending on the amount of Mana.
/// Level can be used to quantify that user's ability to change the world around them but Mana controls how much efficient
/// that Level is. On a spectrum, full Mana symbolizes 100% of the user Level but 0% Mana resets the user Level to 0.
///
/// Game Rules:
/// - Implementors should decide how their users gain new levels
/// - Mana is measured as unix timestamp and is considered full while: Mana + {stablePeriod} > block.timestamp
/// - Mana is replenished every time the user Level increases.
/// - Stable period and decreasing period resets to default every time the user Level increases.
/// - Decreasing period always start counting after stable period ends.
/// - Level lost by the lack of Mana cannot be replenished.
///
/// @dev Implementers of IDNFT should configure the desired mechanics or override with their own. The standard version deliver
/// the Level value, that can be used for decision making in the ecosystem and Mana for downgrading the Level based on the
/// user activity.
///
/// Requirements:
/// - The contract requires stable period and the decreasing period to function but their values can be override.
/// - The contract relies on ERC-7725 for exponential curve decay, but another logic can override the behaviour.
///
abstract contract IDNFT is ERC7725 {
    /// Character progress
    struct Character {
        uint256 level;
        uint32 mana;
    }

    /// Mapping from accounts addresses to their Level and Mana
    mapping(address => Character) private _accounts;

    /// Curvature of the resulting decay value
    int16 private _curvature;

    /// Configuration of the active and inactive time of users
    uint32 private _stablePeriod;
    uint32 private _decreasePeriod;

    /// @dev The curvature for calculating the Level decay.
    function curvature() public view virtual returns (int16) {
        return _curvature;
    }

    /// @dev Amount of time while the Mana is stable and won't be consumed.
    function stablePeriod() public view virtual returns (uint32) {
        return _stablePeriod;
    }

    /// @dev Amount of time it takes from Mana stability until its full depletion.
    function decreasePeriod() public view virtual returns (uint32) {
        return _decreasePeriod;
    }

    /// @dev Returns the raw `Character` settings of `account` with no adjustments.
    function accountStats(address account) public view virtual returns (Character memory) {
        return _accounts[account];
    }

    /// @dev Returns the Level of a given `account` adjusted for his current Mana.
    function levelOf(address account) public view virtual returns (uint256) {
        Character memory user = _accounts[account];

        uint32 gracePeriod = user.mana + _stablePeriod;
        if (gracePeriod > block.timestamp) return user.level;

        uint32 depletionPeriod = gracePeriod + _decreasePeriod;
        int256 decay = expcurve(
            SafeCast.toUint32(block.timestamp),
            gracePeriod,
            depletionPeriod,
            _curvature,
            false // Needs to be descending for decay
        );
        return (user.level * SafeCast.toUint256(decay)) / 100 / 1e18;
    }

    /// @dev Increases the current Level of `account` by `amount` and replenishes the Mana.
    function _increaseLevel(address account, uint256 amount) internal virtual {
        _accounts[account] = Character(
            levelOf(account) + amount,
            SafeCast.toUint32(block.timestamp)
        );
    }

    /// @dev Set a new curvature
    function _setCurvature(int16 curvature_) internal virtual {
        _curvature = curvature_;
    }

    /// @dev Set a new stable period
    function _setStablePeriod(uint32 stablePeriod_) internal virtual {
        _stablePeriod = stablePeriod_;
    }

    /// @dev Set a new decreasing period
    function _setdecreasePeriod(uint32 decreasePeriod_) internal virtual {
        _decreasePeriod = decreasePeriod_;
    }

    /// @dev Unsafe write access to an account Character.
    /// WARNING: Anyone calling this MUST ensure that the custom implementation matches the expected behaviour of the contract.
    function __unsafe_setLevelAndMana(address account, uint256 amount, uint32 mana) internal {
        _accounts[account] = Character(amount, mana);
    }
}
