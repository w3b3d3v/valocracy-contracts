// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.20;

interface IERC7787 {
  /**
   * @dev Returns the grace period duration before the voting units begins decaying. This period is
   * fixed to 90 days. But it can be overridden in derived contracts.
   * @return The duration of the grace period in seconds.
   */
  function stablePeriod() external view returns (uint256);

  /**
   * @dev Returns the duration of the decay period during which the voting units decreases. This
   * period is fixed to 90 days. But it can be overridden in derived contracts.
   * @return The duration of the decay period in seconds.
   */
  function decayPeriod() external view returns (uint256);

//   /**
//    * @dev Should be implemented by derived contracts to return the current voting units of an account.
//    * This function calculates the voting units based on the last time it was updated and decays it
//    * over time.
//    * @param account The address to check for voting units.
//    * @return The current voting units of the account.
//    */
//   function getVotes(address account) external view returns (uint256);

    /**
     * @dev Returns the raw last participation timestamp of an account without any decay adjustments.
     */
   function accountStats(address account) external view returns (uint32);

  /**
   * @dev Error thrown when attempting to transfer a soulbound token
   */
  error TokenSoulbound();
}