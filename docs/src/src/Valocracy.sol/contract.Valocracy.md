# Valocracy
[Git Source](https://github.com/w3b3d3v/valocracy-contracts/blob/cc23733bef36f5764ced212bbe0dc6dc3badbf1c/src/Valocracy.sol)

**Inherits:**
ERC20Votes, Ownable, [SDG](/src/SDG.sol/abstract.SDG.md)

Implementation of the EIP-7787 Soulbound Degradable Governance standard using ERC20 tokens

*This contract extends ERC20Votes to implement non-transferable tokens with decaying voting power*


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


## Functions
### constructor

*Initializes the contract by setting a `name` and a `symbol`.
Sets default stable and decay periods to 90 days each.*


```solidity
constructor(string memory name, string memory symbol)
    ERC20(name, symbol)
    ERC20Votes()
    Ownable(msg.sender)
    EIP712(name, "1");
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|The name of the token|
|`symbol`|`string`|The symbol of the token|


### tokenURI

*Returns the token URI for a given token ID.*


```solidity
function tokenURI(uint256 tokenId) public view returns (string memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|The ID of the token|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|The token URI|


### _update

*Overrides the [ERC20Votes-_update](/lib/openzeppelin-contracts/contracts/mocks/token/ERC721ConsecutiveEnumerableMock.sol/contract.ERC721ConsecutiveEnumerableMock.md#_update) to make the token soulbound.
Only allows minting and burning, prevents transfers between accounts.*


```solidity
function _update(address from, address to, uint256 value) internal virtual override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`from`|`address`|The address sending the tokens|
|`to`|`address`|The address receiving the tokens|
|`value`|`uint256`|The amount of tokens|


### balanceOf

*Returns the balance of `account` with decay applied.
Implements the EIP-7787 decay mechanism:
- Full balance during stable period
- Linear decay during decay period
- Zero balance after decay period ends*


```solidity
function balanceOf(address account) public view override(ERC20, SDG) returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`account`|`address`|The address to check the balance for|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The current balance with decay applied|


### _getVotingUnits

*Returns the voting units for an account.*


```solidity
function _getVotingUnits(address account) internal view override returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`account`|`address`|The address to check voting units for|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The current voting units|


### grantVotingUnits

*Grants voting units to the specified account by `amount`.
Only the contract owner can mint new tokens and grant additional voting units.
Updates the last participation timestamp to start the stable period.*


```solidity
function grantVotingUnits(address to, uint256 amount) public onlyOwner;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`to`|`address`|The address to grant voting units to|
|`amount`|`uint256`|The amount of voting units to grant|


### burn

Burns tokens and reduces the voting units associated with the token holder.


```solidity
function burn(uint256 amount) public virtual;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`amount`|`uint256`|The amount of tokens to burn|


