// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/CustomerRegistry.sol";

contract CustomerRegistryTest is Test {
    CustomerRegistry public registry;
    address public customer1 = address(1);
    address public customer2 = address(2);

    function setUp() public {
        registry = new CustomerRegistry();
    }

    function testRegisterCustomer() public {
        vm.prank(customer1);
        registry.registerCustomer();
        
        CustomerRegistry.Customer memory customer = registry.getCustomer(customer1);
        assertEq(customer.customerAddress, customer1);
        assertEq(customer.totalPurchases, 0);
        assertEq(customer.totalSpent, 0);
        assertTrue(customer.isActive);
    }

    function testCannotRegisterTwice() public {
        vm.startPrank(customer1);
        registry.registerCustomer();
        
        vm.expectRevert("Already registered");
        registry.registerCustomer();
        vm.stopPrank();
    }

    function testUpdatePurchaseStats() public {
        registry.updatePurchaseStats(customer1, 5000000);
        
        CustomerRegistry.Customer memory customer = registry.getCustomer(customer1);
        assertEq(customer.totalPurchases, 1);
        assertEq(customer.totalSpent, 5000000);
    }

    function testUpdatePurchaseStatsMultipleTimes() public {
        registry.updatePurchaseStats(customer1, 1000000);
        registry.updatePurchaseStats(customer1, 2000000);
        registry.updatePurchaseStats(customer1, 3000000);
        
        CustomerRegistry.Customer memory customer = registry.getCustomer(customer1);
        assertEq(customer.totalPurchases, 3);
        assertEq(customer.totalSpent, 6000000);
    }

    function testGetUnregisteredCustomer() public {
        CustomerRegistry.Customer memory customer = registry.getCustomer(customer2);
        assertEq(customer.customerAddress, address(0));
        assertEq(customer.totalPurchases, 0);
    }

    function testAutoRegisterOnPurchase() public {
        registry.updatePurchaseStats(customer2, 1000000);
        
        CustomerRegistry.Customer memory customer = registry.getCustomer(customer2);
        assertEq(customer.customerAddress, customer2);
        assertEq(customer.totalPurchases, 1);
        assertTrue(customer.isActive);
    }
}
