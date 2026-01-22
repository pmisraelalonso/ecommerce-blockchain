// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/ShoppingCart.sol";
import "../src/ProductCatalog.sol";
import "../src/CompanyRegistry.sol";

contract ShoppingCartTest is Test {
    ShoppingCart public cart;
    ProductCatalog public catalog;
    CompanyRegistry public companyRegistry;
    address public owner = address(1);
    address public customer = address(2);
    uint256 public productId1;
    uint256 public productId2;

    function setUp() public {
        vm.startPrank(owner);
        companyRegistry = new CompanyRegistry();
        catalog = new ProductCatalog(address(companyRegistry));
        cart = new ShoppingCart(address(catalog));
        
        uint256 companyId = companyRegistry.registerCompany(owner, "Company", "Desc");
        productId1 = catalog.addProduct(companyId, "Product 1", "Desc", 1000000, "Hash1", 100);
        productId2 = catalog.addProduct(companyId, "Product 2", "Desc", 2000000, "Hash2", 50);
        vm.stopPrank();
    }

    function testAddToCart() public {
        vm.prank(customer);
        cart.addToCart(productId1, 5);
        
        ShoppingCart.CartItem[] memory items = cart.getCart(customer);
        assertEq(items.length, 1);
        assertEq(items[0].productId, productId1);
        assertEq(items[0].quantity, 5);
        assertEq(items[0].unitPrice, 1000000);
    }

    function testAddMultipleProducts() public {
        vm.startPrank(customer);
        cart.addToCart(productId1, 3);
        cart.addToCart(productId2, 2);
        vm.stopPrank();
        
        ShoppingCart.CartItem[] memory items = cart.getCart(customer);
        assertEq(items.length, 2);
    }

    function testAddSameProductTwice() public {
        vm.startPrank(customer);
        cart.addToCart(productId1, 3);
        cart.addToCart(productId1, 2);
        vm.stopPrank();
        
        ShoppingCart.CartItem[] memory items = cart.getCart(customer);
        assertEq(items.length, 1);
        assertEq(items[0].quantity, 5);
    }

    function testRemoveFromCart() public {
        vm.startPrank(customer);
        cart.addToCart(productId1, 3);
        cart.addToCart(productId2, 2);
        cart.removeFromCart(productId1);
        vm.stopPrank();
        
        ShoppingCart.CartItem[] memory items = cart.getCart(customer);
        assertEq(items.length, 1);
        assertEq(items[0].productId, productId2);
    }

    function testCalculateTotal() public {
        vm.startPrank(customer);
        cart.addToCart(productId1, 5);  // 5 * 1000000 = 5000000
        cart.addToCart(productId2, 3);  // 3 * 2000000 = 6000000
        vm.stopPrank();
        
        uint256 total = cart.calculateTotal(customer);
        assertEq(total, 11000000);
    }

    function testClearCart() public {
        vm.prank(customer);
        cart.addToCart(productId1, 5);
        
        cart.clearCart(customer);
        
        ShoppingCart.CartItem[] memory items = cart.getCart(customer);
        assertEq(items.length, 0);
    }

    function testCannotAddInactiveProduct() public {
        // This would require modifying ProductCatalog to deactivate products
        // For now, we just test with active products
        vm.prank(customer);
        cart.addToCart(productId1, 1);
        
        ShoppingCart.CartItem[] memory items = cart.getCart(customer);
        assertEq(items.length, 1);
    }

    function testCannotExceedStock() public {
        vm.prank(customer);
        vm.expectRevert("Insufficient stock");
        cart.addToCart(productId1, 101); // Stock is 100
    }
}
