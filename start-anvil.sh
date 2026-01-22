#!/bin/bash

# Script to start Anvil blockchain in the background

echo "🔧 Starting Anvil blockchain..."

# Check if Anvil is already running
if curl -s -X POST -H "Content-Type: application/json" \
    --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' \
    http://localhost:8545 > /dev/null 2>&1; then
    echo "✅ Anvil is already running on localhost:8545"
    exit 0
fi

# Start Anvil in background
echo "Starting Anvil in background..."
nohup anvil > /tmp/anvil.log 2>&1 &
ANVIL_PID=$!

# Wait for Anvil to start
echo "Waiting for Anvil to be ready..."
for i in {1..10}; do
    sleep 1
    if curl -s -X POST -H "Content-Type: application/json" \
        --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' \
        http://localhost:8545 > /dev/null 2>&1; then
        echo "✅ Anvil started successfully (PID: $ANVIL_PID)"
        echo "📝 Logs: /tmp/anvil.log"
        echo ""
        echo "Available test accounts:"
        echo "  Account #0: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266"
        echo "  Private Key: 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"
        echo ""
        echo "To stop Anvil, run: kill $ANVIL_PID"
        exit 0
    fi
    echo "  Attempt $i/10..."
done

echo "❌ Failed to start Anvil"
echo "Check logs at: /tmp/anvil.log"
exit 1
