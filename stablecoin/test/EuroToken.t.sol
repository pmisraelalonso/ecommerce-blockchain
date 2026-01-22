// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/EuroToken.sol";

contract EuroTokenTest is Test {
    EuroToken public token;
    address public owner = address(1);
    address public user1 = address(2);
    address public user2 = address(3);

    function setUp() public {
        vm.prank(owner);
        token = new EuroToken();
    }

    function testInitialSetup() public {
        assertEq(token.name(), "EuroToken");
        assertEq(token.symbol(), "EURT");
        assertEq(token.decimals(), 6);
        assertEq(token.owner(), owner);
    }

    function testMint() public {
        vm.prank(owner);
        token.mint(user1, 1000000);
        
        assertEq(token.balanceOf(user1), 1000000);
    }

    function testOnlyOwnerCanMint() public {
        vm.prank(user1);
        vm.expectRevert();
        token.mint(user1, 1000000);
    }

    function testBurn() public {
        vm.prank(owner);
        token.mint(user1, 2000000);
        
        vm.prank(user1);
        token.burn(500000);
        
        assertEq(token.balanceOf(user1), 1500000);
    }

    function testBurnFrom() public {
        vm.prank(owner);
        token.mint(user1, 3000000);
        
        vm.prank(user1);
        token.approve(user2, 1000000);
        
        vm.prank(user2);
        token.burnFrom(user1, 1000000);
        
        assertEq(token.balanceOf(user1), 2000000);
    }

    function testTransfer() public {
        vm.prank(owner);
        token.mint(user1, 5000000);
        
        vm.prank(user1);
        token.transfer(user2, 2000000);
        
        assertEq(token.balanceOf(user1), 3000000);
        assertEq(token.balanceOf(user2), 2000000);
    }

    function testApproveAndTransferFrom() public {
        vm.prank(owner);
        token.mint(user1, 10000000);
        
        vm.prank(user1);
        token.approve(user2, 5000000);
        
        assertEq(token.allowance(user1, user2), 5000000);
        
        vm.prank(user2);
        token.transferFrom(user1, user2, 3000000);
        
        assertEq(token.balanceOf(user1), 7000000);
        assertEq(token.balanceOf(user2), 3000000);
        assertEq(token.allowance(user1, user2), 2000000);
    }

    function testMintMultipleAddresses() public {
        vm.startPrank(owner);
        token.mint(user1, 1000000);
        token.mint(user2, 2000000);
        token.mint(owner, 5000000);
        vm.stopPrank();
        
        assertEq(token.balanceOf(user1), 1000000);
        assertEq(token.balanceOf(user2), 2000000);
        assertEq(token.balanceOf(owner), 5000000);
    }

    function testCannotBurnMoreThanBalance() public {
        vm.prank(owner);
        token.mint(user1, 1000000);
        
        vm.prank(user1);
        vm.expectRevert();
        token.burn(2000000);
    }

    function testCannotTransferMoreThanBalance() public {
        vm.prank(owner);
        token.mint(user1, 1000000);
        
        vm.prank(user1);
        vm.expectRevert();
        token.transfer(user2, 2000000);
    }

    function testDecimalsAre6() public {
        assertEq(token.decimals(), 6);
        
        // 1 EURT = 1000000 (6 decimals)
        vm.prank(owner);
        token.mint(user1, 1000000);
        
        assertEq(token.balanceOf(user1), 1000000);
    }

    function testLargeAmounts() public {
        uint256 largeAmount = 1000000000000; // 1 million EURT
        
        vm.prank(owner);
        token.mint(user1, largeAmount);
        
        assertEq(token.balanceOf(user1), largeAmount);
        
        vm.prank(user1);
        token.transfer(user2, largeAmount / 2);
        
        assertEq(token.balanceOf(user1), largeAmount / 2);
        assertEq(token.balanceOf(user2), largeAmount / 2);
    }
}
