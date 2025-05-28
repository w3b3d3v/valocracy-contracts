# Valocracy

Valocracy is a governance model designed to replace plutocracy with a system that allocates influence based on contributions and merit rather than wealth. The core concept is that participants earn influence (voting power) in proportion to the value they create for the community. Influence is non-transferable, ensuring that governance reflects active contribution rather than token accumulation.

## Key Concepts

- **Valuation over Capital**: Voting power is tied to reputation or contribution scores, not tokens.
- **Soulbound Rights**: Influence is non-transferable and earned individually.
- **Multi-Stakeholder Alignment**: Designed to align the incentives of builders, users, and funders.
- **Transparent Contribution Records**: Contributions are logged and assessed by peers or through algorithms.
- **Decentralized Reputation System**: Participants build up their score through verifiable actions.

## Architecture Components

### 1. Contributor Registry (Soulbound Identity)

- Each participant has a non-transferable identity (e.g., NFT or soulbound token).
- Used to track all contributions and voting rights.
- [ ] Implement ERC20Votes as soulbound token and include NFT Metadata to be compatible with ERC721 Interface.
- [ ] Function getVotes() should return the number of votes the holder has.

### 2. Contribution Tracking Module

- [ ] Discuss and define how the mint process will work. Ownable/AcessControl/Gov/Multisig.
- [ ] Discuss the best way to track contributions. Considering the new changes to the ERC20Votes instead of cumulative NFTs.
- [ ] Shares are minted to the contributor's wallet address when they submit a contribution and get verified or we mint and they can claim it?

### 3. Valocracy Voting System

- Voting weight = Curve calculation based on decay.

### 4. Treasury and Share Management

- Treasury manages the economic power of the system through shares.
- Shares represent proportional ownership of the treasury's assets.
- Treasury has one underlying asset.
- [ ] Implement share price calculation mechanism
- [ ] Create emergency pause functionality