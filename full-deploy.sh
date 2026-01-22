#!/bin/bash

# Complete deployment script with Anvil management

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "═══════════════════════════════════════════════════════════"
echo "🚀 E-Commerce Blockchain - Full Deployment"
echo "═══════════════════════════════════════════════════════════"
echo ""

# Check if Anvil needs to be started
if ! curl -s -X POST -H "Content-Type: application/json" \
    --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' \
    http://localhost:8545 > /dev/null 2>&1; then
    echo "📡 Anvil is not running. Starting it now..."
    bash "$SCRIPT_DIR/start-anvil.sh"
    echo ""
fi

# Run deployment
echo "🚀 Starting deployment process..."
echo ""
bash "$SCRIPT_DIR/deploy-all.sh"

echo ""
echo "═══════════════════════════════════════════════════════════"
echo "✅ Full deployment completed successfully!"
echo "═══════════════════════════════════════════════════════════"
