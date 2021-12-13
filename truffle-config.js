const HDWalletProvider = require('@truffle/hdwallet-provider')
require('dotenv').config()

// const mnemonic = process.env.MNEMONIC
// const url = process.env.RPC_URL
const mnemonic = 'enroll weasel lyrics knock invite trust twice sketch camp whisper attack actor'
const url = 'wss://kovan.infura.io/ws/v3/19458dcba6234c63a77f7843e4562eb5'

module.exports = {
  networks: {
    cldev: {
      host: '127.0.0.1',
      port: 8545,
      network_id: '*',
    },
    ganache: {
      host: '127.0.0.1',
      port: 7545,
      network_id: '*',
    },
    binance_testnet: {
      provider: () => new HDWalletProvider(mnemonic, 'https://data-seed-prebsc-1-s1.binance.org:8545'),
      network_id: 97,
      confirmations: 10,
      timeoutBlocks: 200,
      skipDryRun: true
    },
    kovan: {
      provider: () => {
        return new HDWalletProvider(mnemonic, url)
      },
      network_id: '42',
      skipDryRun: true
    },
    live: {
      provider: () => {
        return new HDWalletProvider(mnemonic, url)
      },
      network_id: '*'
    }
  },
  compilers: {
    solc: {
      version: '0.6.6',
    },
  },
}
