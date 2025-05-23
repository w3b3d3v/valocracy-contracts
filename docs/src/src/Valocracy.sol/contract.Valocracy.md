# Valocracy
[Git Source](https://github.com/w3b3d3v/valocracy-contracts/blob/4dd7e8efca2b95983b263ee58c9706887af43545/src/Valocracy.sol)

**Inherits:**
Ownable, [IDNFT](/src/IDNFT.sol/abstract.IDNFT.md), ERC20Votes


## Functions
### constructor

*Initializes the contract by setting a `name` and a `symbol`.*


```solidity
constructor(string memory name, string memory symbol)
    ERC20(name, symbol)
    ERC20Votes()
    Ownable(msg.sender)
    EIP712(name, "1");
```

### tokenURI

*See [IERC721Metadata-tokenURI](/lib/forge-std/src/interfaces/IERC6909.sol/interface.IERC6909ContentURI.md#tokenuri).*


```solidity
function tokenURI(uint256 tokenId) public view returns (string memory);
```

