// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface ITreasury {
    /**
     * @dev Emitted when a non-authorized account attempts to call a function.
     */
    error NotAuthorized(address caller);

    /**
     * @dev Emitted when a new deposit of the underlying asset is made.
     * @param receiver The address that received the shares
     * @param shares The amount of shares minted
     */
    event Deposit(address indexed receiver, uint256 shares);

    /**
     * @dev Emitted when a withdrawal of the underlying asset is made.
     * @param owner The address that burned the shares
     * @param receiver The address that received the underlying asset
     * @param assets The amount of underlying asset withdrawn
     * @param shares The amount of shares burned
     */
    event Withdraw(
        address indexed owner,
        address indexed receiver,
        uint256 assets,
        uint256 shares
    );

    /**
     * @dev Returns the address of the single underlying asset token used by the treasury
     * for accounting, depositing, and withdrawing.
     * @return The address of the underlying asset token
     */
    function asset() external view returns (address);

    /**
     * @dev Returns the total amount of the single underlying asset that is managed by the treasury.
     * @return The total amount of the underlying asset
     */
    function totalAssets() external view returns (uint256);

    /**
     * @dev Calculates the amount of the underlying asset that would be returned
     * from burning the given amount of shares.
     * @param shares The amount of shares to calculate assets for
     * @return The amount of underlying asset that would be returned
     */
    function previewWithdraw(
        uint256 shares
    ) external view returns (uint256);

    /**
     * @dev Deposits the underlying asset into the treasury and mints shares to the receiver.
     * Only callable by the Valocracy contract.
     * @param receiver The address that will receive the shares
     * @param shares The amount of shares to mint
     */
    function deposit(address receiver, uint256 shares) external;

    /**
     * @dev Withdraws the underlying asset from the treasury by burning shares.
     * Transfers the corresponding amount of the underlying asset to the receiver.
     * @param receiver The address that will receive the underlying asset
     * @param shares The amount of shares to burn
     */
    function withdraw(address receiver, uint256 shares) external;
}
