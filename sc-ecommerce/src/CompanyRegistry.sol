// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CompanyRegistry {
    struct Company {
        uint256 companyId;
        address companyAddress;
        string name;
        string description;
        bool isActive;
        uint256 registrationDate;
    }

    uint256 private nextCompanyId = 1;
    uint256[] private companyIds;
    mapping(uint256 => Company) private companies;
    mapping(address => uint256) private addressToCompanyId;
    address public owner;

    event CompanyRegistered(uint256 indexed companyId, address indexed companyAddress, string name);
    event CompanyDeactivated(uint256 indexed companyId);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    function registerCompany(address _address, string memory _name, string memory _description) external onlyOwner returns (uint256) {
        require(addressToCompanyId[_address] == 0, "Company address already registered");
        
        uint256 companyId = nextCompanyId++;
        
        companies[companyId] = Company({
            companyId: companyId,
            companyAddress: _address,
            name: _name,
            description: _description,
            isActive: true,
            registrationDate: block.timestamp
        });
        
        companyIds.push(companyId);
        addressToCompanyId[_address] = companyId;
        
        emit CompanyRegistered(companyId, _address, _name);
        return companyId;
    }

    function getCompany(uint256 _companyId) external view returns (Company memory) {
        require(companies[_companyId].companyId != 0, "Company not found");
        return companies[_companyId];
    }

    function deactivateCompany(uint256 _companyId) external onlyOwner {
        require(companies[_companyId].companyId != 0, "Company not found");
        companies[_companyId].isActive = false;
        emit CompanyDeactivated(_companyId);
    }

    function getAllCompanies() external view returns (uint256[] memory) {
        return companyIds;
    }
}
