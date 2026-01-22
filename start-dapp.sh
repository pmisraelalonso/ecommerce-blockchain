#!/bin/bash

# Script unificado para iniciar la DAPP

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "═══════════════════════════════════════════════════════════"
echo "🚀 E-Commerce Blockchain DAPP - Inicio Completo"
echo "═══════════════════════════════════════════════════════════"
echo ""

# Verificar que Anvil esté corriendo
if ! curl -s -X POST -H "Content-Type: application/json" \
    --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' \
    http://127.0.0.1:8545 > /dev/null 2>&1; then
    echo "📡 Anvil no está corriendo. Iniciándolo..."
    bash "$SCRIPT_DIR/start-anvil.sh"
    echo ""
fi

echo "✅ Anvil está corriendo"
echo ""

# Verificar si los contratos están desplegados
if [ ! -f "$SCRIPT_DIR/DEPLOYED_CONTRACTS.md" ]; then
    echo "📦 Los contratos no están desplegados. Desplegando..."
    bash "$SCRIPT_DIR/deploy-all.sh"
    echo ""
fi

echo "✅ Contratos desplegados"
echo ""

# Iniciar la DAPP
echo "🌐 Iniciando DAPP en puerto 3000..."
cd "$SCRIPT_DIR/dapp"
npm run dev &
DAPP_PID=$!

echo ""
echo "⏳ Esperando que la DAPP inicie..."
sleep 8

if ps -p $DAPP_PID > /dev/null; then
    echo ""
    echo "═══════════════════════════════════════════════════════════"
    echo "✅ DAPP iniciada exitosamente!"
    echo ""
    echo "🌐 Accede a la aplicación en:"
    echo "   📍 http://localhost:3000"
    echo ""
    echo "📝 Secciones disponibles:"
    echo "   🛍️  Tienda: http://localhost:3000/shop"
    echo "   ⚙️  Admin: http://localhost:3000/admin"
    echo ""
    echo "🔐 Conecta tu wallet MetaMask:"
    echo "   - Network: Anvil Local"
    echo "   - Chain ID: 31337"
    echo "   - RPC URL: http://127.0.0.1:8545"
    echo ""
    echo "Para detener: bash stop-dapp.sh"
    echo "═══════════════════════════════════════════════════════════"
else
    echo "❌ Error al iniciar la DAPP"
    echo "Ver logs en la terminal"
fi
