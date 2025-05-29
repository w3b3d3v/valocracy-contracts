# Valocracy

Valocracy is a novel social, economic, and political framework that leverages blockchain technology to create new forms of organizations with the goal of empowering communities along with their individuals and their combined efforts. It aims to provide a structured approach to building more efficient and fair decentralized organizations.

## Core Principles

1. **Tokenized Effort**: Effort is tokenized through two distinct tokens:
   - **Governance Power**: Implemented as ERC20Votes with [Soulbound Degradable Governance (SDG)](https://eips.ethereum.org/EIPS/eip-7787) standard, ensuring voting power cannot be transferred and decays over time without active participation
   - **Economic Power**: Implemented as ERC20 with ERC4626 vault interface, representing shares of the underlying treasury asset

2. **Valueholder Concept**: Blurs the distinction between shareholders and laborers, allowing individuals to decide when to act as paid laborers or shareholders.

3. **Time-Based Governance**: Governance power follows a dynamic curve:
   - **Stable Period**: Initial period where governance power remains constant
   - **Decay Period**: Following the stable period, governance power gradually decreases over time
   - This mechanism ensures active participation while preventing governance attacks

## Smart Contracts

The project consists of several core smart contracts:

- **Valocracy.sol**: The main contract implementing ERC20Votes with SDG.
- **Treasury.sol**: Manages the collective treasury and economic power distribution using ERC20
- **SDG.sol**: Implements the [IERC7787](https://eips.ethereum.org/EIPS/eip-7787) for Soulbound Degradable Governance
- **Interfaces/**: Contains the core interfaces for the system


## Contributing

We welcome contributions from the community! Here's how you can get involved:

1. Join our Discord community at [discord.w3d.community](https://discord.w3d.community)
2. Fork the repository and create a new branch
3. Submit a pull request

## Learn More

For a deeper understanding of Valocracy's principles and vision, please read our [Manifesto](https://valocracy.xyz/en/read-the-manifesto).

---

## Getting Started

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
