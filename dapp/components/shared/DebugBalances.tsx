'use client'

import { useAccount, useBalance, useReadContract, useBlockNumber } from 'wagmi'
import { formatEther, formatUnits } from 'viem'
import { CONTRACTS } from '@/lib/contracts/addresses'
import { useEffect, useState } from 'react'

// ERC20 ABI mínimo para balanceOf
const ERC20_ABI = [
  {
    inputs: [{ name: 'account', type: 'address' }],
    name: 'balanceOf',
    outputs: [{ name: '', type: 'uint256' }],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [],
    name: 'decimals',
    outputs: [{ name: '', type: 'uint8' }],
    stateMutability: 'view',
    type: 'function',
  },
] as const

// Cuentas de Anvil por defecto
const ANVIL_ACCOUNTS = [
  '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266',
  '0x70997970C51812dc3A010C7d01b50e0d17dc79C8',
  '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC',
  '0x90F79bf6EB2c4f870365E785982E1f101E93b906',
  '0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65',
]

function AccountBalance({ address, index }: { address: string; index: number }) {
  const { data: ethBalance } = useBalance({
    address: address as `0x${string}`,
  })

  const { data: euroBalance, refetch: refetchEuro } = useReadContract({
    address: CONTRACTS.EURO_TOKEN,
    abi: ERC20_ABI,
    functionName: 'balanceOf',
    args: [address as `0x${string}`],
  })

  const { data: blockNumber } = useBlockNumber({ watch: true })

  useEffect(() => {
    refetchEuro()
  }, [blockNumber, refetchEuro])

  return (
    <div className="bg-gradient-to-br from-slate-50 to-slate-100 rounded-lg p-4 border border-slate-200 hover:shadow-md transition-shadow">
      <div className="flex items-center justify-between mb-3">
        <div className="flex items-center gap-2">
          <div className={`w-8 h-8 rounded-full flex items-center justify-center text-white font-bold text-sm ${
            index === 0 ? 'bg-blue-500' : 
            index === 1 ? 'bg-green-500' : 
            index === 2 ? 'bg-purple-500' : 
            index === 3 ? 'bg-orange-500' : 'bg-pink-500'
          }`}>
            #{index + 1}
          </div>
          <div>
            <p className="text-xs text-gray-500 font-mono">
              {address.slice(0, 6)}...{address.slice(-4)}
            </p>
          </div>
        </div>
      </div>
      
      <div className="space-y-2">
        <div className="flex justify-between items-center">
          <span className="text-sm font-medium text-gray-600">ETH:</span>
          <span className="text-sm font-bold text-gray-900">
            {ethBalance ? parseFloat(formatEther(ethBalance.value)).toFixed(4) : '0.0000'}
          </span>
        </div>
        
        <div className="flex justify-between items-center">
          <span className="text-sm font-medium text-gray-600">EURT:</span>
          <span className="text-sm font-bold text-blue-600">
            {euroBalance ? parseFloat(formatUnits(euroBalance as bigint, 6)).toFixed(2) : '0.00'}
          </span>
        </div>
      </div>
    </div>
  )
}

export function DebugBalances() {
  const { address: connectedAddress } = useAccount()
  const [isExpanded, setIsExpanded] = useState(false)

  return (
    <div className="fixed bottom-4 right-4 z-50">
      <div className={`bg-white rounded-xl shadow-2xl border-2 border-slate-200 transition-all duration-300 ${
        isExpanded ? 'w-96' : 'w-auto'
      }`}>
        {/* Header */}
        <button
          onClick={() => setIsExpanded(!isExpanded)}
          className="w-full px-4 py-3 flex items-center justify-between bg-gradient-to-r from-slate-700 to-slate-800 text-white rounded-t-xl hover:from-slate-800 hover:to-slate-900 transition-colors"
        >
          <div className="flex items-center gap-2">
            <span className="text-lg">🔍</span>
            <span className="font-bold text-sm">Debug Balances</span>
          </div>
          <span className="text-xs">
            {isExpanded ? '▼' : '▶'}
          </span>
        </button>

        {/* Content */}
        {isExpanded && (
          <div className="p-4 max-h-[70vh] overflow-y-auto">
            {/* Connected Account */}
            {connectedAddress && (
              <div className="mb-4 pb-4 border-b-2 border-slate-200">
                <div className="flex items-center gap-2 mb-3">
                  <span className="text-xs font-bold text-green-600 bg-green-50 px-2 py-1 rounded">
                    CONECTADA
                  </span>
                </div>
                <AccountBalance
                  address={connectedAddress}
                  index={ANVIL_ACCOUNTS.indexOf(connectedAddress) !== -1 
                    ? ANVIL_ACCOUNTS.indexOf(connectedAddress) 
                    : 0
                  }
                />
              </div>
            )}

            {/* All Anvil Accounts */}
            <div>
              <h3 className="text-xs font-bold text-gray-500 uppercase mb-3 flex items-center gap-2">
                <span>⚙️</span>
                Cuentas Anvil
              </h3>
              <div className="grid grid-cols-1 gap-3">
                {ANVIL_ACCOUNTS.map((address, index) => (
                  <AccountBalance key={address} address={address} index={index} />
                ))}
              </div>
            </div>

            {/* Contracts Info */}
            <div className="mt-4 pt-4 border-t border-slate-200">
              <h3 className="text-xs font-bold text-gray-500 uppercase mb-2">Contratos</h3>
              <div className="space-y-1 text-xs font-mono">
                <div className="text-gray-600">
                  <span className="font-bold">EuroToken:</span> {CONTRACTS.EURO_TOKEN?.slice(0, 10)}...
                </div>
                <div className="text-gray-600">
                  <span className="font-bold">Main:</span> {CONTRACTS.ECOMMERCE_MAIN?.slice(0, 10)}...
                </div>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}
