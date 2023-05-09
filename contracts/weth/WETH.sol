// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract WETH is ERC20 {

	constructor() ERC20("WBNB", "WBNB"){}

    function deposit() external payable {
		_mint(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external {
		_burn(msg.sender, amount);
		(bool success, ) = msg.sender.call{value: amount, gas: 50000}("");
        require(success, "failed to send");
    }
}
