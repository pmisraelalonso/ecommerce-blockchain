// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/CompanyRegistry.sol";

contract CompanyRegistryTest is Test {
    CompanyRegistry public registry;
    address public owner = address(1);
    address public company1 = address(2);

    function setUp() public {
        vm.prank(owner);
        registry = new CompanyRegistry();
    }

    function testRegisterCompany() public {
        vm.prank(owner);
        uint256 companyId = registry.registerCompany(company1, "Test Company", "Description");
        
        assertEq(companyId, 1);
        
        CompanyRegistry.Company memory company = registry.getCompany(companyId);
        assertEq(company.name, "Test Company");
        assertEq(company.companyAddress, company1);
        assertTrue(company.isActive);
    }

    function testOnlyOwnerCanRegister() public {
        vm.prank(address(3));
        vm.expectRevert("Only owner");
        registry.registerCompany(company1, "Test", "Desc");
    }
}
