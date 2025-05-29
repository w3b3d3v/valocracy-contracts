# ITreasury
[Git Source](https://github.com/w3b3d3v/valocracy-contracts/blob/8f30a41cc9c475ea6fc31243e7a7c57bf134b82e/src/interfaces/ITreasury.sol)


## Functions
### asset

*Returns the address of the single underlying asset token used by the treasury
for accounting, depositing, and withdrawing.*


```solidity
function asset() external view returns (address);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The address of the underlying asset token|


### totalAssets

*Returns the total amount of the single underlying asset that is managed by the treasury.*


```solidity
function totalAssets() external view returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The total amount of the underlying asset|


### previewWithdraw

*Calculates the amount of the underlying asset that would be returned
from burning the given amount of shares.*


```solidity
function previewWithdraw(uint256 shares) external view returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`shares`|`uint256`|The amount of shares to calculate assets for|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The amount of underlying asset that would be returned|


### deposit

*Deposits the underlying asset into the treasury and mints shares to the receiver.
Only callable by the Valocracy contract.*


```solidity
function deposit(address receiver, uint256 shares) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`receiver`|`address`|The address that will receive the shares|
|`shares`|`uint256`|The amount of shares to mint|


### withdraw

*Withdraws the underlying asset from the treasury by burning shares.
Transfers the corresponding amount of the underlying asset to the receiver.*


```solidity
function withdraw(address receiver, uint256 shares) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`receiver`|`address`|The address that will receive the underlying asset|
|`shares`|`uint256`|The amount of shares to burn|


## Events
### Deposit
*Emitted when a new deposit of the underlying asset is made.*


```solidity
event Deposit(address indexed receiver, uint256 shares);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`receiver`|`address`|The address that received the shares|
|`shares`|`uint256`|The amount of shares minted|

### Withdraw
*Emitted when a withdrawal of the underlying asset is made.*


```solidity
event Withdraw(address indexed owner, address indexed receiver, uint256 assets, uint256 shares);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`owner`|`address`|The address that burned the shares|
|`receiver`|`address`|The address that received the underlying asset|
|`assets`|`uint256`|The amount of underlying asset withdrawn|
|`shares`|`uint256`|The amount of shares burned|

## Errors
### NotAuthorized
*Emitted when a non-authorized account attempts to call a function.*


```solidity
error NotAuthorized(address caller);
```

