// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./CompanyRegistry.sol";

contract ProductCatalog {
    struct Product {
        uint256 productId;
        uint256 companyId;
        string name;
        string description;
        uint256 price;
        string ipfsImageHash;
        uint256 stock;
        bool isActive;
        uint256 createdAt;
    }

    uint256 private nextProductId = 1;
    mapping(uint256 => Product) private products;
    mapping(uint256 => uint256[]) private companyProducts;
    CompanyRegistry public companyRegistry;

    event ProductAdded(uint256 indexed productId, uint256 indexed companyId, string name, uint256 price);
    event ProductUpdated(uint256 indexed productId);
    event StockUpdated(uint256 indexed productId, uint256 newStock);

    constructor(address _companyRegistry) {
        companyRegistry = CompanyRegistry(_companyRegistry);
    }

    function addProduct(
        uint256 _companyId,
        string memory _name,
        string memory _description,
        uint256 _price,
        string memory _ipfsImageHash,
        uint256 _stock
    ) external returns (uint256) {
        uint256 productId = nextProductId++;
        
        products[productId] = Product({
            productId: productId,
            companyId: _companyId,
            name: _name,
            description: _description,
            price: _price,
            ipfsImageHash: _ipfsImageHash,
            stock: _stock,
            isActive: true,
            createdAt: block.timestamp
        });
        
        companyProducts[_companyId].push(productId);
        emit ProductAdded(productId, _companyId, _name, _price);
        return productId;
    }

    function updateStock(uint256 _productId, uint256 _newStock) external {
        require(products[_productId].productId != 0, "Product not found");
        products[_productId].stock = _newStock;
        emit StockUpdated(_productId, _newStock);
    }

    function getProduct(uint256 _productId) external view returns (Product memory) {
        require(products[_productId].productId != 0, "Product not found");
        return products[_productId];
    }

    function getProductsByCompany(uint256 _companyId) external view returns (uint256[] memory) {
        return companyProducts[_companyId];
    }
}
