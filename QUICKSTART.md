# 🚀 Quick Start - E-Commerce Blockchain DAPP

Guía para poner en marcha la DAPP completa en minutos.

## 📋 Prerequisitos

- **Node.js 18+** y npm
- **Foundry** (forge, anvil)
- **MetaMask** en el navegador

### Instalar Foundry
```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

## 🚀 Inicio con 1 Comando

```bash
bash start-dapp.sh
```

Este comando:
1. ✅ Inicia Anvil (si no está corriendo)
2. ✅ Despliega todos los smart contracts
3. ✅ Levanta la DAPP en http://localhost:3000

## 🔧 Configurar MetaMask

### 1. Agregar Red Anvil Local

En MetaMask → Configuración → Redes → Agregar Red:

- **Nombre de red:** Anvil Local
- **RPC URL:** http://127.0.0.1:8545
- **Chain ID:** 31337
- **Símbolo de moneda:** ETH

### 2. Importar Cuenta de Desarrollo

Importar cuenta con esta clave privada de Anvil:
```
0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

Esta cuenta tiene 10,000 ETH para pruebas.

## 🎯 Usar la DAPP

### Acceder a la Aplicación

Abre tu navegador en: **http://localhost:3000**

### Secciones Disponibles

- **🏠 Inicio:** Página principal
- **🛍️ Tienda** (`/shop`): Comprar productos
  - Ver productos
  - Agregar al carrito
  - Realizar compras
  - Ver facturas
- **⚙️ Admin** (`/admin`): Gestión empresarial
  - Registrar empresas
  - Crear productos
  - Ver clientes
  - Gestionar pagos

### Primer Uso

1. **Conectar Wallet:**
   - Click en "Connect Wallet" en la barra superior
   - Seleccionar MetaMask
   - Aprobar la conexión

2. **Registrar Empresa** (para vender):
   - Ir a Admin → Empresas
   - Completar formulario
   - Confirmar transacción

3. **Agregar Producto:**
   - Ir a Admin → Productos
   - Llenar datos del producto
   - Confirmar transacción

4. **Realizar Compra:**
   - Ir a Tienda → Productos
   - Agregar al carrito
   - Checkout y confirmar

## 🛑 Detener el Sistema

```bash
# Detener la DAPP
bash stop-dapp.sh

# Detener Anvil
bash stop-anvil.sh
```

## 📝 Comandos Útiles

### Iniciar Componentes por Separado

```bash
# Solo Anvil
bash start-anvil.sh

# Solo desplegar contratos
bash deploy-all.sh

# Solo DAPP (manual)
cd dapp
npm run dev
```

### Ver Direcciones de Contratos
```bash
cat DEPLOYED_CONTRACTS.md
```

### Ejecutar Tests
```bash
bash run-tests.sh
```

## ❓ Troubleshooting

### DAPP no conecta
- Verificar que Anvil esté corriendo
- Verificar MetaMask en la red correcta (Chain ID: 31337)
- Recargar la página

### Error al desplegar contratos
- Detener Anvil: `bash stop-anvil.sh`
- Reiniciar: `bash start-anvil.sh`
- Desplegar: `bash deploy-all.sh`

### Transacción rechazada
- Verificar saldo de ETH en MetaMask
- Resetear cuenta en MetaMask (Configuración → Avanzado → Reset Account)

## 📚 Más Información

- **README.md:** Documentación completa
- **TESTING.md:** Guía de testing
- **DEPLOYED_CONTRACTS.md:** Direcciones de contratos

---

¡Listo para usar tu DAPP de E-Commerce Blockchain! 🎉
