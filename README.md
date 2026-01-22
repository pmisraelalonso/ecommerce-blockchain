# E-Commerce Blockchain DAPP

Plataforma descentralizada de comercio electrónico construida sobre Ethereum con smart contracts y una interfaz web moderna.

## 🏗️ Arquitectura del Proyecto

```
ecommerce-blockchain/
├── sc-ecommerce/          # Smart Contracts del e-commerce
│   ├── src/               # Contratos Solidity
│   ├── test/              # Tests de contratos
│   └── script/            # Scripts de despliegue
├── stablecoin/            # Contrato EuroToken
│   └── src/               # EuroToken.sol
├── dapp/                  # Aplicación Web Descentralizada
│   ├── app/               # Páginas Next.js
│   │   ├── admin/         # Panel de administración
│   │   ├── shop/          # Tienda para clientes
│   │   └── shared/        # Componentes compartidos
│   ├── components/        # Componentes React
│   └── lib/               # Configuración Web3
└── scripts/               # Scripts de automatización
```

## 🚀 Inicio Rápido

### 1. Iniciar Todo el Sistema

```bash
bash start-dapp.sh
```

La DAPP estará disponible en: **http://localhost:3000**

### 2. Detener el Sistema

```bash
bash stop-dapp.sh
bash stop-anvil.sh
```

## 🎯 Funcionalidades

- 🛍️ **Tienda**: Catálogo, carrito, compras con EuroToken
- ⚙️ **Admin**: Gestión de empresas, productos, clientes y facturas
- 🔐 **Web3**: Conexión con MetaMask y wallets compatibles
- 💰 **Pagos**: Sistema de pagos con stablecoin EuroToken

## 🔧 Configuración de Wallet

**Red Anvil Local en MetaMask:**
- Nombre: Anvil Local
- RPC URL: http://127.0.0.1:8545
- Chain ID: 31337

Ver más detalles en `QUICKSTART.md`
