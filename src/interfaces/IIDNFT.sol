// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IIDNFT {
    /**
     * @dev Returns the stable period. Stable period is measured in days.
     *
     * The stable period is the time that an account's level remains constant
     * after receiving new voting power. After this period, the level will start
     * to decay linearly until it reaches zero.
     *
     * IMPORTANT: After the decay period ends, the lost level cannot be
     * recovered. The account will have to receive new voting power to start over.
     * Hence, the importance of not letting the level decay completely.
     *
     * WARNING: Changing the stable period affects the lastParticipation of all accounts.
     * Make sure to correctly calculate the desired stable period in DAYS.
     */
    function stablePeriod() external view returns (uint256);

    /**
     * @dev Returns the decay period. Decay period is measured in days.
     *
     * The decay period is the time it takes for an account's level to linearly
     * decrease from its full value to zero. This period starts after the stable
     * period ends.
     *
     * WARNING: Changing the decay period affects the lastParticipation of all accounts.
     * Make sure to correctly calculate the desired decay period in DAYS.
     */
    function decayPeriod() external view returns (uint256);

    // /**
    //  * @dev Returns the level of governance power of a given account.
    //  * The level is calculated considering the stable and decay periods.
    //  * If the account is in the stable period, it returns the full level.
    //  * If the account is in the decay period, it returns the level adjusted
    //  * by the linear decay.
    //  * If the decay period has ended, it returns zero.
    //  */
    // function levelOf(address account) external view returns (uint256);

    /**
     * @dev Returns the raw last participation timestamp of an account without any decay adjustments.
     */
    function accountStats(address account) external view returns (uint32);

    // /**
    //  * @dev Returns the valor ID linked to the given token ID.
    //  */
    // function valorIdOf(uint256 tokenId) external view returns (uint256);

    // /**
    //  * @dev Returns the rarity of the given valor ID.
    //  */
    // function rarityOf(uint256 valorId) external view returns (uint256);

    // /**
    //  * @dev Returns the metadata of the given valor ID.
    //  */
    // function metadataOf(uint256 valorId) external view returns (string memory);

    // /**
    //  * @dev Expiration of the account. The governance power decays after the
    //  * vacancy period has passed. See {IValocracy-vacancyPeriod}.
    //  */
    // function expiryOf(address account) external view returns (uint256);
}
