// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./CompanyRegistry.sol";
import "./ProductCatalog.sol";
import "./CustomerRegistry.sol";
import "./ShoppingCart.sol";
import "./InvoiceSystem.sol";
import "./PaymentGateway.sol";

contract EcommerceMain {
    address public euroTokenAddress;
    address public owner;

    CompanyRegistry public companyRegistry;
    ProductCatalog public productCatalog;
    CustomerRegistry public customerRegistry;
    ShoppingCart public shoppingCart;
    InvoiceSystem public invoiceSystem;
    PaymentGateway public paymentGateway;

    constructor(address _euroTokenAddress) {
        euroTokenAddress = _euroTokenAddress;
        owner = msg.sender;

        companyRegistry = new CompanyRegistry();
        productCatalog = new ProductCatalog(address(companyRegistry));
        customerRegistry = new CustomerRegistry();
        shoppingCart = new ShoppingCart(address(productCatalog));
        invoiceSystem = new InvoiceSystem(address(shoppingCart), address(productCatalog));
        paymentGateway = new PaymentGateway(_euroTokenAddress, address(invoiceSystem), address(productCatalog));
    }
}
