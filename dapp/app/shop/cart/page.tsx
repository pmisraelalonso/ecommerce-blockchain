'use client'

import { useAccount } from 'wagmi'
import { useEffect, useState } from 'react'

export default function CartPage() {
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
          <div className="bg-gray-200 rounded-lg h-96"></div>
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
            Para acceder a tu carrito necesitas conectar tu wallet
          </p>
        </div>
      </div>
    )
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="mb-8">
        <h1 className="text-4xl font-bold mb-2">🛒 Mi Carrito</h1>
        <p className="text-gray-600">Revisa y gestiona los productos en tu carrito</p>
      </div>

      <div className="bg-white rounded-lg shadow p-6">
        <div className="text-center py-12 text-gray-500">
          <div className="text-6xl mb-4">🛒</div>
          <p className="text-lg font-medium">Tu carrito está vacío</p>
          <p className="text-sm mt-2">Agrega productos desde el catálogo</p>
        </div>
      </div>
    </div>
  )
}
