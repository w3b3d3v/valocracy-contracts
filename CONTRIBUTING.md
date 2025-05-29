# Contributing to Valocracy

We welcome contributions from the community! Here's how you can get involved:

1. Join our Discord community at [discord.w3d.community](https://discord.w3d.community)
2. Fork the repository and create a new branch
3. Submit a pull request

## Development Setup

### Prerequisites

- Foundry (see Foundry section below)

### Installation

```bash
# Clone the repository
git clone https://github.com/your-org/valocracy-contracts.git
cd valocracy-contracts

# Install dependencies
forge install
```

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

### Documentation

https://book.getfoundry.sh/

### Usage

#### Build
```shell
$ forge build
```

#### Test
```shell
$ forge test
```

#### Format
```shell
$ forge fmt
```

#### Gas Snapshots
```shell
$ forge snapshot
```

#### Anvil
```shell
$ anvil
```

#### Deploy
```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

#### Cast
```shell
$ cast <subcommand>
```

#### Help
```shell
$ forge --help
$ anvil --help
$ cast --help
``` 