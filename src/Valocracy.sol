// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC20Votes} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {EIP712} from "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import {IDNFT} from "./IDNFT.sol";

error TokenSoulbound();

contract Valocracy is Ownable, IDNFT, ERC20Votes {
    /**
     * @dev Initializes the contract by setting a `name` and a `symbol`.
     */
    constructor(string memory name, string memory symbol) 
        ERC20(name, symbol)
        ERC20Votes()
        Ownable(msg.sender)
        EIP712(name, "1")
    {}

    /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId) public view returns (string memory) {
        return "a";
    }

    // /**
    //  * @dev Overriding the {ERC721-_transfer} to make the token
    //  * soulbounded, making it non-transferable to another account.
    //  *
    //  * The account can still burn the token calling {ERC721-burn}
    //  */
    // function _transfer(address, address, uint256) internal pure override {
    //     revert TokenSoulbound();
    // }

    // /**
    //  * @dev Returns the balance of `account`.
    //  *
    //  * WARNING: Overriding this function will likely result in incorrect vote tracking.
    //  */
    // function _getVotingUnits(address account) internal view override returns (uint256) {
    //     return levelOf(account);
    // }
}
