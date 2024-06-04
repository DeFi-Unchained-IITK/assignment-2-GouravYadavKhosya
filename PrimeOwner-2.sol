// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract PrimeOwner {
    address public owner;
    event OwnershipTransferred(address newOwner);

    constructor() {
        owner = msg.sender;
    }

    function changeOwnerIfPrime(uint _number) public {
        require(_number >= 1, "Input must be greater than or equal to 1");
        if (isPrime(_number)) {
            owner = msg.sender;
            emit OwnershipTransferred(msg.sender);
        }
    }

    function isPrime(uint _number) private pure returns (bool) {
        if (_number <= 1) return false;
        if (_number == 2) return true;
        if (_number % 2 == 0) return false;
        uint sqrtNum = uint(_number ** (uint(1) / uint(2)));
        for (uint i = 3; i <= sqrtNum; i += 2) {
            if (_number % i == 0) return false;
        }
        return true;
    }
}