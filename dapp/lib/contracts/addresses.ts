// Contract addresses from environment variables
export const CONTRACTS = {
  ECOMMERCE_MAIN: process.env.NEXT_PUBLIC_ECOMMERCE_MAIN_ADDRESS as `0x${string}`,
  EURO_TOKEN: process.env.NEXT_PUBLIC_EURO_TOKEN_ADDRESS as `0x${string}`,
  COMPANY_REGISTRY: process.env.NEXT_PUBLIC_COMPANY_REGISTRY_ADDRESS as `0x${string}`,
  PRODUCT_CATALOG: process.env.NEXT_PUBLIC_PRODUCT_CATALOG_ADDRESS as `0x${string}`,
  CUSTOMER_REGISTRY: process.env.NEXT_PUBLIC_CUSTOMER_REGISTRY_ADDRESS as `0x${string}`,
  SHOPPING_CART: process.env.NEXT_PUBLIC_SHOPPING_CART_ADDRESS as `0x${string}`,
  INVOICE_SYSTEM: process.env.NEXT_PUBLIC_INVOICE_SYSTEM_ADDRESS as `0x${string}`,
  PAYMENT_GATEWAY: process.env.NEXT_PUBLIC_PAYMENT_GATEWAY_ADDRESS as `0x${string}`,
}

export const CHAIN_ID = Number(process.env.NEXT_PUBLIC_CHAIN_ID) || 31337
export const RPC_URL = process.env.NEXT_PUBLIC_RPC_URL || 'http://127.0.0.1:8545'
