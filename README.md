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

## Documentation and Coverage

- **Smart Contract Documentation**: Detailed documentation of our smart contracts can be found at [https://resources.valocracy.xyz/book/](https://resources.valocracy.xyz/book/)
- **Test Coverage**: View our test coverage reports at [https://resources.valocracy.xyz/coverage/](https://resources.valocracy.xyz/coverage/src/src)

## Learn More

For a deeper understanding of Valocracy's principles and vision, please read our [Manifesto](https://valocracy.xyz/en/read-the-manifesto).

## Contributing

Please see our [CONTRIBUTING.md](CONTRIBUTING.md) for details on how to contribute to this project.