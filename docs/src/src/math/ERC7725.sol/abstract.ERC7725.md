# ERC7725
**Inherits:**
[IERC7725](/src/math/IERC7725.sol/interface.IERC7725.md)

**Author:**
0xneves

This smart contract implements an advanced exponential curve formula designed to
handle various time-based events such as token vesting, game mechanics, unlock schedules,
and other timestamp-dependent actions. The core functionality is driven by an exponential
curve formula that allows for smooth, nonlinear transitions over time, providing a more
sophisticated and flexible approach compared to linear models.


## Functions
### expcurve

*See [IEXPCurves-expcurve](/src/math/IERC7725.sol/interface.IERC7725.md#expcurve).*


```solidity
function expcurve(
    uint32 currentTimeframe,
    uint32 initialTimeframe,
    uint32 finalTimeframe,
    int16 curvature,
    bool ascending
) public pure virtual returns (int256);
```

## Errors
### EXPCurveInvalidInitialTimeframe
The initial timeframe is invalid.
Requirements:
- Must be less than or equal to the current timestamp
- Must be less than the final timestamp.


```solidity
error EXPCurveInvalidInitialTimeframe();
```

### EXPCurveInvalidCurvature
The curvature factor is invalid.
Requirements:
- It cannot be zero
- The curvature cannot be bigger than 10000 or smaller than -10000 (2 decimals precision)
NOTE: Cannot be bigger than type uint of value 133 while using regular unix timestamps.
For negative values it can go way further than type int of value -133, but there is no
need to go that far.


```solidity
error EXPCurveInvalidCurvature();
```

