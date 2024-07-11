import fs from 'fs';
import path from 'path';
import { genRawDeployment } from '@patronumlabs/nick-method';
import { bytecode } from '../artifacts/contracts/ForceTransfer.sol/ForceTransfer.json';

/**
 * @notice Generates and writes the raw deployment configuration for the ForceTransfer contract
 * @dev This function uses the nick-method to generate deployment data and writes it to a constants file
 * @return {Promise<Object>} The deployment result object
 */
async function createAndWriteRawDeployment(): Promise<object> {
  try {
    const config = {
      gasLimit: 1000000,
      gasPrice: 100000000000,
      bytecode: bytecode,
      value: 0,
    };

    const deploymentResult = genRawDeployment(config);

    const constantsPath = path.join(__dirname, '..', 'constants.js');

    const content = `/**
 * @notice Configuration and raw Transaction for the ForceTransfer Singleton
 */
const FORCE_TRANSFER_SINGLETON_CONFIG = {
    gasLimit: ${config.gasLimit},
    gasPrice: ${config.gasPrice},
    bytecode: '${config.bytecode}',
    value: ${config.value},
    rawTx: '${deploymentResult.rawTx}',
    deployerAddress: '${deploymentResult.deployerAddress}',
    contractAddress: '${deploymentResult.contractAddress}',
    r: '${deploymentResult.r}',
    s: '${deploymentResult.s}',
    v: ${deploymentResult.v},
    upfrontCost: '${deploymentResult.upfrontCost}',
};

module.exports = {
    FORCE_TRANSFER_SINGLETON_CONFIG,
};
`;

    await fs.promises.writeFile(constantsPath, content, 'utf8');
    console.log(`Deployment result written to ${constantsPath}`);

    return deploymentResult;
  } catch (error) {
    console.error('Error in createAndWriteRawDeployment:', error);
    throw error;
  }
}

createAndWriteRawDeployment();
