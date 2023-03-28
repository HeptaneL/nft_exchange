pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Name3Multicall is Ownable {
    struct Call {
        address target;
        uint256 value;
        bytes callData;
    }
    
    function atomicize (Call[] memory calls)
        public payable 
    {
        for(uint256 i = 0; i < calls.length; i++) {
            (bool success, ) = calls[i].target.call{value:calls[i].value}(calls[i].callData);
            require(success);
        }
    }
    
    function withdraw(address payable dev) external onlyOwner {
        uint256 balance = address(this).balance;
        dev.transfer(balance);
    }

    receive() payable external {}
}
