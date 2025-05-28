# IERC7725
[Git Source](https://github.com/w3b3d3v/valocracy-contracts/blob/3c1bb3a5dbf1b0852bacbc7957066c674b876a74/src/math/IERC7725.sol)


## Functions
### expcurve

*This function calculates the exponential decay value over time.
This formula ensures that the value starts at 100%/0% at the beginning (t0)
and decreases/increases to 0%/100% at the end (T), following an exponential decay curve.
The formula used for the curves difers based on the `ascending` parameter:
ascending = ((exp(k * (1 - (t - t0) / (T - t0))) - 1) / (exp(k) - 1)) * 100
descenging = ((exp(k * ((t - t0) / (T - t0))) - 1) / (exp(k) - 1)) * 100
Where:
- t is the current timestamp
- t0 is the start timestamp
- T is the end timestamp
- k is the curvature factor, determining the steepness of the curve (2 decimals precision)
- exp() is the exponential function with base 'E' (Euler's number, approximately 2.71828)
Requirements:
- The initial timestamp must be less than or equal to the current timestamp
- The initial timestamp must be less than the final timestamp
- The curvature cannot be zero
- The curvature cannot be bigger than 10000 or smaller than -10000 (2 decimals precision)
NOTE: To avoid precision issues, the formula uses fixed-point math with 18 decimals.
When returning this function result, make sure to adjust the output values accordingly.
NOTE: Using type uint32 for timestamps since 4294967295 unix seconds will only overflow
in the year 2106, which is more than enough for the current use cases.*


```solidity
function expcurve(
    uint32 currentTimeframe,
    uint32 initialTimeframe,
    uint32 finalTimeframe,
    int16 curvature,
    bool ascending
) external pure returns (int256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`currentTimeframe`|`uint32`|The current timestamp or a point within the spectrum|
|`initialTimeframe`|`uint32`|The initial timestamp or the beginning of the curve|
|`finalTimeframe`|`uint32`|The final timestamp or the end of the curve|
|`curvature`|`int16`|The curvature factor. Determines the steepness of the curve and can be negative, which will invert the curve's direction.|
|`ascending`|`bool`|The curve direction (ascending or descending)|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`int256`|int256 The exponential decay value at a specific interval|


