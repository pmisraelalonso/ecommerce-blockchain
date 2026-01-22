// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/InvoiceSystem.sol";
import "../src/ShoppingCart.sol";
import "../src/ProductCatalog.sol";
import "../src/CompanyRegistry.sol";

contract InvoiceSystemTest is Test {
    InvoiceSystem public invoiceSystem;
    ShoppingCart public cart;
    ProductCatalog public catalog;
    CompanyRegistry public companyRegistry;
    address public owner = address(1);
    address public customer = address(2);
    uint256 public companyId;
    uint256 public productId1;
    uint256 public productId2;

    function setUp() public {
        vm.startPrank(owner);
        companyRegistry = new CompanyRegistry();
        catalog = new ProductCatalog(address(companyRegistry));
        cart = new ShoppingCart(address(catalog));
        invoiceSystem = new InvoiceSystem(address(cart), address(catalog));
        
        companyId = companyRegistry.registerCompany(owner, "Company", "Desc");
        productId1 = catalog.addProduct(companyId, "Product 1", "Desc", 1000000, "Hash1", 100);
        productId2 = catalog.addProduct(companyId, "Product 2", "Desc", 2000000, "Hash2", 50);
        vm.stopPrank();
    }

    function testCreateInvoice() public {
        vm.startPrank(customer);
        cart.addToCart(productId1, 5);
        cart.addToCart(productId2, 2);
        vm.stopPrank();
        
        uint256 invoiceId = invoiceSystem.createInvoice(customer, companyId);
        
        assertEq(invoiceId, 1);
        
        InvoiceSystem.Invoice memory invoice = invoiceSystem.getInvoice(invoiceId);
        assertEq(invoice.companyId, companyId);
        assertEq(invoice.customerAddress, customer);
        assertEq(invoice.totalAmount, 9000000); // (5 * 1000000) + (2 * 2000000)
        assertFalse(invoice.isPaid);
    }

    function testGetInvoiceItems() public {
        vm.startPrank(customer);
        cart.addToCart(productId1, 3);
        cart.addToCart(productId2, 1);
        vm.stopPrank();
        
        uint256 invoiceId = invoiceSystem.createInvoice(customer, companyId);
        
        InvoiceSystem.InvoiceItem[] memory items = invoiceSystem.getInvoiceItems(invoiceId);
        assertEq(items.length, 2);
        assertEq(items[0].quantity, 3);
        assertEq(items[1].quantity, 1);
    }

    function testMarkAsPaid() public {
        vm.prank(customer);
        cart.addToCart(productId1, 2);
        
        uint256 invoiceId = invoiceSystem.createInvoice(customer, companyId);
        
        invoiceSystem.markAsPaid(invoiceId, "0x123abc");
        
        InvoiceSystem.Invoice memory invoice = invoiceSystem.getInvoice(invoiceId);
        assertTrue(invoice.isPaid);
        assertEq(invoice.paymentTxHash, "0x123abc");
    }

    function testGetCustomerInvoices() public {
        vm.startPrank(customer);
        cart.addToCart(productId1, 1);
        vm.stopPrank();
        
        invoiceSystem.createInvoice(customer, companyId);
        
        vm.startPrank(customer);
        cart.addToCart(productId2, 1);
        vm.stopPrank();
        
        invoiceSystem.createInvoice(customer, companyId);
        
        uint256[] memory invoices = invoiceSystem.getCustomerInvoices(customer);
        assertEq(invoices.length, 2);
    }

    function testMultipleCustomerInvoices() public {
        address customer2 = address(3);
        
        vm.prank(customer);
        cart.addToCart(productId1, 1);
        invoiceSystem.createInvoice(customer, companyId);
        
        vm.prank(customer2);
        cart.addToCart(productId2, 1);
        invoiceSystem.createInvoice(customer2, companyId);
        
        uint256[] memory invoices1 = invoiceSystem.getCustomerInvoices(customer);
        uint256[] memory invoices2 = invoiceSystem.getCustomerInvoices(customer2);
        
        assertEq(invoices1.length, 1);
        assertEq(invoices2.length, 1);
    }

    function testCannotMarkNonExistentInvoiceAsPaid() public {
        vm.expectRevert("Invoice not found");
        invoiceSystem.markAsPaid(999, "0xabc");
    }
}
