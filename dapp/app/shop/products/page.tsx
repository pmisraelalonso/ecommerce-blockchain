'use client'

import { useAccount } from 'wagmi'
import { useEffect, useState } from 'react'

export default function ProductsShopPage() {
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
            {[1, 2, 3, 4, 5, 6].map((i) => (
              <div key={i} className="bg-gray-200 rounded-lg h-80"></div>
            ))}
          </div>
        </div>
      </div>
    )
  }

  if (!isConnected) {
    return (
      <div className="container mx-auto px-4 py-12">
        <div className="max-w-2xl mx-auto text-center">
          <div className="text-6xl mb-6">🔐</div>
          <h1 className="text-3xl font-bold mb-4">Conecta tu Wallet</h1>
          <p className="text-gray-600 mb-6">
            Para ver productos necesitas conectar tu wallet
          </p>
        </div>
      </div>
    )
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="mb-8">
        <h1 className="text-4xl font-bold mb-2">📦 Catálogo de Productos</h1>
        <p className="text-gray-600">Explora los productos disponibles</p>
      </div>

      <div className="bg-white rounded-lg shadow p-6">
        <div className="text-center py-12 text-gray-500">
          <div className="text-6xl mb-4">🛒</div>
          <p className="text-lg font-medium">No hay productos disponibles</p>
          <p className="text-sm mt-2">Los productos aparecerán aquí cuando las empresas los agreguen</p>
        </div>
      </div>
    </div>
  )
}
