// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ShoppingCart.sol";
import "./ProductCatalog.sol";

contract InvoiceSystem {
    struct Invoice {
        uint256 invoiceId;
        uint256 companyId;
        address customerAddress;
        uint256 totalAmount;
        uint256 timestamp;
        bool isPaid;
        string paymentTxHash;
    }

    struct InvoiceItem {
        uint256 productId;
        string productName;
        uint256 quantity;
        uint256 unitPrice;
        uint256 totalPrice;
    }

    uint256 private nextInvoiceId = 1;
    mapping(uint256 => Invoice) private invoices;
    mapping(uint256 => InvoiceItem[]) private invoiceItems;
    mapping(address => uint256[]) private customerInvoices;
    
    ShoppingCart public shoppingCart;
    ProductCatalog public productCatalog;

    event InvoiceCreated(uint256 indexed invoiceId, address indexed customer, uint256 amount);
    event InvoicePaid(uint256 indexed invoiceId, string txHash);

    constructor(address _shoppingCart, address _productCatalog) {
        shoppingCart = ShoppingCart(_shoppingCart);
        productCatalog = ProductCatalog(_productCatalog);
    }

    function createInvoice(address _customer, uint256 _companyId) external returns (uint256) {
        uint256 invoiceId = nextInvoiceId++;
        uint256 total = shoppingCart.calculateTotal(_customer);
        
        invoices[invoiceId] = Invoice({
            invoiceId: invoiceId,
            companyId: _companyId,
            customerAddress: _customer,
            totalAmount: total,
            timestamp: block.timestamp,
            isPaid: false,
            paymentTxHash: ""
        });
        
        ShoppingCart.CartItem[] memory cart = shoppingCart.getCart(_customer);
        for (uint i = 0; i < cart.length; i++) {
            ProductCatalog.Product memory product = productCatalog.getProduct(cart[i].productId);
            invoiceItems[invoiceId].push(InvoiceItem({
                productId: cart[i].productId,
                productName: product.name,
                quantity: cart[i].quantity,
                unitPrice: cart[i].unitPrice,
                totalPrice: cart[i].quantity * cart[i].unitPrice
            }));
        }
        
        customerInvoices[_customer].push(invoiceId);
        emit InvoiceCreated(invoiceId, _customer, total);
        return invoiceId;
    }

    function markAsPaid(uint256 _invoiceId, string memory _txHash) external {
        require(invoices[_invoiceId].invoiceId != 0, "Invoice not found");
        invoices[_invoiceId].isPaid = true;
        invoices[_invoiceId].paymentTxHash = _txHash;
        emit InvoicePaid(_invoiceId, _txHash);
    }

    function getInvoice(uint256 _invoiceId) external view returns (Invoice memory) {
        return invoices[_invoiceId];
    }

    function getInvoiceItems(uint256 _invoiceId) external view returns (InvoiceItem[] memory) {
        return invoiceItems[_invoiceId];
    }

    function getCustomerInvoices(address _customer) external view returns (uint256[] memory) {
        return customerInvoices[_customer];
    }
}
