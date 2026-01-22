'use client'

import Link from 'next/link'
import { useAccount } from 'wagmi'
import { WalletStatus } from '@/components/shared/WalletStatus'

export default function Home() {
  const { address, isConnected } = useAccount()

  return (
    <main className="container mx-auto px-4 py-12">
      <div className="max-w-6xl mx-auto">
        {/* Hero Section */}
        <div className="text-center mb-12">
          <h1 className="text-5xl font-bold mb-6 bg-gradient-to-r from-blue-600 to-purple-600 bg-clip-text text-transparent">
            E-Commerce Blockchain DAPP
          </h1>
          <p className="text-xl text-gray-600 mb-8">
            Plataforma descentralizada de comercio electrónico en blockchain
          </p>
        </div>

        {/* Wallet Status */}
        <div className="mb-12">
          <WalletStatus />
        </div>

        {/* Features Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-8 mb-12">
          {/* Shop Section */}
          <Link href="/shop" className="group">
            <div className="bg-white rounded-xl shadow-lg p-8 hover:shadow-xl transition-shadow border-2 border-transparent hover:border-blue-500">
              <div className="text-4xl mb-4">🛍️</div>
              <h2 className="text-2xl font-bold mb-3 group-hover:text-blue-600 transition-colors">
                Tienda
              </h2>
              <p className="text-gray-600 mb-4">
                Explora productos, gestiona tu carrito y realiza compras seguras con criptomonedas.
              </p>
              <ul className="space-y-2 text-sm text-gray-500">
                <li>✓ Catálogo de productos</li>
                <li>✓ Carrito de compras</li>
                <li>✓ Pagos con EuroToken</li>
                <li>✓ Facturación automática</li>
              </ul>
            </div>
          </Link>

          {/* Admin Section */}
          <Link href="/admin" className="group">
            <div className="bg-white rounded-xl shadow-lg p-8 hover:shadow-xl transition-shadow border-2 border-transparent hover:border-purple-500">
              <div className="text-4xl mb-4">⚙️</div>
              <h2 className="text-2xl font-bold mb-3 group-hover:text-purple-600 transition-colors">
                Administración
              </h2>
              <p className="text-gray-600 mb-4">
                Panel de gestión para empresas, productos, clientes y facturación.
              </p>
              <ul className="space-y-2 text-sm text-gray-500">
                <li>✓ Registro de empresas</li>
                <li>✓ Gestión de productos</li>
                <li>✓ Sistema de facturación</li>
                <li>✓ Reportes y análisis</li>
              </ul>
            </div>
          </Link>
        </div>

        {/* Info Cards */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div className="bg-white rounded-lg p-6 shadow">
            <h3 className="font-semibold text-lg mb-2">🔒 Seguro</h3>
            <p className="text-sm text-gray-600">
              Transacciones verificadas en blockchain con smart contracts auditados
            </p>
          </div>
          <div className="bg-white rounded-lg p-6 shadow">
            <h3 className="font-semibold text-lg mb-2">⚡ Rápido</h3>
            <p className="text-sm text-gray-600">
              Pagos instantáneos sin intermediarios ni comisiones bancarias
            </p>
          </div>
          <div className="bg-white rounded-lg p-6 shadow">
            <h3 className="font-semibold text-lg mb-2">🌐 Descentralizado</h3>
            <p className="text-sm text-gray-600">
              Sin punto único de fallo, datos inmutables y transparentes
            </p>
          </div>
        </div>

        {/* Connection Status */}
        {isConnected && (
          <div className="mt-12 bg-green-50 border border-green-200 rounded-lg p-6 text-center">
            <p className="text-green-800 font-medium mb-2">
              ✅ Wallet conectada exitosamente
            </p>
            <p className="text-sm text-green-600 font-mono">
              {address}
            </p>
          </div>
        )}
      </div>
    </main>
  )
}
