# Deployment

Deploying the **ForceTransfer Singleton** is a straightforward process using the pre-signed transaction method. Follow these steps to deploy the contract:

1. Navigate to the `scripts/broadcastRawTransaction.ts` file in the project.

2. Specify the RPC URL for the desired chain you want to deploy to.

3. Fund the deployer address with the required amount of native tokens. The deployer address is `0x100552c518F921A5F09Ca5533Ea521ce358B6C89`. Ensure this address has enough funds to cover the deployment gas costs.

4. Run the deployment script using Hardhat:

```bash
npx hardhat run scripts/broadcastRawTransaction.ts
```

5. The contract will be deployed, and you should see the transaction hash in the console output.

## Verification

After deployment, it is suggested to verify the contract source code on block explorers using either hardhat or foundry.
