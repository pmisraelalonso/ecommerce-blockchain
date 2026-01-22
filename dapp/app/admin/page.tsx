'use client'

import { useAccount } from 'wagmi'
import Link from 'next/link'
import { useEffect, useState } from 'react'
import { WalletStatus } from '@/components/shared/WalletStatus'

export default function AdminPage() {
  const { isConnected } = useAccount()
  const [mounted, setMounted] = useState(false)

  useEffect(() => {
    setMounted(true)
  }, [])

  if (!mounted) {
    return (
      <div className="container mx-auto px-4 py-12">
        <div className="animate-pulse">
          <div className="h-10 bg-gray-200 rounded w-96 mb-8"></div>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {[1, 2, 3, 4, 5, 6].map((i) => (
              <div key={i} className="bg-gray-200 rounded-lg h-40"></div>
            ))}
          </div>
        </div>
      </div>
    )
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-4xl font-bold mb-8">⚙️ Panel de Administración</h1>
      
      {/* Wallet Status */}
      <div className="mb-8">
        <WalletStatus />
      </div>

      {isConnected && (
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <Link href="/admin/companies" className="bg-white rounded-lg shadow p-6 hover:shadow-lg transition-shadow">
          <div className="text-3xl mb-3">🏢</div>
          <h2 className="text-xl font-semibold mb-2">Empresas</h2>
          <p className="text-gray-600 text-sm">Gestiona el registro de empresas vendedoras</p>
        </Link>

        <Link href="/admin/products" className="bg-white rounded-lg shadow p-6 hover:shadow-lg transition-shadow">
          <div className="text-3xl mb-3">📦</div>
          <h2 className="text-xl font-semibold mb-2">Productos</h2>
          <p className="text-gray-600 text-sm">Administra el catálogo de productos</p>
        </Link>

        <Link href="/admin/customers" className="bg-white rounded-lg shadow p-6 hover:shadow-lg transition-shadow">
          <div className="text-3xl mb-3">👥</div>
          <h2 className="text-xl font-semibold mb-2">Clientes</h2>
          <p className="text-gray-600 text-sm">Consulta clientes registrados</p>
        </Link>

        <Link href="/admin/invoices" className="bg-white rounded-lg shadow p-6 hover:shadow-lg transition-shadow">
          <div className="text-3xl mb-3">📄</div>
          <h2 className="text-xl font-semibold mb-2">Facturas</h2>
          <p className="text-gray-600 text-sm">Revisa todas las transacciones</p>
        </Link>

        <Link href="/admin/payments" className="bg-white rounded-lg shadow p-6 hover:shadow-lg transition-shadow">
          <div className="text-3xl mb-3">💰</div>
          <h2 className="text-xl font-semibold mb-2">Pagos</h2>
          <p className="text-gray-600 text-sm">Gestiona el gateway de pagos</p>
        </Link>

        <Link href="/admin/tokens" className="bg-white rounded-lg shadow p-6 hover:shadow-lg transition-shadow">
          <div className="text-3xl mb-3">🪙</div>
          <h2 className="text-xl font-semibold mb-2">EuroToken</h2>
          <p className="text-gray-600 text-sm">Gestión de la stablecoin</p>
        </Link>
      </div>
      )}
    </div>
  )
}
