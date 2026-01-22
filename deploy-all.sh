#!/bin/bash

set -e  # Exit on error

echo "🚀 Deploying E-Commerce Blockchain System..."

# Check if Anvil is running
echo "🔍 Checking if Anvil is running..."
if ! curl -s -X POST -H "Content-Type: application/json" \
    --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' \
    http://localhost:8545 > /dev/null 2>&1; then
    echo "❌ Error: Anvil is not running on localhost:8545"
    echo "Please start Anvil in a separate terminal with: anvil"
    echo "Or run it in background with: nohup anvil > /tmp/anvil.log 2>&1 &"
    exit 1
fi
echo "✅ Anvil is running"

# Store the initial directory
INITIAL_DIR=$(pwd)

# 1. Deploy EuroToken
cd "$INITIAL_DIR/stablecoin"
echo ""
echo "📦 Installing dependencies for stablecoin..."
forge install OpenZeppelin/openzeppelin-contracts --no-git 2>/dev/null || true

echo "💶 Deploying EuroToken..."
DEPLOY_OUTPUT=$(forge create src/EuroToken.sol:EuroToken \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 \
    --rpc-url http://localhost:8545 \
    --broadcast 2>&1)

EURO_TOKEN=$(echo "$DEPLOY_OUTPUT" | grep "Deployed to:" | awk '{print $3}')

if [ -z "$EURO_TOKEN" ]; then
    echo "❌ Error: Failed to deploy EuroToken"
    echo "$DEPLOY_OUTPUT"
    exit 1
fi

echo "✅ EuroToken deployed at: $EURO_TOKEN"

# 2. Deploy E-commerce contracts
cd "$INITIAL_DIR/sc-ecommerce"
echo ""
echo "📦 Installing dependencies for e-commerce..."
forge install foundry-rs/forge-std --no-git 2>/dev/null || true

echo "🏪 Deploying E-commerce contracts..."
export EURO_TOKEN_ADDRESS=$EURO_TOKEN
export PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

if forge script script/Deploy.s.sol --rpc-url http://localhost:8545 --broadcast; then
    echo ""
    echo "✅ Deployment complete!"
    echo ""
    echo "═══════════════════════════════════════════════════════════"
    echo "📋 DEPLOYED CONTRACTS SUMMARY"
    echo "═══════════════════════════════════════════════════════════"
    echo ""
    echo "🌐 Network: Anvil Local (Chain ID: 31337)"
    echo "🔗 RPC URL: http://localhost:8545"
    echo ""
    echo "💶 Stablecoin:"
    echo "   EuroToken: $EURO_TOKEN"
    echo ""
    echo "🏪 E-Commerce System:"
    
    # Extract contract addresses from the latest deployment
    BROADCAST_FILE="$INITIAL_DIR/sc-ecommerce/broadcast/Deploy.s.sol/31337/run-latest.json"
    if [ -f "$BROADCAST_FILE" ]; then
        echo "   Check the deployment logs above for contract addresses"
    fi
    
    echo ""
    echo "═══════════════════════════════════════════════════════════"
    echo ""
    echo "💾 Deployment details saved to:"
    echo "   - $INITIAL_DIR/DEPLOYED_CONTRACTS.md"
    echo "   - $BROADCAST_FILE"
    echo ""
    echo "📝 Next steps:"
    echo "   1. Update web-admin and web-customer with contract addresses"
    echo "   2. Configure ABIs in the frontend applications"
    echo "   3. Start the web applications"
    echo ""
else
    echo "❌ Error: E-commerce contracts deployment failed"
    exit 1
fi

cd "$INITIAL_DIR"
