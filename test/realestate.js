const { expect } = require("chai");
const { ethers } = require("hardhat");

let owner, addr1, addr2, addr3;
let masterContract;

beforeEach(async () => {
    [owner, addr1, addr2, addr3] = await ethers.getSigners();

    let mC = await ethers.getContractFactory("Main");

    masterContract = await mC.deploy();
    console.log(masterContract.address);
})

describe("Master contract", () => {
    it("Allow the building of a house contract", async () => {
        let response = await masterContract.connect(owner).AddHouse(
            4,//uint256 _bedrooms,
            2,// uint256 _bathrooms,
            2000,//uint256 _sqrFootLand,
            3,//uint256 _floors,
            "Mars",//string memory _country,
            "New Scotia",//string memory _city,
            "true",//bool _forSale,
            1000000//uint256 _price
        )
        console.log(response)
        // console.log(await response.wait())
        // let address = await masterContract.houses(response.r)
        // console.log(address)
    })
})