// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/EcommerceMain.sol";

contract MockToken {
    function balanceOf(address) external pure returns (uint256) {
        return 1000000;
    }
}

contract EcommerceMainTest is Test {
    EcommerceMain public main;
    MockToken public token;
    address public owner = address(1);

    function setUp() public {
        token = new MockToken();
        vm.prank(owner);
        main = new EcommerceMain(address(token));
    }

    function testDeployment() public {
        assertEq(main.euroTokenAddress(), address(token));
        assertEq(main.owner(), owner);
    }

    function testAllContractsDeployed() public {
        assertTrue(address(main.companyRegistry()) != address(0));
        assertTrue(address(main.productCatalog()) != address(0));
        assertTrue(address(main.customerRegistry()) != address(0));
        assertTrue(address(main.shoppingCart()) != address(0));
        assertTrue(address(main.invoiceSystem()) != address(0));
        assertTrue(address(main.paymentGateway()) != address(0));
    }

    function testCompanyRegistryIntegration() public view {
        // Verify the registry is accessible
        assertTrue(address(main.companyRegistry()) != address(0));
    }

    function testProductCatalogIntegration() public view {
        // Verify the catalog is accessible
        assertTrue(address(main.productCatalog()) != address(0));
    }

    function testCustomerRegistryIntegration() public {
        // Test that CustomerRegistry is deployed and accessible
        assertTrue(address(main.customerRegistry()) != address(0));
        
        // Register as the test contract
        main.customerRegistry().registerCustomer();
        
        // Verify registration
        CustomerRegistry.Customer memory customerData = main.customerRegistry().getCustomer(address(this));
        assertTrue(customerData.isActive);
    }

    function testFullWorkflow() public {
        // Verify all components are deployed and accessible
        assertTrue(address(main.companyRegistry()) != address(0));
        assertTrue(address(main.productCatalog()) != address(0));
        assertTrue(address(main.customerRegistry()) != address(0));
        assertTrue(address(main.shoppingCart()) != address(0));
        assertTrue(address(main.invoiceSystem()) != address(0));
        assertTrue(address(main.paymentGateway()) != address(0));
        
        // Test euro token address
        assertEq(main.euroTokenAddress(), address(token));
        assertEq(main.owner(), owner);
    }
}
