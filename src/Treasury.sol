// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IERC20Metadata} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import {ITreasury} from "./interfaces/ITreasury.sol";

contract Treasury is ERC20, ITreasury {


    /**
     * @dev The underlying token used for the Vault.
     */
    IERC20 private immutable _asset;

    /**
     * @dev The Valocracy contract.
     */
    address private _valocracy;

    /**
     * @dev Initializes the contract by setting a `name` and a `symbol`
     * for the fungible token. Also sets the Valocracy contract and the
     * underlying asset token.
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
     * @dev See {IERC4626-asset}.
     */
    function asset() public view virtual returns (address) {
        return address(_asset);
    }

    /**
     * @dev See {IERC4626-totalAssets}.
     */
    function totalAssets() public view virtual returns (uint256) {
        return _asset.balanceOf(address(this));
    }

    /**
     * @dev See {IERC4626-previewWithdraw}.
     * @dev Calculates the amount of assets that would be returned for burning the given amount of shares.
     * The calculation is based on the proportion of total assets to total shares.
     * For example, if there are 2000 assets and 1000 shares, each share represents 2 assets.
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
     * @dev See {IERC4626-deposit}.
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
     * @dev See {IERC4626-withdraw}.
     */
    function withdraw(address receiver, uint256 shares) public {
        _burn(msg.sender, shares);

        uint256 assets = previewWithdraw(shares);
        IERC20(_asset).transfer(receiver, assets);

        emit Withdraw(msg.sender, receiver, assets, shares);
    }
}
