'use client'

import { useAccount } from 'wagmi'
import Link from 'next/link'
import { useEffect, useState } from 'react'
import { WalletStatus } from '@/components/shared/WalletStatus'

export default function ShopPage() {
  const { isConnected } = useAccount()
  const [mounted, setMounted] = useState(false)

  useEffect(() => {
    setMounted(true)
  }, [])

  if (!mounted) {
    return (
      <div className="container mx-auto px-4 py-12">
        <div className="animate-pulse">
          <div className="h-10 bg-gray-200 rounded w-64 mb-8"></div>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            {[1, 2, 3].map((i) => (
              <div key={i} className="bg-gray-200 rounded-lg h-40"></div>
            ))}
          </div>
        </div>
      </div>
    )
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-4xl font-bold mb-8">🛍️ Tienda</h1>
      
      {/* Wallet Status */}
      <div className="mb-8">
        <WalletStatus />
      </div>

      {isConnected && (
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <Link href="/shop/products" className="bg-white rounded-lg shadow p-6 hover:shadow-lg transition-shadow">
          <div className="text-3xl mb-3">📦</div>
          <h2 className="text-xl font-semibold mb-2">Productos</h2>
          <p className="text-gray-600 text-sm">Explora el catálogo completo de productos disponibles</p>
        </Link>

        <Link href="/shop/cart" className="bg-white rounded-lg shadow p-6 hover:shadow-lg transition-shadow">
          <div className="text-3xl mb-3">🛒</div>
          <h2 className="text-xl font-semibold mb-2">Mi Carrito</h2>
          <p className="text-gray-600 text-sm">Revisa y gestiona los productos en tu carrito</p>
        </Link>

        <Link href="/shop/invoices" className="bg-white rounded-lg shadow p-6 hover:shadow-lg transition-shadow">
          <div className="text-3xl mb-3">📄</div>
          <h2 className="text-xl font-semibold mb-2">Mis Facturas</h2>
          <p className="text-gray-600 text-sm">Consulta el historial de tus compras</p>
        </Link>
      </div>
      )}
    </div>
  )
}
