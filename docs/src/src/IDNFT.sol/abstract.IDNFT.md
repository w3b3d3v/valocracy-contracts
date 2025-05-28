# IDNFT
[Git Source](https://github.com/w3b3d3v/valocracy-contracts/blob/3c1bb3a5dbf1b0852bacbc7957066c674b876a74/src/IDNFT.sol)

**Inherits:**
[ERC7725](/src/math/ERC7725.sol/abstract.ERC7725.md)

**Author:**
0xneves

This contract provides a gamefied system for tracking account's progress and their respectful energy eficiency.
Character progress is known as the account's `Level` and energy as their `Mana`. Addresses health bar is their reputation
record, it's immortal and will always live on the blockchain but the Level can fluctuate deppending on the amount of Mana.
Level can be used to quantify that user's ability to change the world around them but Mana controls how much efficient
that Level is. On a spectrum, full Mana symbolizes 100% of the user Level but 0% Mana resets the user Level to 0.
Game Rules:
- Implementors should decide how their users gain new levels
- Mana is measured as unix timestamp and is considered full while: Mana + [stablePeriod](/src/IDNFT.sol/abstract.IDNFT.md#stableperiod) > block.timestamp
- Mana is replenished every time the user Level increases.
- Stable period and decreasing period resets to default every time the user Level increases.
- Decreasing period always start counting after stable period ends.
- Level lost by the lack of Mana cannot be replenished.

*Implementers of IDNFT should configure the desired mechanics or override with their own. The standard version deliver
the Level value, that can be used for decision making in the ecosystem and Mana for downgrading the Level based on the
user activity.
Requirements:
- The contract requires stable period and the decreasing period to function but their values can be override.
- The contract relies on ERC-7725 for exponential curve decay, but another logic can override the behaviour.*


## State Variables
### _accounts
Mapping from accounts addresses to their Level and Mana


```solidity
mapping(address => Character) private _accounts;
```


### _curvature
Curvature of the resulting decay value


```solidity
int16 private _curvature;
```


### _stablePeriod
Configuration of the active and inactive time of users


```solidity
uint32 private _stablePeriod;
```


### _decreasePeriod

```solidity
uint32 private _decreasePeriod;
```


## Functions
### curvature

*The curvature for calculating the Level decay.*


```solidity
function curvature() public view virtual returns (int16);
```

### stablePeriod

*Amount of time while the Mana is stable and won't be consumed.*


```solidity
function stablePeriod() public view virtual returns (uint32);
```

### decreasePeriod

*Amount of time it takes from Mana stability until its full depletion.*


```solidity
function decreasePeriod() public view virtual returns (uint32);
```

### accountStats

*Returns the raw `Character` settings of `account` with no adjustments.*


```solidity
function accountStats(address account) public view virtual returns (Character memory);
```

### levelOf

*Returns the Level of a given `account` adjusted for his current Mana.*


```solidity
function levelOf(address account) public view virtual returns (uint256);
```

### _increaseLevel

*Increases the current Level of `account` by `amount` and replenishes the Mana.*


```solidity
function _increaseLevel(address account, uint256 amount) internal virtual;
```

### _setCurvature

*Set a new curvature*


```solidity
function _setCurvature(int16 curvature_) internal virtual;
```

### _setStablePeriod

*Set a new stable period*


```solidity
function _setStablePeriod(uint32 stablePeriod_) internal virtual;
```

### _setdecreasePeriod

*Set a new decreasing period*


```solidity
function _setdecreasePeriod(uint32 decreasePeriod_) internal virtual;
```

### __unsafe_setLevelAndMana

*Unsafe write access to an account Character.
WARNING: Anyone calling this MUST ensure that the custom implementation matches the expected behaviour of the contract.*


```solidity
function __unsafe_setLevelAndMana(address account, uint256 amount, uint32 mana) internal;
```

## Structs
### Character
Character progress


```solidity
struct Character {
    uint256 level;
    uint32 mana;
}
```

