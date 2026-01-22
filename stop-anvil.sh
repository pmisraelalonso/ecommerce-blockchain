#!/bin/bash

# Script to stop Anvil blockchain

echo "🛑 Stopping Anvil blockchain..."

# Find Anvil process
ANVIL_PID=$(pgrep -f "anvil" | head -1)

if [ -z "$ANVIL_PID" ]; then
    echo "ℹ️  Anvil is not running"
    exit 0
fi

# Kill the process
kill $ANVIL_PID 2>/dev/null

# Wait for process to stop
for i in {1..5}; do
    if ! ps -p $ANVIL_PID > /dev/null 2>&1; then
        echo "✅ Anvil stopped successfully"
        exit 0
    fi
    sleep 1
done

# Force kill if still running
kill -9 $ANVIL_PID 2>/dev/null
echo "✅ Anvil stopped (forced)"
