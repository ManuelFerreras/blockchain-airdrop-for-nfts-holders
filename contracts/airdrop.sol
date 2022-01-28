// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract airdropForNFTHolders {

    address owner;
    ERC721Enumerable collection;
    ERC20 token;

    mapping(address => bool) counted;

    constructor (address _rewardsTokenAddress) {
        owner = msg.sender;
        collection = ERC721Enumerable(0x42845A65e16E3AEd767C13a8500cd791DF81c892);
        token = ERC20(_rewardsTokenAddress);
    }

    function airdrop(uint256 _amountOfTokensPerOwner) public onlyOwner {

        for(uint i = 0; i<collection.totalSupply(); i++) {
            if(counted[collection.ownerOf(i)] == false && collection.ownerOf(i) != address(0)) {
                counted[collection.ownerOf(i)] = true;
                token.transferFrom(msg.sender, collection.ownerOf(i), _amountOfTokensPerOwner * 10 ** token.decimals());
            }
        }

    }

    function resetMapping() public {

        for(uint i = 0; i<collection.totalSupply(); i++) {
            if(counted[collection.ownerOf(i)] == false && collection.ownerOf(i) != address(0)) {
                counted[collection.ownerOf(i)] = true;
            }
        }

    }


    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function.");

        _;
    }


}