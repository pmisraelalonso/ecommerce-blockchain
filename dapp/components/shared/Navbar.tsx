'use client'

import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { ConnectButton } from '@rainbow-me/rainbowkit'
import { useAccount } from 'wagmi'

export function Navbar() {
  const pathname = usePathname()
  const { isConnected } = useAccount()
  
  const isAdmin = pathname?.startsWith('/admin')
  const isShop = pathname?.startsWith('/shop')

  return (
    <nav className="bg-white shadow-sm border-b sticky top-0 z-50">
      <div className="container mx-auto px-4">
        <div className="flex justify-between items-center h-16">
          {/* Logo */}
          <Link href="/" className="flex items-center space-x-2">
            <span className="text-2xl">🏪</span>
            <span className="text-xl font-bold bg-gradient-to-r from-blue-600 to-purple-600 bg-clip-text text-transparent">
              E-Commerce DAPP
            </span>
          </Link>

          {/* Navigation Links */}
          <div className="hidden md:flex items-center space-x-1">
            <Link 
              href="/shop" 
              className={`px-4 py-2 rounded-lg font-medium transition-colors ${
                isShop 
                  ? 'bg-blue-100 text-blue-700' 
                  : 'text-gray-700 hover:bg-gray-100'
              }`}
            >
              🛍️ Tienda
            </Link>
            <Link 
              href="/admin" 
              className={`px-4 py-2 rounded-lg font-medium transition-colors ${
                isAdmin 
                  ? 'bg-purple-100 text-purple-700' 
                  : 'text-gray-700 hover:bg-gray-100'
              }`}
            >
              ⚙️ Admin
            </Link>
          </div>

          {/* Connect Button */}
          <div className="flex items-center space-x-4">
            {isConnected && (
              <div className="hidden md:block">
                <span className="text-xs text-gray-500 px-3 py-1 bg-gray-100 rounded-full">
                  Chain ID: 31337
                </span>
              </div>
            )}
            <ConnectButton />
          </div>
        </div>
      </div>
    </nav>
  )
}
