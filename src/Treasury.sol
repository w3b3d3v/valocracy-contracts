// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IERC20Metadata} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import {ITreasury} from "./interfaces/ITreasury.sol";

/// @title Treasury
/// @notice Implementation of a single-asset treasury that manages deposits and withdrawals
/// @dev This contract extends ERC20 to implement a treasury system for a single underlying asset
contract Treasury is ERC20, ITreasury {
    /// @dev The single underlying asset token managed by this treasury
    IERC20 private immutable _asset;

    /// @dev The Valocracy contract address that controls deposits
    address private _valocracy;

    /**
     * @dev Initializes the contract by setting a `name` and a `symbol`
     * for the treasury shares. Also sets the Valocracy contract and the
     * single underlying asset token.
     * @param asset_ The single underlying asset token to be managed
     * @param valocracy The address of the Valocracy contract that controls deposits
     * @param name The name of the treasury shares
     * @param symbol The symbol of the treasury shares
     */
    constructor(
        IERC20 asset_,
        address valocracy,
        string memory name,
        string memory symbol
    ) ERC20(name, symbol) {
        _valocracy = valocracy;
        _asset = asset_;
    }

    /**
     * @dev Returns the address of the single underlying asset token.
     * @return The address of the asset token
     */
    function asset() public view virtual returns (address) {
        return address(_asset);
    }

    /**
     * @dev Returns the total amount of the single asset held by the treasury.
     * @return The total balance of the underlying asset
     */
    function totalAssets() public view virtual returns (uint256) {
        return _asset.balanceOf(address(this));
    }

    /**
     * @dev Calculates the amount of the underlying asset that would be returned for burning the given amount of shares.
     * The calculation is based on the proportion of total assets to total shares.
     * For example, if there are 2000 assets and 1000 shares, each share represents 2 assets.
     * @param shares The amount of shares to calculate assets for
     * @return The amount of the underlying asset that would be returned
     */
    function previewWithdraw(
        uint256 shares
    ) public view virtual returns (uint256) {
        uint256 totalAssets_ = totalAssets();
        uint256 totalSupply_ = totalSupply();
        
        // If there are no shares, return 0 to avoid division by zero
        if (totalSupply_ == 0) return 0;
        
        // Calculate assets based on the proportion of total assets to total shares
        return (totalAssets_ * shares) / totalSupply_;
    }

    /**
     * @dev Deposits the underlying asset into the treasury and mints shares to the receiver.
     * Only callable by the Valocracy contract.
     * @param receiver The address that will receive the shares
     * @param shares The amount of shares to mint
     */
    function deposit(address receiver, uint256 shares) public {
        if (msg.sender != _valocracy) {
            revert NotAuthorized(msg.sender);
        }

        // Transfer assets from valocracy to treasury
        _asset.transferFrom(msg.sender, address(this), shares);
        
        // Mint shares to receiver
        _mint(receiver, shares);

        emit Deposit(receiver, shares);
    }

    /**
     * @dev Withdraws the underlying asset from the treasury by burning shares.
     * Transfers the corresponding amount of the underlying asset to the receiver.
     * @param receiver The address that will receive the underlying asset
     * @param shares The amount of shares to burn
     */
    function withdraw(address receiver, uint256 shares) public {
        _burn(msg.sender, shares);

        uint256 assets = previewWithdraw(shares);
        IERC20(_asset).transfer(receiver, assets);

        emit Withdraw(msg.sender, receiver, assets, shares);
    }
}
