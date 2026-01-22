# Contratos Desplegados

**Última actualización:** $(date)

## Red Local (Anvil)
- **Chain ID**: 31337
- **RPC URL**: http://localhost:8545

## Direcciones de los Contratos

### Stablecoin
- **EuroToken**: `0x5FbDB2315678afecb367f032d93F642f64180aa3`

### Sistema E-Commerce
- **EcommerceMain**: `0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512`
- **CompanyRegistry**: `0xCafac3dD18aC6c6e92c921884f9E4176737C052c`
- **ProductCatalog**: `0x9f1ac54BEF0DD2f6f3462EA0fa94fC62300d3a8e`
- **CustomerRegistry**: `0xbf9fBFf01664500A33080Da5d437028b07DFcC55`
- **ShoppingCart**: `0x93b6BDa6a0813D808d75aA42e900664Ceb868bcF`
- **InvoiceSystem**: `0xA22D78bc37cE77FeE1c44F0C2C0d2524318570c3`
- **PaymentGateway**: `0x0ed2E86FcE2e5A7965f59708c01f88a722BC7f07`

## Cuentas de Prueba

### Cuenta Principal (Deployer)
- **Dirección**: `0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266`
- **Private Key**: `0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80`
- **Balance**: 10,000 ETH

### Cuentas Adicionales
1. `0x70997970C51812dc3A010C7d01b50e0d17dc79C8` (10,000 ETH)
2. `0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC` (10,000 ETH)
3. `0x90F79bf6EB2c4f870365E785982E1f101E93b906` (10,000 ETH)
4. `0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65` (10,000 ETH)
5. `0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc` (10,000 ETH)
6. `0x976EA74026E726554dB657fA54763abd0C3a0aa9` (10,000 ETH)
7. `0x14dC79964da2C08b23698B3D3cc7Ca32193d9955` (10,000 ETH)
8. `0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f` (10,000 ETH)
9. `0xa0Ee7A142d267C1f36714E4a8F75612F20a79720` (10,000 ETH)

## Estado del Despliegue
- ✅ Contratos desplegados exitosamente
- ✅ Red blockchain local activa (Anvil en PID: verificar con `ps aux | grep anvil`)
- ✅ Todas las dependencias instaladas

## Gestión de Anvil

```bash
# Ver estado de Anvil
ps aux | grep anvil

# Ver logs de Anvil
tail -f /tmp/anvil.log

# Detener Anvil
./stop-anvil.sh

# Iniciar Anvil
./start-anvil.sh

# Redesplegar todo
./full-deploy.sh
```

## Próximos Pasos

1. **Configurar las aplicaciones web** con las direcciones de los contratos
2. **Iniciar web-admin**: Para gestión de empresas y productos
   ```bash
   cd web-admin
   npm install
   npm run dev
   ```
3. **Iniciar web-customer**: Para compras de clientes
   ```bash
   cd web-customer
   npm install
   npm run dev
   ```

## Comandos Útiles

```bash
# Verificar código de un contrato
cast code 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 --rpc-url http://localhost:8545

# Ver balance de cuenta
cast balance 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 --rpc-url http://localhost:8545

# Ver número de bloque
cast block-number --rpc-url http://localhost:8545
```

## Notas Importantes
- ⚠️ **Persistencia**: Los datos NO persisten cuando se detiene Anvil. Cada vez que reinicias Anvil, debes redesplegar.
- 🔒 **Seguridad**: Las claves privadas mostradas son SOLO para desarrollo local. NUNCA las uses en producción.
- 🌐 **Producción**: Para desplegar en testnet o mainnet, modifica los scripts con las RPC URLs y claves apropiadas.
