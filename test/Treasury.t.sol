// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console2} from "forge-std/Test.sol";
import {Treasury} from "../src/Treasury.sol";
import {ITreasury} from "../src/interfaces/ITreasury.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title MockToken
 * @dev A mock ERC20 token used for testing the Treasury contract
 * This token simulates any ERC20 asset that could be managed by the Treasury
 * In a real scenario, this could be any ERC20 token like USDC, DAI, etc.
 */
contract MockToken is ERC20 {
    constructor() ERC20("Mock Token", "MTK") {
        _mint(msg.sender, 1000000 * 10**18);
    }
}

/**
 * @title TreasuryTest
 * @dev Test suite for the Treasury contract
 * This test suite verifies the functionality of the Treasury contract which:
 * - Manages ERC20 assets (represented by MockToken in tests)
 * - Mints and burns shares based on asset deposits and withdrawals
 * - Tracks total assets and share balances
 * - Handles deposits and withdrawals with proper authorization
 */
contract TreasuryTest is Test {
    Treasury public treasury;
    MockToken public asset;
    address public valocracy;
    address public user1;
    address public user2;
    address public deployer;

    event Deposit(address indexed receiver, uint256 shares);
    event Withdraw(address indexed sender, address indexed receiver, uint256 assets, uint256 shares);

    /**
     * @dev Sets up the test environment
     * Creates a new MockToken instance and Treasury contract
     * Initializes test addresses for different roles
     */
    function setUp() public {
        deployer = makeAddr("deployer");
        valocracy = makeAddr("valocracy");
        user1 = makeAddr("user1");
        user2 = makeAddr("user2");

        vm.startPrank(deployer);
        asset = new MockToken();
        treasury = new Treasury(
            asset,
            valocracy,
            "Valocracy Treasury",
            "vTREASURY"
        );
        vm.stopPrank();
    }

    /**
     * @dev Tests the proper initialization of the Treasury contract
     * Verifies name, symbol, and asset address are set correctly
     */
    function test_ContractInitialization() public view {
        assertEq(treasury.name(), "Valocracy Treasury");
        assertEq(treasury.symbol(), "vTREASURY");
        assertEq(treasury.asset(), address(asset));
    }

    /**
     * @dev Tests the asset tracking functionality
     * Verifies that the Treasury correctly tracks total assets after deposits
     * Uses MockToken as the underlying asset
     */
    function test_AssetTracking() public {
        assertEq(treasury.totalAssets(), 0);
        
        // Transfer assets to valocracy first
        vm.prank(deployer);
        asset.transfer(valocracy, 1000 * 10**18);
        
        // Now valocracy deposits assets and creates shares
        vm.startPrank(valocracy);
        asset.approve(address(treasury), 1000 * 10**18);
        treasury.deposit(user1, 1000 * 10**18);
        vm.stopPrank();
        
        assertEq(treasury.totalAssets(), 1000 * 10**18);
    }

    /**
     * @dev Tests share minting functionality
     * Verifies that shares are minted correctly when assets are deposited
     * Uses MockToken as the underlying asset for deposits
     */
    function test_ShareMinting() public {
        // Transfer assets to valocracy first
        vm.prank(deployer);
        asset.transfer(valocracy, 1000 * 10**18);
        
        vm.startPrank(valocracy);
        // Approve treasury to spend assets
        asset.approve(address(treasury), 1000 * 10**18);
        // Mint shares to user1
        treasury.deposit(user1, 1000 * 10**18);
        
        assertEq(treasury.balanceOf(user1), 1000 * 10**18);
        assertEq(treasury.totalAssets(), 1000 * 10**18);
        vm.stopPrank();
    }

    /**
     * @dev Tests authorization requirements for share minting
     * Verifies that only authorized addresses (valocracy) can mint shares
     */
    function test_ShareMinting_NotAuthorized() public {
        vm.prank(user1);
        vm.expectRevert(abi.encodeWithSelector(ITreasury.NotAuthorized.selector, user1));
        treasury.deposit(user2, 1000 * 10**18);
    }

    /**
     * @dev Tests share burning and asset withdrawal
     * Verifies that shares are burned and assets are returned correctly
     * Uses MockToken to track asset transfers
     */
    function test_ShareBurning() public {
        // Transfer assets to valocracy first
        vm.prank(deployer);
        asset.transfer(valocracy, 2000 * 10**18); // Transfer 2000 assets
        
        // First mint some shares
        vm.startPrank(valocracy);
        asset.approve(address(treasury), 2000 * 10**18);
        treasury.deposit(user1, 1000 * 10**18); // Mint 1000 shares for 2000 assets
        vm.stopPrank();
        
        // Record initial balances
        uint256 initialShares = treasury.balanceOf(user1);
        uint256 initialTotalSupply = treasury.totalSupply();
        
        // Now withdraw 500 shares, which should return 1000 assets (2 assets per share)
        vm.prank(user1);
        treasury.withdraw(user1, 500 * 10**18);
        
        // Check share burning
        assertEq(treasury.balanceOf(user1), initialShares - 500 * 10**18, "Shares not burned correctly");
        assertEq(treasury.totalSupply(), initialTotalSupply - 500 * 10**18, "Total supply not reduced");
        
        // Check asset transfer - should receive 1000 assets (2 assets per share)
        assertEq(asset.balanceOf(user1), 1000 * 10**18, "Assets not transferred correctly");
    }

    /**
     * @dev Tests the preview withdrawal functionality
     * Verifies that the contract correctly calculates assets to be returned
     * Uses MockToken as the underlying asset for calculations
     */
    function test_PreviewWithdraw() public {
        // Transfer assets to valocracy first
        vm.prank(deployer);
        asset.transfer(valocracy, 1000 * 10**18);
        
        // First mint some shares
        vm.startPrank(valocracy);
        asset.approve(address(treasury), 1000 * 10**18);
        treasury.deposit(user1, 1000 * 10**18);
        vm.stopPrank();
        
        // Test preview
        uint256 previewAmount = treasury.previewWithdraw(500 * 10**18);
        assertEq(previewAmount, 500 * 10**18);
    }

    /**
     * @dev Tests event emissions for deposits and withdrawals
     * Verifies that proper events are emitted with correct parameters
     * Uses MockToken to track asset transfers and verify balances
     */
    function test_Events() public {
        // Transfer assets to valocracy first
        vm.prank(deployer);
        asset.transfer(valocracy, 2000 * 10**18); // Transfer 2000 assets
        
        // Test Deposit event
        vm.startPrank(valocracy);
        asset.approve(address(treasury), 2000 * 10**18);
        vm.expectEmit(true, false, false, true);
        emit Deposit(user1, 1000 * 10**18);
        treasury.deposit(user1, 1000 * 10**18); // Mint 1000 shares for 2000 assets
        vm.stopPrank();
        
        // Record user1's balance before withdrawal
        uint256 before = asset.balanceOf(user1);
        // Test Withdraw event - 500 shares should return 1000 assets (2 assets per share)
        vm.prank(user1);
        vm.expectEmit(true, true, false, true);
        emit Withdraw(user1, user1, 1000 * 10**18, 500 * 10**18);
        treasury.withdraw(user1, 500 * 10**18);
        // Check that user1 received 1000 tokens (2 assets per share)
        assertEq(asset.balanceOf(user1) - before, 1000 * 10**18);
    }
} 