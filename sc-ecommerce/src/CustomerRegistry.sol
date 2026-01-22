// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CustomerRegistry {
    struct Customer {
        address customerAddress;
        uint256 totalPurchases;
        uint256 totalSpent;
        uint256 registrationDate;
        uint256 lastPurchaseDate;
        bool isActive;
    }

    mapping(address => Customer) private customers;

    event CustomerRegistered(address indexed customerAddress);
    event PurchaseStatsUpdated(address indexed customerAddress, uint256 amount);

    function registerCustomer() external {
        require(customers[msg.sender].customerAddress == address(0), "Already registered");
        
        customers[msg.sender] = Customer({
            customerAddress: msg.sender,
            totalPurchases: 0,
            totalSpent: 0,
            registrationDate: block.timestamp,
            lastPurchaseDate: 0,
            isActive: true
        });
        
        emit CustomerRegistered(msg.sender);
    }

    function updatePurchaseStats(address _customer, uint256 _amount) external {
        if (customers[_customer].customerAddress == address(0)) {
            customers[_customer] = Customer({
                customerAddress: _customer,
                totalPurchases: 0,
                totalSpent: 0,
                registrationDate: block.timestamp,
                lastPurchaseDate: 0,
                isActive: true
            });
        }
        
        customers[_customer].totalPurchases++;
        customers[_customer].totalSpent += _amount;
        customers[_customer].lastPurchaseDate = block.timestamp;
        
        emit PurchaseStatsUpdated(_customer, _amount);
    }

    function getCustomer(address _customer) external view returns (Customer memory) {
        return customers[_customer];
    }
}
