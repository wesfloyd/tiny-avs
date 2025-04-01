# Tiny AVS

<img src="assets/tinyavs.png" width="300"/>

Goals:
- Smallest possible AVS w/Middleware integration
- First AVS to slash Operator on Mainnet (eta April'ish).

Inspired by [tinygrad](https://github.com/tinygrad/tinygrad) / micrograd

## Prerequisites:

* [Foundry](https://book.getfoundry.sh/getting-started/installation)

## Local Devnet Deployment Instructions

**Window 1:** Start anvil
```bash
anvil
```

**Window 2:** Deploy contracts
```bash
cd contracts/
 forge script script/TinyAVS.s.sol:DeployTinyAVS --rpc-url http://localhost:8545 --broadcast --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

## Holesky Deployment Instructions
```bash
cd contracts/
cp .env.example .env
source .env
forge script script/TinyAVS.s.sol:DeployTinyAVS --rpc-url https://ethereum-holesky.publicnode.com --broadcast --private-key $HOLESKY_PRIVATE_KEY


# Parse the deployed contract address from the broadcast output
DEPLOYED_CONTRACT_ADDRESS=$(cat broadcast/TinyAVS.s.sol/17000/run-latest.json | jq -r '.transactions[0].contractAddress')
export DEPLOYED_CONTRACT_ADDRESS
echo "Deployed contract address: $DEPLOYED_CONTRACT_ADDRESS"

forge verify-contract \
    --chain-id 17000 \
    --watch \
    $DEPLOYED_CONTRACT_ADDRESS \
    src/TinyAVS.sol:TinyAVS \
    --etherscan-api-key $ETHERSCAN_API_KEY -v

# Register this AVS with AllocationManager
TESTNET_ALLOCATION_MANAGER_ADDRESS=0x78469728304326CBc65f8f95FA756B0B73164462

# First, create the JSON string (remove newlines and extra spaces)
METADATA_URI='{"name":"TinyAVS","website":"tooTinyForAURL","description":"Absolute smallest AVS possible","logo":"https://github.com/wesfloyd/tiny-avs/blob/main/assets/tinyavs.png?raw=true","twitter":"https://x.com/weswfloyd"}'

# URL encode the JSON string
ENCODED_METADATA=$(echo -n "$METADATA_URI" | jq -sRr @uri)

# Set AVS Metadata
cast send \
    --rpc-url https://ethereum-holesky.publicnode.com \
    --private-key $HOLESKY_PRIVATE_KEY \
    $TESTNET_ALLOCATION_MANAGER_ADDRESS \
    "updateAVSMetadataURI(address,string)" \
    $DEPLOYED_CONTRACT_ADDRESS \
    "$ENCODED_METADATA"

# todo get this working w/Eng


```




## Roadmap

* Add Operator registration script
* Add staker address generation, staking and delegation script
* Add slashing

