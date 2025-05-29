# Treasury
[Git Source](https://github.com/w3b3d3v/valocracy-contracts/blob/8f30a41cc9c475ea6fc31243e7a7c57bf134b82e/src/Treasury.sol)

**Inherits:**
ERC20, [ITreasury](/src/interfaces/ITreasury.sol/interface.ITreasury.md)

Implementation of a single-asset treasury that manages deposits and withdrawals

*This contract extends ERC20 to implement a treasury system for a single underlying asset*


## State Variables
### _asset
*The single underlying asset token managed by this treasury*


```solidity
IERC20 private immutable _asset;
```


### _valocracy
*The Valocracy contract address that controls deposits*


```solidity
address private _valocracy;
```


## Functions
### constructor

*Initializes the contract by setting a `name` and a `symbol`
for the treasury shares. Also sets the Valocracy contract and the
single underlying asset token.*


```solidity
constructor(IERC20 asset_, address valocracy, string memory name, string memory symbol) ERC20(name, symbol);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`asset_`|`IERC20`|The single underlying asset token to be managed|
|`valocracy`|`address`|The address of the Valocracy contract that controls deposits|
|`name`|`string`|The name of the treasury shares|
|`symbol`|`string`|The symbol of the treasury shares|


### asset

*Returns the address of the single underlying asset token.*


```solidity
function asset() public view virtual returns (address);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The address of the asset token|


### totalAssets

*Returns the total amount of the single asset held by the treasury.*


```solidity
function totalAssets() public view virtual returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The total balance of the underlying asset|


### previewWithdraw

*Calculates the amount of the underlying asset that would be returned for burning the given amount of shares.
The calculation is based on the proportion of total assets to total shares.
For example, if there are 2000 assets and 1000 shares, each share represents 2 assets.*


```solidity
function previewWithdraw(uint256 shares) public view virtual returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`shares`|`uint256`|The amount of shares to calculate assets for|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The amount of the underlying asset that would be returned|


### deposit

*Deposits the underlying asset into the treasury and mints shares to the receiver.
Only callable by the Valocracy contract.*


```solidity
function deposit(address receiver, uint256 shares) public;
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
function withdraw(address receiver, uint256 shares) public;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`receiver`|`address`|The address that will receive the underlying asset|
|`shares`|`uint256`|The amount of shares to burn|


