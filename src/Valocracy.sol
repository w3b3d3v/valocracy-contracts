// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC20Votes} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {EIP712} from "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import {SDG} from "./SDG.sol";

/// @dev Error thrown when attempting to transfer a soulbound token
error TokenSoulbound();

/// @title Valocracy
/// @notice Implementation of the EIP-7787 Soulbound Degradable Governance standard using ERC20 tokens
/// @dev This contract extends ERC20Votes to implement non-transferable tokens with decaying voting power
contract Valocracy is ERC20Votes, Ownable, SDG {
    /// @dev Number of seconds in a day
    uint32 private constant SECONDS_PER_DAY = 86400;

    /// @dev Mapping from accounts addresses to their last participation timestamp
    mapping(address => uint32) private _lastParticipation;

    /**
     * @dev Initializes the contract by setting a `name` and a `symbol`.
     * Sets default stable and decay periods to 90 days each.
     * @param name The name of the token
     * @param symbol The symbol of the token
     */
    constructor(string memory name, string memory symbol) 
        ERC20(name, symbol)
        ERC20Votes()
        Ownable(msg.sender)
        EIP712(name, "1")
    {
        // Set default periods
        _setStablePeriod(90 days);
        _setDecayPeriod(90 days);
    }

    /**
     * @dev Returns the token URI for a given token ID.
     * @param tokenId The ID of the token
     * @return The token URI
     */
    function tokenURI(uint256 tokenId) public view returns (string memory) {
        return "a";
    }

    /**
     * @dev Overrides the {ERC20Votes-_update} to make the token soulbound.
     * Only allows minting and burning, prevents transfers between accounts.
     * @param from The address sending the tokens
     * @param to The address receiving the tokens
     * @param value The amount of tokens
     */
    function _update(address from, address to, uint256 value) internal virtual override {
        // Allow minting (from == address(0)) and burning (to == address(0))
        if (from != address(0) && to != address(0)) {
            revert TokenSoulbound();
        }

        super._update(from, to, value);
    }

    /**
     * @dev Returns the balance of `account` with decay applied.
     * Implements the EIP-7787 decay mechanism:
     * - Full balance during stable period
     * - Linear decay during decay period
     * - Zero balance after decay period ends
     * @param account The address to check the balance for
     * @return The current balance with decay applied
     */
    function balanceOf(address account) public view override(ERC20, SDG) returns (uint256) {
        uint256 lastParticipation = _lastParticipation[account];
        uint256 balance = super.balanceOf(account);

        // If no voting power was granted or still in stable period, return full balance
        if (lastParticipation == 0 || block.timestamp < lastParticipation + stablePeriod()) {
            return balance;
        }

        // Calculate time passed since stable period ended
        uint256 timeSinceStablePeriod = block.timestamp - (lastParticipation + stablePeriod());

        // If decay period is over, return 0
        if (timeSinceStablePeriod >= decayPeriod()) {
            return 0;
        }

        // Linear decay: Calculate remaining balance during decay period
        uint256 decayPercentage = (timeSinceStablePeriod * 1e18) / decayPeriod(); // Percentage in 18 decimals
        
        uint256 remainingBalance = (balance * (1e18 - decayPercentage)) / 1e18;

        return remainingBalance;
    }

    /**
     * @dev Returns the voting units for an account.
     * @param account The address to check voting units for
     * @return The current voting units
     */
    function _getVotingUnits(address account) internal view override returns (uint256) {
        return balanceOf(account);
    }

    /**
     * @dev Grants voting units to the specified account by `amount`.
     * Only the contract owner can mint new tokens and grant additional voting units.
     * Updates the last participation timestamp to start the stable period.
     * @param to The address to grant voting units to
     * @param amount The amount of voting units to grant
     */
    function grantVotingUnits(address to, uint256 amount) public onlyOwner {
        _lastParticipation[to] = uint32(block.timestamp);
        _mint(to, amount);
    }

    /**
     * @notice Burns tokens and reduces the voting units associated with the token holder.
     * @param amount The amount of tokens to burn
     */
    function burn(uint256 amount) public virtual {
        address from = _msgSender();
        require(balanceOf(from) >= amount, "Insufficient voting power");
        _burn(from, amount);
    }
}
