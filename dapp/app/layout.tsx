import './globals.css'
import type { Metadata } from 'next'
import { Providers } from './providers'
import { Navbar } from '@/components/shared/Navbar'

export const metadata: Metadata = {
  title: 'E-Commerce Blockchain DAPP',
  description: 'Decentralized E-Commerce Platform on Blockchain',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="es">
      <body>
        <Providers>
          <div className="min-h-screen bg-gray-50">
            <Navbar />
            {children}
          </div>
        </Providers>
      </body>
    </html>
  )
}
