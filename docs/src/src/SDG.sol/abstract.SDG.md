# SDG
[Git Source](https://github.com/w3b3d3v/valocracy-contracts/blob/6795bd08475b218679f757729c7ba8112cd3b440/src/SDG.sol)

**Inherits:**
[IERC7787](/src/interfaces/IERC7787.sol/interface.IERC7787.md)

**Author:**
nomadbitcoin

This contract implements the EIP-7787 standard proposed by Guilherme Neves (@0xneves) and Rafael Castaneda
for governance systems where voting power is non-transferable and decays over time.
The system ensures that governance power reflects recent and active participation in the ecosystem by implementing a two-phase decay mechanism:
1. Stable Period: Voting power remains constant for a fixed duration after each contribution
2. Decay Period: After the stable period ends, voting power linearly decays until it reaches zero
System Rules:
- Voting power remains stable for the duration of the stable period after each contribution
- After the stable period ends, voting power linearly decays over the decay period
- If no new contributions are made during the decay period, voting power reaches zero
- New contributions reset both the stable and decay periods
- Lost voting power cannot be recovered without new contributions

*This implementation follows the EIP-7787 specification but uses 'stablePeriod' instead of 'gracePeriod' for clarity.
The contract provides the core functionality for calculating voting power with time-based degradation.
Requirements:
- The contract requires stable period and decay period to be configured
- The contract implements linear decay as specified in EIP-7787*


## State Variables
### SECONDS_PER_DAY
*Number of seconds in a day*


```solidity
uint32 private constant SECONDS_PER_DAY = 86400;
```


### _lastParticipation
*Mapping from accounts addresses to their last participation timestamp*


```solidity
mapping(address => uint32) private _lastParticipation;
```


### _stablePeriod
*Configuration of the stable and decay periods (in days)*


```solidity
uint32 private _stablePeriod;
```


### _decayPeriod

```solidity
uint32 private _decayPeriod;
```


## Functions
### stablePeriod

*Returns the duration of the stable period in days.*


```solidity
function stablePeriod() public view virtual returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The duration of the stable period in days.|


### decayPeriod

*Returns the duration of the decay period in days.*


```solidity
function decayPeriod() public view virtual returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The duration of the decay period in days.|


### accountStats

*Returns the raw last participation timestamp of an account without any decay adjustments.*


```solidity
function accountStats(address account) public view virtual returns (uint32);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`account`|`address`|The address to check for last participation|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint32`|The timestamp of the last participation|


### _updateLastParticipation

*Updates the last participation timestamp for an account.*


```solidity
function _updateLastParticipation(address account) internal virtual;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`account`|`address`|The address to update the participation timestamp for|


### _setStablePeriod

*Sets a new stable period in days*


```solidity
function _setStablePeriod(uint32 stablePeriod_) internal virtual;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`stablePeriod_`|`uint32`|The new stable period duration in days|


### _setDecayPeriod

*Sets a new decay period in days*


```solidity
function _setDecayPeriod(uint32 decayPeriod_) internal virtual;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`decayPeriod_`|`uint32`|The new decay period duration in days|


### balanceOf

*Returns the balance of the account with decay applied.*


```solidity
function balanceOf(address account) public view virtual returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`account`|`address`|The address to check the balance for|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The current balance with decay applied|


