// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract PrimeOwner {
    address public owner;

    event OwnerChanged(address indexed newOwner);

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(uint256 _number) public {
        require(_number > 0, "Input must be greater than 0");
        require(isPrime(_number), "Input must be a prime number");
        owner = msg.sender;
        emit OwnerChanged(owner);
    }

    function isPrime(uint256 _number) private pure returns (bool) {
        if (_number <= 1) {
            return false;
        }
        if (_number == 2) {
            return true;
        }
        if (_number % 2 == 0) {
            return false;
        }
        for (uint256 i = 3; i * i <= _number; i += 2) {
            if (_number % i == 0) {
                return false;
            }
        }
        return true;
    }
}
