// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {Valocracy} from "../src/Valocracy.sol";

contract ValocracyTest is Test {
    Valocracy public valocracy;
    address public owner;
    address public alice;
    address public bob;

    event Transfer(address indexed from, address indexed to, uint256 value);

    function setUp() public {
        owner = makeAddr("owner");
        alice = makeAddr("alice");
        bob = makeAddr("bob");

        vm.startPrank(owner);
        valocracy = new Valocracy("Valocracy Governance", "gVAL");
        vm.stopPrank();
    }

    function test_Initialization() public {
        // Test basic ERC20 properties
        assertEq(valocracy.name(), "Valocracy Governance");
        assertEq(valocracy.symbol(), "gVAL");
        assertEq(valocracy.decimals(), 18); // ERC20 standard decimals
        assertEq(valocracy.totalSupply(), 0); // Initial supply should be 0

        // Test ownership
        assertEq(valocracy.owner(), owner);

        // Test governance periods
        assertEq(valocracy.stablePeriod(), 90 days);
        assertEq(valocracy.decayPeriod(), 90 days);

        // Test initial balances
        assertEq(valocracy.balanceOf(owner), 0);
        assertEq(valocracy.balanceOf(alice), 0);
        assertEq(valocracy.balanceOf(bob), 0);
    }

    function test_SoulboundToken() public {
        // Grant voting units to alice
        vm.prank(owner);
        valocracy.grantVotingUnits(alice, 100);

        // Try to transfer tokens from alice to bob
        vm.prank(alice);
        vm.expectRevert(abi.encodeWithSignature("TokenSoulbound()"));
        valocracy.transfer(bob, 50);

        // Verify balances haven't changed
        assertEq(valocracy.balanceOf(alice), 100);
        assertEq(valocracy.balanceOf(bob), 0);
    }

    function test_GrantVotingUnits() public {
        vm.prank(owner);
        valocracy.grantVotingUnits(alice, 100);

        assertEq(valocracy.balanceOf(alice), 100);
    }

    function test_Burn() public {
        // Grant voting units to alice
        vm.prank(owner);
        valocracy.grantVotingUnits(alice, 100);

        // Burn tokens
        vm.prank(alice);
        valocracy.burn(50);

        assertEq(valocracy.balanceOf(alice), 50);
    }

    function test_StablePeriod() public {
        // Grant voting units to alice
        vm.prank(owner);
        valocracy.grantVotingUnits(alice, 100);

        // Check balance during stable period
        assertEq(valocracy.balanceOf(alice), 100);

        // Move time forward but still within stable period
        vm.warp(block.timestamp + 45 days);
        assertEq(valocracy.balanceOf(alice), 100);

        // Move time to end of stable period
        vm.warp(block.timestamp + 45 days);
        assertEq(valocracy.balanceOf(alice), 100);
    }

    function test_DecayPeriod() public {
        // Grant voting units to alice
        vm.prank(owner);
        valocracy.grantVotingUnits(alice, 100);

        // Move time to start of decay period
        vm.warp(block.timestamp + 90 days);

        // Check balance at different points during decay period
        assertEq(valocracy.balanceOf(alice), 100); // At start of decay period

        vm.warp(block.timestamp + 45 days);
        assertEq(valocracy.balanceOf(alice), 50); // Halfway through decay period

        vm.warp(block.timestamp + 45 days);
        assertEq(valocracy.balanceOf(alice), 0); // End of decay period
    }

    function test_NewContributionResetsPeriods() public {
        // Grant initial voting units to alice
        vm.prank(owner);
        valocracy.grantVotingUnits(alice, 100);

        // Move time to decay period
        vm.warp(block.timestamp + 90 days);
        assertEq(valocracy.balanceOf(alice), 100);

        // Move time halfway through decay period
        vm.warp(block.timestamp + 45 days);
        assertEq(valocracy.balanceOf(alice), 50);

        // Grant new voting units, which should reset both periods
        vm.prank(owner);
        valocracy.grantVotingUnits(alice, 50);

        // Balance should be sum of previous balance and new units
        assertEq(valocracy.balanceOf(alice), 150);

        // Move time to end of new stable period
        vm.warp(block.timestamp + 90 days);
        assertEq(valocracy.balanceOf(alice), 150);

        // Move time halfway through new decay period
        vm.warp(block.timestamp + 45 days);
        assertEq(valocracy.balanceOf(alice), 75);
    }

    function test_OnlyOwnerCanGrantVotingUnits() public {
        vm.prank(alice);
        vm.expectRevert(abi.encodeWithSignature("OwnableUnauthorizedAccount(address)", alice));
        valocracy.grantVotingUnits(bob, 100);
    }
} 