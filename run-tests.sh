#!/bin/bash

# Test Runner Script for E-Commerce Blockchain System
# Este script ejecuta todos los tests del proyecto

echo "🧪 E-Commerce Blockchain - Test Suite"
echo "======================================"
echo ""

# Colores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Función para verificar resultado
check_result() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Tests pasados!${NC}"
        return 0
    else
        echo -e "${RED}❌ Tests fallidos!${NC}"
        return 1
    fi
}

# Ejecutar tests de Smart Contracts E-Commerce
echo -e "${BLUE}📦 Ejecutando tests de Smart Contracts E-Commerce...${NC}"
cd sc-ecommerce
forge test
SC_RESULT=$?
check_result $SC_RESULT
echo ""

# Ejecutar tests de EuroToken
echo -e "${BLUE}💶 Ejecutando tests de EuroToken...${NC}"
cd ../stablecoin
forge test
TOKEN_RESULT=$?
check_result $TOKEN_RESULT
echo ""

# Resumen
echo "======================================"
echo "📊 RESUMEN DE TESTS"
echo "======================================"

cd ..

if [ $SC_RESULT -eq 0 ] && [ $TOKEN_RESULT -eq 0 ]; then
    echo -e "${GREEN}✅ TODOS LOS TESTS PASARON!${NC}"
    echo ""
    echo "Tests ejecutados:"
    echo "  - Smart Contracts E-Commerce: 38 tests"
    echo "  - EuroToken: 12 tests"
    echo "  - Total: 50 tests"
    echo ""
    echo "📄 Ver reporte completo en: TEST_RESULTS.md"
    exit 0
else
    echo -e "${RED}❌ ALGUNOS TESTS FALLARON${NC}"
    echo ""
    if [ $SC_RESULT -ne 0 ]; then
        echo "  - Smart Contracts E-Commerce: FALLIDO"
    fi
    if [ $TOKEN_RESULT -ne 0 ]; then
        echo "  - EuroToken: FALLIDO"
    fi
    exit 1
fi
