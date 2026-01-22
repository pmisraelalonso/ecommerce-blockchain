'use client'

import { useAccount, useBalance, useDisconnect } from 'wagmi'
import { useEffect, useState } from 'react'
import { ConnectButton } from '@rainbow-me/rainbowkit'

export function WalletStatus() {
  const { address, isConnected, chain } = useAccount()
  const { data: balance } = useBalance({ address })
  const { disconnect } = useDisconnect()
  const [mounted, setMounted] = useState(false)

  useEffect(() => {
    setMounted(true)
  }, [])

  if (!mounted) {
    return (
      <div className="bg-white rounded-lg shadow p-6">
        <div className="animate-pulse">
          <div className="h-6 bg-gray-200 rounded w-48 mb-4"></div>
          <div className="h-4 bg-gray-200 rounded w-full"></div>
        </div>
      </div>
    )
  }

  if (!isConnected) {
    return (
      <div className="bg-gradient-to-r from-blue-50 to-purple-50 rounded-lg shadow-lg p-6 border-2 border-blue-200">
        <div className="flex items-start justify-between">
          <div className="flex-1">
            <div className="flex items-center mb-2">
              <span className="text-2xl mr-3">🔐</span>
              <h3 className="text-xl font-bold text-gray-800">Wallet no conectada</h3>
            </div>
            <p className="text-gray-600 mb-4">
              Conecta tu wallet para acceder a todas las funcionalidades de la DAPP
            </p>
            <div className="space-y-2 text-sm text-gray-600">
              <div className="flex items-center">
                <span className="mr-2">✓</span>
                <span>Comprar productos con EuroToken</span>
              </div>
              <div className="flex items-center">
                <span className="mr-2">✓</span>
                <span>Gestionar tu carrito de compras</span>
              </div>
              <div className="flex items-center">
                <span className="mr-2">✓</span>
                <span>Ver historial de transacciones</span>
              </div>
            </div>
          </div>
          <div className="ml-4">
            <ConnectButton />
          </div>
        </div>
      </div>
    )
  }

  return (
    <div className="bg-gradient-to-r from-green-50 to-emerald-50 rounded-lg shadow-lg p-6 border-2 border-green-200">
      <div className="flex items-start justify-between">
        <div className="flex-1">
          <div className="flex items-center mb-3">
            <span className="text-2xl mr-3">✅</span>
            <h3 className="text-xl font-bold text-gray-800">Wallet Conectada</h3>
          </div>
          
          <div className="space-y-3">
            <div className="bg-white rounded-lg p-3 shadow-sm">
              <div className="text-xs text-gray-500 mb-1">Dirección</div>
              <div className="font-mono text-sm text-gray-800 break-all">
                {address}
              </div>
            </div>

            {balance && (
              <div className="bg-white rounded-lg p-3 shadow-sm">
                <div className="text-xs text-gray-500 mb-1">Balance</div>
                <div className="font-semibold text-lg text-gray-800">
                  {Number(balance.formatted).toFixed(4)} {balance.symbol}
                </div>
              </div>
            )}

            {chain && (
              <div className="bg-white rounded-lg p-3 shadow-sm">
                <div className="text-xs text-gray-500 mb-1">Red</div>
                <div className="flex items-center justify-between">
                  <span className="font-semibold text-gray-800">{chain.name}</span>
                  <span className="text-xs bg-green-100 text-green-700 px-2 py-1 rounded-full">
                    Chain ID: {chain.id}
                  </span>
                </div>
              </div>
            )}
          </div>
        </div>
        
        <div className="ml-4">
          <ConnectButton />
        </div>
      </div>
    </div>
  )
}
