#!/bin/bash

echo "🛑 Deteniendo E-Commerce Blockchain DAPP..."

# Detener proceso en puerto 3000
pid=$(lsof -ti:3000 2>/dev/null)
if [ ! -z "$pid" ]; then
    echo "   Deteniendo proceso en puerto 3000 (PID: $pid)..."
    kill -9 $pid 2>/dev/null
    sleep 1
    echo "✅ DAPP detenida"
else
    echo "   No hay proceso corriendo en puerto 3000"
fi
