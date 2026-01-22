'use client'

import { getDefaultConfig } from '@rainbow-me/rainbowkit'
import { http } from 'viem'
import { localhost } from 'viem/chains'

const anvilChain = {
  ...localhost,
  id: 31337,
  name: 'Anvil Local',
  nativeCurrency: {
    decimals: 18,
    name: 'Ether',
    symbol: 'ETH',
  },
  rpcUrls: {
    default: {
      http: ['http://127.0.0.1:8545'],
    },
    public: {
      http: ['http://127.0.0.1:8545'],
    },
  },
}

export const config = getDefaultConfig({
  appName: 'E-Commerce Blockchain DAPP',
  projectId: process.env.NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID || 'YOUR_PROJECT_ID',
  chains: [anvilChain],
  transports: {
    [anvilChain.id]: http('http://127.0.0.1:8545', {
      batch: false,
      retryCount: 3,
      timeout: 10000,
    }),
  },
  ssr: false,
})

export { anvilChain }
