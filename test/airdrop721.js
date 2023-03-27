const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");
const { ethers, upgrades } = require("hardhat");

describe("Airdrop721", function() {
	it("deploy", async function () {
		const ERC721 = await ethers.getContractFactory("Airdrop721");
		erc721 = await ERC721.deploy("bns mock", ".btc", "https://files.bns.org/mainnet/baee51eb/0x457eFd33Def0bFF2dfe33089D385898D919d3a10/")
		await erc721.deployed();
	});

	it("airdrop", async function() {
		const [owner, addr1, addr2] = await ethers.getSigners();
		await erc721.airdrop([owner.address, addr1.address, addr2.address, addr1.address]);
		balance1 = await erc721.balanceOf(addr1.address);
		console.log("addr1 balance: ", balance1);
		balance2 = await erc721.balanceOf(addr2.address);
		console.log("addr2 balance: ", balance2);
	});

	it("transfer", async function() {
		const [owner, addr1] = await ethers.getSigners();
		console.log("before transaction");
		balance1 = await erc721.balanceOf(owner.address);
		console.log("owner balance: ", balance1);
		balance2 = await erc721.balanceOf(addr1.address);
		console.log("addr2 balance: ", balance2);

		await erc721.transferFrom(owner.address, addr1.address, 1);

		console.log("after transaction");
		balance1 = await erc721.balanceOf(owner.address);
		console.log("addr1 balance: ", balance1);
		balance2 = await erc721.balanceOf(addr1.address);
		console.log("addr2 balance: ", balance2);
	});
});
