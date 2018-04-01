pragma solidity ^0.4.18;

import "github.com/ethereum/solidity/std/mortal.sol";

contract SimpleWallet is mortal {

    mapping(address => Permission) myAddressMapping;

    struct Permission {
    bool isAllowed;
    uint maxTransferAmount;
    }

    function SimpleWallet() public {
        myAddressMapping[msg.sender] = Permission(true, 5000 ether);
    }

    function addAddressToSendersList(address permitted, uint maxTransferAmount) public onlyowner {
        myAddressMapping[permitted] = Permission(true, maxTransferAmount);
    }

    function removeAddressFromSendersList(address theAddress) public onlyowner {
        //a simple delete solves our problem
        delete myAddressMapping[theAddress];
    }

    function sendFunds(address receiver, uint amountInWei) public {
        require(myAddressMapping[msg.sender].isAllowed);
        require(myAddressMapping[msg.sender].maxTransferAmount >= amountInWei);
    }


    function () public payable {}

}
