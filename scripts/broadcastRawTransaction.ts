import { ethers } from 'ethers';
import { FORCE_TRANSFER_SINGLETON_CONFIG } from '../constants';

/**
 * @notice Main function to broadcast the ForceTransfer contract deployment transaction
 * @dev Reads the configuration from constants.js and broadcasts the transaction
 * @return {Promise<void>}
 */
async function main(): Promise<void> {
  try {
    const provider = new ethers.JsonRpcProvider('rpc');

    console.log('Broadcasting transaction...');
    const tx = await provider.broadcastTransaction(FORCE_TRANSFER_SINGLETON_CONFIG.rawTx);
    console.log('Deployment Transaction Hash:', tx.hash);

    console.log('Waiting for transaction confirmation...');
    await tx.wait();
    console.log('Transaction confirmed:', tx.hash);
  } catch (error) {
    console.error('Error occurred:', error);
    process.exit(1);
  }
}

// Execute the main function
main();
