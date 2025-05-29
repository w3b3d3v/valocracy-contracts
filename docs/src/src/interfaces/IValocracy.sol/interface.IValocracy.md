# IValocracy
[Git Source](https://github.com/w3b3d3v/valocracy-contracts/blob/264de7209f25edf5c05064dcd62712db60d4d460/src/interfaces/IValocracy.sol)


## Functions
### governor

*Return the Governor contract address.
The Governor contract must be provided by calling [setGovernor](/src/interfaces/IValocracy.sol/interface.IValocracy.md#setgovernor).
Otherwise {Governance-vote} will revert.*


```solidity
function governor() external view returns (address);
```

### treasury

*Return the Treasury contract address.
The Treasury contract must be provided by calling [setTreasury](/src/interfaces/IValocracy.sol/interface.IValocracy.md#settreasury).
Otherwise {Valocracy-mint} will revert.*


```solidity
function treasury() external view returns (address);
```

### totalSupply

*Return the total supply of NFTs in this contract.*


```solidity
function totalSupply() external view returns (uint256);
```

### mint

*Mints a new NFT.
The level will be set to the level of the sender plus the rarity of the
valor. If the account is on vacancy, the level will be set to the rarity
of the valor. The expiration will be set to the current timestamp plus
the vacancy period.
Requirements:
- `valorId` must exist.
- `expiration` must be in the future.
Emits a [Mint](/src/interfaces/IValocracy.sol/interface.IValocracy.md#mint) event.*


```solidity
function mint(address account, uint256 valorId) external;
```

### burn

*Burn the given token ID.
Requirements:
- `tokenId` must exist.
- `msg.sender` must be the owner of the token.
Emits a {Transfer} event to the Zero Address.*


```solidity
function burn(uint256 tokenId) external;
```

### setValor

*Create a new Valor for the protocol.
Valor is a NFT that represents governance power. Their characteristics
are its rarity and metadata. The rarity will determine the level of
governance power and the metadata will be for off-chain display.
Requirements:
- `msg.sender` must be the owner of the contract.
Emits a {NewValor} event.*


```solidity
function setValor(uint256 valorId, uint64 rarity, string memory metadata) external;
```

### setTreasury

*Set the Treasury contract address.
Requirements:
- `msg.sender` must be the owner of the contract.*


```solidity
function setTreasury(address treasury_) external;
```

### setGovernor

*Set the Governor contract address.
Requirements:
- `msg.sender` must be the owner of the contract.*


```solidity
function setGovernor(address governor_) external;
```

## Events
### Mint
*Emitted when a valor is updated or introduced.*


```solidity
event Mint(address indexed account, uint256 indexed valorId);
```

### ValorUpdate
*Emitted when a valor is updated or introduced.*


```solidity
event ValorUpdate(uint256 indexed valorId, uint256 rarity, string metadata);
```

### GovernorUpdate
*Emitted when the Governor contract address is updated.*


```solidity
event GovernorUpdate(address indexed governor);
```

### TreasuryUpdate
*Emitted when the treasury contract address is updated.*


```solidity
event TreasuryUpdate(address indexed treasury);
```

## Errors
### TokenSoulbound
*Emitted when a soulbound token is attemps to be transferred to
another account that is not the zero address.*


```solidity
error TokenSoulbound();
```

