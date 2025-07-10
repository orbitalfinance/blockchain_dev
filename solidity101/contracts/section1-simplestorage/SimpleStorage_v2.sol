//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SimpleStorage_v2 {

    uint256 favoriteNumber; // Set t 0

    function store(uint256 _favoriteNumber) public {

        favoriteNumber= _favoriteNumber;

    }

    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }
}