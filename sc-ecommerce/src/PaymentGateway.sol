// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function transfer(address to, uint256 amount) external returns (bool);
}

import "./InvoiceSystem.sol";
import "./ProductCatalog.sol";

contract PaymentGateway {
    IERC20 public euroToken;
    InvoiceSystem public invoiceSystem;
    ProductCatalog public productCatalog;

    event PaymentProcessed(uint256 indexed invoiceId, address indexed customer, uint256 amount);
    event RefundProcessed(uint256 indexed invoiceId, address indexed customer, uint256 amount);

    constructor(address _euroToken, address _invoiceSystem, address _productCatalog) {
        euroToken = IERC20(_euroToken);
        invoiceSystem = InvoiceSystem(_invoiceSystem);
        productCatalog = ProductCatalog(_productCatalog);
    }

    function processPayment(address _customer, uint256 _amount, uint256 _invoiceId) external returns (bool) {
        require(euroToken.transferFrom(_customer, address(this), _amount), "Transfer failed");
        
        invoiceSystem.markAsPaid(_invoiceId, "");
        emit PaymentProcessed(_invoiceId, _customer, _amount);
        return true;
    }

    function refund(uint256 _invoiceId) external returns (bool) {
        InvoiceSystem.Invoice memory invoice = invoiceSystem.getInvoice(_invoiceId);
        require(invoice.isPaid, "Invoice not paid");
        
        require(euroToken.transfer(invoice.customerAddress, invoice.totalAmount), "Refund failed");
        emit RefundProcessed(_invoiceId, invoice.customerAddress, invoice.totalAmount);
        return true;
    }
}
