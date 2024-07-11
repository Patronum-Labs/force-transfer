import { HardhatUserConfig } from 'hardhat/config';
import '@nomicfoundation/hardhat-toolbox';
import '@nomicfoundation/hardhat-foundry';

const config: HardhatUserConfig = {
  solidity: {
    version: '0.8.20',
    settings: {
      optimizer: {
        enabled: true,
        runs: 10_000_000,
      },
      evmVersion: 'paris', // Prevent using the `PUSH0` opcode
      viaIR: false,
      metadata: {
        bytecodeHash: 'none', // Remove the metadata hash from the bytecode
      },
    },
  },
};

export default config;
