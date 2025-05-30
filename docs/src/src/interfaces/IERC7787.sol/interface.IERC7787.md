# IERC7787
[Git Source](https://github.com/w3b3d3v/valocracy-contracts/blob/6795bd08475b218679f757729c7ba8112cd3b440/src/interfaces/IERC7787.sol)


## Functions
### stablePeriod

*Returns the grace period duration before the voting units begins decaying. This period is
fixed to 90 days. But it can be overridden in derived contracts.*


```solidity
function stablePeriod() external view returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The duration of the grace period in seconds.|


### decayPeriod

*Returns the duration of the decay period during which the voting units decreases. This
period is fixed to 90 days. But it can be overridden in derived contracts.*


```solidity
function decayPeriod() external view returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The duration of the decay period in seconds.|


### accountStats

*Returns the raw last participation timestamp of an account without any decay adjustments.*


```solidity
function accountStats(address account) external view returns (uint32);
```

## Errors
### TokenSoulbound
*Error thrown when attempting to transfer a soulbound token*


```solidity
error TokenSoulbound();
```

