// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ProductCatalog.sol";

contract ShoppingCart {
    struct CartItem {
        uint256 productId;
        uint256 quantity;
        uint256 unitPrice;
    }

    mapping(address => CartItem[]) private carts;
    ProductCatalog public productCatalog;

    event ItemAdded(address indexed customer, uint256 indexed productId, uint256 quantity);
    event ItemRemoved(address indexed customer, uint256 indexed productId);
    event CartCleared(address indexed customer);

    constructor(address _productCatalog) {
        productCatalog = ProductCatalog(_productCatalog);
    }

    function addToCart(uint256 _productId, uint256 _quantity) external {
        ProductCatalog.Product memory product = productCatalog.getProduct(_productId);
        require(product.isActive, "Product not active");
        require(product.stock >= _quantity, "Insufficient stock");
        
        CartItem[] storage cart = carts[msg.sender];
        
        for (uint i = 0; i < cart.length; i++) {
            if (cart[i].productId == _productId) {
                cart[i].quantity += _quantity;
                emit ItemAdded(msg.sender, _productId, _quantity);
                return;
            }
        }
        
        cart.push(CartItem({
            productId: _productId,
            quantity: _quantity,
            unitPrice: product.price
        }));
        
        emit ItemAdded(msg.sender, _productId, _quantity);
    }

    function removeFromCart(uint256 _productId) external {
        CartItem[] storage cart = carts[msg.sender];
        
        for (uint i = 0; i < cart.length; i++) {
            if (cart[i].productId == _productId) {
                cart[i] = cart[cart.length - 1];
                cart.pop();
                emit ItemRemoved(msg.sender, _productId);
                return;
            }
        }
    }

    function getCart(address _customer) external view returns (CartItem[] memory) {
        return carts[_customer];
    }

    function clearCart(address _customer) external {
        delete carts[_customer];
        emit CartCleared(_customer);
    }

    function calculateTotal(address _customer) external view returns (uint256) {
        CartItem[] memory cart = carts[_customer];
        uint256 total = 0;
        
        for (uint i = 0; i < cart.length; i++) {
            total += cart[i].quantity * cart[i].unitPrice;
        }
        
        return total;
    }
}
