// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/PaymentGateway.sol";
import "../src/InvoiceSystem.sol";
import "../src/ShoppingCart.sol";
import "../src/ProductCatalog.sol";
import "../src/CompanyRegistry.sol";

// Mock ERC20 Token para testing
contract MockERC20 {
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    function mint(address to, uint256 amount) external {
        balanceOf[to] += amount;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external returns (bool) {
        require(balanceOf[from] >= amount, "Insufficient balance");
        require(allowance[from][msg.sender] >= amount, "Insufficient allowance");
        
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
        allowance[from][msg.sender] -= amount;
        return true;
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        return true;
    }
}

contract PaymentGatewayTest is Test {
    PaymentGateway public gateway;
    InvoiceSystem public invoiceSystem;
    ShoppingCart public cart;
    ProductCatalog public catalog;
    CompanyRegistry public companyRegistry;
    MockERC20 public token;
    
    address public owner = address(1);
    address public customer = address(2);
    uint256 public companyId;
    uint256 public productId;

    function setUp() public {
        vm.startPrank(owner);
        
        // Deploy all contracts
        token = new MockERC20();
        companyRegistry = new CompanyRegistry();
        catalog = new ProductCatalog(address(companyRegistry));
        cart = new ShoppingCart(address(catalog));
        invoiceSystem = new InvoiceSystem(address(cart), address(catalog));
        gateway = new PaymentGateway(address(token), address(invoiceSystem), address(catalog));
        
        // Setup test data
        companyId = companyRegistry.registerCompany(owner, "Company", "Desc");
        productId = catalog.addProduct(companyId, "Product", "Desc", 1000000, "Hash", 100);
        
        vm.stopPrank();
        
        // Mint tokens to customer
        token.mint(customer, 10000000);
    }

    function testProcessPayment() public {
        // Customer adds to cart
        vm.prank(customer);
        cart.addToCart(productId, 5);
        
        // Create invoice
        uint256 invoiceId = invoiceSystem.createInvoice(customer, companyId);
        uint256 amount = 5000000; // 5 * 1000000
        
        // Customer approves payment
        vm.prank(customer);
        token.approve(address(gateway), amount);
        
        // Process payment
        gateway.processPayment(customer, amount, invoiceId);
        
        // Verify invoice is paid
        InvoiceSystem.Invoice memory invoice = invoiceSystem.getInvoice(invoiceId);
        assertTrue(invoice.isPaid);
        
        // Verify tokens transferred
        assertEq(token.balanceOf(address(gateway)), amount);
        assertEq(token.balanceOf(customer), 5000000); // 10000000 - 5000000
    }

    function testRefund() public {
        // Setup: Create and pay invoice
        vm.prank(customer);
        cart.addToCart(productId, 2);
        
        uint256 invoiceId = invoiceSystem.createInvoice(customer, companyId);
        uint256 amount = 2000000;
        
        vm.prank(customer);
        token.approve(address(gateway), amount);
        gateway.processPayment(customer, amount, invoiceId);
        
        uint256 customerBalanceBefore = token.balanceOf(customer);
        
        // Process refund
        gateway.refund(invoiceId);
        
        // Verify refund
        assertEq(token.balanceOf(customer), customerBalanceBefore + amount);
        assertEq(token.balanceOf(address(gateway)), 0);
    }

    function testCannotRefundUnpaidInvoice() public {
        vm.prank(customer);
        cart.addToCart(productId, 1);
        
        uint256 invoiceId = invoiceSystem.createInvoice(customer, companyId);
        
        vm.expectRevert("Invoice not paid");
        gateway.refund(invoiceId);
    }

    function testPaymentFailsWithoutApproval() public {
        vm.prank(customer);
        cart.addToCart(productId, 1);
        
        uint256 invoiceId = invoiceSystem.createInvoice(customer, companyId);
        
        vm.expectRevert("Insufficient allowance");
        gateway.processPayment(customer, 1000000, invoiceId);
    }

    function testPaymentFailsWithInsufficientBalance() public {
        address poorCustomer = address(5);
        
        vm.prank(poorCustomer);
        cart.addToCart(productId, 1);
        
        uint256 invoiceId = invoiceSystem.createInvoice(poorCustomer, companyId);
        
        vm.prank(poorCustomer);
        token.approve(address(gateway), 1000000);
        
        vm.expectRevert("Insufficient balance");
        gateway.processPayment(poorCustomer, 1000000, invoiceId);
    }
}
