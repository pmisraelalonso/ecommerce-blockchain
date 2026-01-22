// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/ProductCatalog.sol";
import "../src/CompanyRegistry.sol";

contract ProductCatalogTest is Test {
    ProductCatalog public catalog;
    CompanyRegistry public companyRegistry;
    address public owner = address(1);
    address public company1 = address(2);
    uint256 public companyId;

    function setUp() public {
        vm.startPrank(owner);
        companyRegistry = new CompanyRegistry();
        catalog = new ProductCatalog(address(companyRegistry));
        companyId = companyRegistry.registerCompany(company1, "Test Company", "Description");
        vm.stopPrank();
    }

    function testAddProduct() public {
        vm.prank(owner);
        uint256 productId = catalog.addProduct(
            companyId,
            "Test Product",
            "Product Description",
            1000000, // 1 EURT (6 decimals)
            "QmTestHash",
            100
        );
        
        assertEq(productId, 1);
        
        ProductCatalog.Product memory product = catalog.getProduct(productId);
        assertEq(product.name, "Test Product");
        assertEq(product.price, 1000000);
        assertEq(product.stock, 100);
        assertTrue(product.isActive);
    }

    function testUpdateStock() public {
        vm.prank(owner);
        uint256 productId = catalog.addProduct(companyId, "Product", "Desc", 100, "Hash", 50);
        
        catalog.updateStock(productId, 75);
        
        ProductCatalog.Product memory product = catalog.getProduct(productId);
        assertEq(product.stock, 75);
    }

    function testGetProductsByCompany() public {
        vm.startPrank(owner);
        catalog.addProduct(companyId, "Product 1", "Desc", 100, "Hash1", 50);
        catalog.addProduct(companyId, "Product 2", "Desc", 200, "Hash2", 30);
        vm.stopPrank();
        
        uint256[] memory products = catalog.getProductsByCompany(companyId);
        assertEq(products.length, 2);
        assertEq(products[0], 1);
        assertEq(products[1], 2);
    }

    function testGetProductNotFound() public {
        vm.expectRevert("Product not found");
        catalog.getProduct(999);
    }

    function testMultipleProducts() public {
        vm.startPrank(owner);
        for (uint i = 0; i < 5; i++) {
            catalog.addProduct(
                companyId,
                string(abi.encodePacked("Product ", vm.toString(i))),
                "Description",
                (i + 1) * 100000,
                string(abi.encodePacked("Hash", vm.toString(i))),
                10 * (i + 1)
            );
        }
        vm.stopPrank();
        
        uint256[] memory products = catalog.getProductsByCompany(companyId);
        assertEq(products.length, 5);
    }
}
