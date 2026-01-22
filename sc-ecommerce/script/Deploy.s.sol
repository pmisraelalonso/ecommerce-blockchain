// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/EcommerceMain.sol";

contract DeployScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address euroTokenAddress = vm.envAddress("EURO_TOKEN_ADDRESS");
        
        // Validate Euro Token address
        require(euroTokenAddress != address(0), "Invalid Euro Token address");
        
        console.log("Deploying with configuration:");
        console.log("- Euro Token Address:", euroTokenAddress);
        console.log("- Deployer:", vm.addr(deployerPrivateKey));
        console.log("");
        
        vm.startBroadcast(deployerPrivateKey);
        
        EcommerceMain main = new EcommerceMain(euroTokenAddress);
        
        vm.stopBroadcast();
        
        console.log("=== Deployment Successful ===");
        console.log("");
        console.log("EcommerceMain deployed at:", address(main));
        console.log("CompanyRegistry:", address(main.companyRegistry()));
        console.log("ProductCatalog:", address(main.productCatalog()));
        console.log("CustomerRegistry:", address(main.customerRegistry()));
        console.log("ShoppingCart:", address(main.shoppingCart()));
        console.log("InvoiceSystem:", address(main.invoiceSystem()));
        console.log("PaymentGateway:", address(main.paymentGateway()));
        console.log("");
    }
}
