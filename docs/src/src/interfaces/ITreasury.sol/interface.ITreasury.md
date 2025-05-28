# ITreasury
[Git Source](https://github.com/w3b3d3v/valocracy-contracts/blob/3c1bb3a5dbf1b0852bacbc7957066c674b876a74/src/interfaces/ITreasury.sol)


## Functions
### asset

*Returns the address of the underlying token used for the Vault
for accounting, depositing, and withdrawing.*


```solidity
function asset() external view returns (address assetTokenAddress);
```

### totalAssets

*Returns the total amount of the underlying asset that is “managed”
by Vault.*


```solidity
function totalAssets() external view returns (uint256 totalManagedAssets);
```

### previewWithdraw

*Returns the amount of the underlying asset that would be returned
from withdrawing the given amount of shares.*


```solidity
function previewWithdraw(uint256 shares) external view returns (uint256 assets);
```

### deposit

*Deposits the given amount of shares into the Vault.*


```solidity
function deposit(address receiver, uint256 shares) external;
```

### withdraw

*Withdraws the given amount of shares from the Vault.*


```solidity
function withdraw(address receiver, uint256 shares) external;
```

## Events
### Deposit
*Emitted when a new deposit of shares is made.*


```solidity
event Deposit(address indexed receiver, uint256 shares);
```

### Withdraw
*Emitted when a withdrawal of shares is made.*


```solidity
event Withdraw(address indexed owner, address indexed receiver, uint256 assets, uint256 shares);
```

## Errors
### NotAuthorized
*Emitted when a non-authorized account attempts to call a function.*


```solidity
error NotAuthorized(address caller);
```

