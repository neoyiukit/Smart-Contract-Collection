pragma solidity ^0.4.15;

contract owned {
    address owner;

    modifier onlyowner() {
        require(msg.sender == owner);
        _;
    }

    function owned() public {
        owner = msg.sender;
    }
}
