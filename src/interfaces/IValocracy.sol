// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IValocracy {
    /**
     * @dev Emitted when attempting to transfer a soulbound token.
     */
    error TokenSoulbound();

    /**
     * @dev Emitted when voting units are granted to an account.
     * @param account The address that received the voting units
     * @param amount The amount of voting units granted
     */
    event VotingUnitsGranted(address indexed account, uint256 amount);

    /**
     * @dev Emitted when voting units are burned.
     * @param account The address that burned the voting units
     * @param amount The amount of voting units burned
     */
    event VotingUnitsBurned(address indexed account, uint256 amount);

    /**
     * @dev Returns the balance of an account with decay applied.
     * Implements the EIP-7787 decay mechanism:
     * - Full balance during stable period
     * - Linear decay during decay period
     * - Zero balance after decay period ends
     * @param account The address to check the balance for
     * @return The current balance with decay applied
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Returns the stable period duration in seconds.
     * @return The stable period duration
     */
    function stablePeriod() external view returns (uint256);

    /**
     * @dev Returns the decay period duration in seconds.
     * @return The decay period duration
     */
    function decayPeriod() external view returns (uint256);

    /**
     * @dev Grants voting units to the specified account.
     * Only the contract owner can mint new tokens and grant additional voting units.
     * Updates the last participation timestamp to start the stable period.
     * @param to The address to grant voting units to
     * @param amount The amount of voting units to grant
     */
    function grantVotingUnits(address to, uint256 amount) external;

    /**
     * @dev Burns tokens and reduces the voting units associated with the token holder.
     * @param amount The amount of tokens to burn
     */
    function burn(uint256 amount) external;
}
