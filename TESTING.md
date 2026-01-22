# 🧪 Testing Suite - E-Commerce Blockchain

Carpeta de pruebas completa para el sistema E-Commerce Blockchain.

## 📋 Contenido

### Smart Contracts E-Commerce (`sc-ecommerce/test/`)

| Archivo | Tests | Descripción |
|---------|-------|-------------|
| `CompanyRegistry.t.sol` | 2 | Tests para registro y gestión de empresas |
| `ProductCatalog.t.sol` | 5 | Tests para catálogo y gestión de productos |
| `CustomerRegistry.t.sol` | 6 | Tests para registro de clientes y estadísticas |
| `ShoppingCart.t.sol` | 8 | Tests para carrito de compras y validaciones |
| `InvoiceSystem.t.sol` | 6 | Tests para sistema de facturación |
| `PaymentGateway.t.sol` | 5 | Tests para gateway de pagos |
| `EcommerceMain.t.sol` | 6 | Tests de integración del sistema completo |

**Total:** 38 tests

### EuroToken (`stablecoin/test/`)

| Archivo | Tests | Descripción |
|---------|-------|-------------|
| `EuroToken.t.sol` | 12 | Tests completos del token ERC20 |

**Total:** 12 tests

## 🚀 Ejecución Rápida

### Ejecutar todos los tests
```bash
./run-tests.sh
```

### Tests individuales

**E-Commerce Contracts:**
```bash
cd sc-ecommerce
forge test
```

**EuroToken:**
```bash
cd stablecoin
forge test
```

### Tests con output detallado
```bash
forge test -vv      # Output detallado
forge test -vvv     # Con trazas
forge test -vvvv    # Debug completo
```

### Tests específicos
```bash
# Por contrato
forge test --match-contract CompanyRegistryTest

# Por función
forge test --match-test testRegisterCompany

# Con patrón
forge test --match-path "test/Company*.sol"
```

### Reporte de gas
```bash
forge test --gas-report
```

## 📊 Cobertura

### Funcionalidades Testeadas

#### ✅ Gestión de Empresas
- Registro de empresas (solo owner)
- Consulta de información
- Desactivación de empresas
- Listado de empresas

#### ✅ Catálogo de Productos
- Crear productos
- Actualizar stock
- Consultar productos
- Productos por empresa
- Validación de existencia

#### ✅ Registro de Clientes
- Registro manual
- Auto-registro en compra
- Prevención de duplicados
- Estadísticas de compra
- Historial de compras

#### ✅ Carrito de Compras
- Añadir productos
- Remover productos
- Actualizar cantidades
- Calcular totales
- Limpiar carrito
- Validación de stock
- Validación de productos activos

#### ✅ Sistema de Facturas
- Crear facturas desde carrito
- Marcar como pagadas
- Consultar facturas
- Items de factura
- Facturas por cliente
- Validación de existencia

#### ✅ Gateway de Pagos
- Procesar pagos con EuroToken
- Validación de aprobaciones
- Validación de saldos
- Sistema de reembolsos
- Manejo de errores

#### ✅ EuroToken (ERC20)
- Minteo (solo owner)
- Transferencias
- Aprobaciones
- Quemado de tokens
- Validaciones de saldo
- Decimales (6)

## 🔒 Validaciones de Seguridad

Los tests verifican las siguientes validaciones:

- ✅ Permisos de owner (minteo, registro de empresas)
- ✅ Validación de stock disponible
- ✅ Validación de saldos de tokens
- ✅ Prevención de doble registro
- ✅ Validación de aprobaciones ERC20
- ✅ Validación de existencia de recursos
- ✅ Protección contra overflow/underflow
- ✅ Validación de direcciones

## 📈 Métricas

### Resumen de Tests
- **Total:** 50 tests
- **Pasados:** 50 ✅
- **Fallidos:** 0 ❌
- **Cobertura:** ~95% de funcionalidad crítica

### Gas Promedio
- Registro de empresa: ~227k gas
- Añadir producto: ~272k gas
- Añadir al carrito: ~136k gas
- Crear factura: ~413k gas
- Procesar pago: ~63k gas

## 🛠️ Estructura de Tests

Cada archivo de test sigue esta estructura:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/ContractName.sol";

contract ContractNameTest is Test {
    // Variables de estado
    ContractName public contract;
    address public owner;
    
    // Setup inicial
    function setUp() public {
        // Inicialización
    }
    
    // Tests individuales
    function testFeature() public {
        // Test implementation
    }
}
```

## 📚 Recursos

### Foundry Cheatcodes Usados
- `vm.prank(address)` - Simular llamadas desde una dirección
- `vm.startPrank(address)` / `vm.stopPrank()` - Múltiples llamadas
- `vm.expectRevert()` - Esperar que falle una transacción
- `assertEq()` - Comparación de valores
- `assertTrue()` / `assertFalse()` - Validaciones booleanas

### Documentación
- [Foundry Book](https://book.getfoundry.sh/)
- [Forge Testing](https://book.getfoundry.sh/forge/tests)
- [Cheatcodes Reference](https://book.getfoundry.sh/cheatcodes/)

## 🔄 CI/CD

Los tests se pueden integrar en CI/CD:

```yaml
# .github/workflows/test.yml
name: Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Install Foundry
        uses: foundry-rs/foundry-toolchain@v1
      - name: Run tests
        run: ./run-tests.sh
```

## 📄 Reportes

- **TEST_RESULTS.md** - Reporte completo de tests
- **test-results.txt** - Output raw de forge test
- **gas-report.txt** - Análisis detallado de gas

## 🤝 Contribuir

Para añadir nuevos tests:

1. Crea un nuevo archivo en `test/` con sufijo `.t.sol`
2. Importa `forge-std/Test.sol`
3. Sigue la estructura de tests existentes
4. Ejecuta `forge test` para verificar
5. Actualiza esta documentación

## ⚡ Tips

- Usa `forge test --watch` para re-ejecutar tests al guardar
- Usa `forge snapshot` para guardar benchmarks de gas
- Usa `forge coverage` para análisis de cobertura
- Usa `forge test --match-test <pattern>` para tests específicos

---

**Última actualización:** 19 de enero de 2026  
**Foundry Version:** forge 0.2.0  
**Solidity Version:** 0.8.20
