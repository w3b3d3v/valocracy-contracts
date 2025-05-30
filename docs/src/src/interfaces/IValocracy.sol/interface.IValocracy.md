# IValocracy
[Git Source](https://github.com/w3b3d3v/valocracy-contracts/blob/fce5a03f1cbd831476693115e6be83e2d3ede859/src/interfaces/IValocracy.sol)


## Functions
### balanceOf

*Returns the balance of an account with decay applied.
Implements the EIP-7787 decay mechanism:
- Full balance during stable period
- Linear decay during decay period
- Zero balance after decay period ends*


```solidity
function balanceOf(address account) external view returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`account`|`address`|The address to check the balance for|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The current balance with decay applied|


### stablePeriod

*Returns the stable period duration in seconds.*


```solidity
function stablePeriod() external view returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The stable period duration|


### decayPeriod

*Returns the decay period duration in seconds.*


```solidity
function decayPeriod() external view returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The decay period duration|


### grantVotingUnits

*Grants voting units to the specified account.
Only the contract owner can mint new tokens and grant additional voting units.
Updates the last participation timestamp to start the stable period.*


```solidity
function grantVotingUnits(address to, uint256 amount) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`to`|`address`|The address to grant voting units to|
|`amount`|`uint256`|The amount of voting units to grant|


### burn

*Burns tokens and reduces the voting units associated with the token holder.*


```solidity
function burn(uint256 amount) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`amount`|`uint256`|The amount of tokens to burn|


## Events
### VotingUnitsGranted
*Emitted when voting units are granted to an account.*


```solidity
event VotingUnitsGranted(address indexed account, uint256 amount);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`account`|`address`|The address that received the voting units|
|`amount`|`uint256`|The amount of voting units granted|

### VotingUnitsBurned
*Emitted when voting units are burned.*


```solidity
event VotingUnitsBurned(address indexed account, uint256 amount);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`account`|`address`|The address that burned the voting units|
|`amount`|`uint256`|The amount of voting units burned|

## Errors
### TokenSoulbound
*Emitted when attempting to transfer a soulbound token.*


```solidity
error TokenSoulbound();
```

