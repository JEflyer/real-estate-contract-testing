// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Flat {
    address payable private houseOwner;
    uint256 noOfBedrooms;
    uint256 noOfBathrooms;
    uint256 floor;
    string country;
    string city;

    bool forSale;
    uint256 sellingPrice;
    uint256 lastSoldPrice;
    address lastOwner;

    constructor(
        uint256 _bedrooms,
        uint256 _bathrooms,
        uint256 _floor,
        string memory _country,
        string memory _city,
        bool _forSale,
        uint256 _price
    ) {
        houseOwner = payable(msg.sender);
        noOfBedrooms = _bedrooms;
        noOfBathrooms = _bathrooms;
        floor = _floor;
        country = _country;
        city = _city;
        forSale = _forSale;
        sellingPrice = _price;
    }

    modifier onlyOwner(address _caller) {
        require(_caller == houseOwner, "Only the owner can call this function");
        _;
    }

    modifier isForSale() {
        require(forSale == true);
        _;
    }

    function getDetails()
        public
        view
        returns (
            uint256,
            uint256,
            uint256,
            string memory,
            string memory,
            bool,
            uint256
        )
    {
        return (
            noOfBedrooms,
            noOfBathrooms,
            floor,
            country,
            city,
            forSale,
            sellingPrice
        );
    }

    function setPrice(uint256 _newPrice, address _caller)
        external
        onlyOwner(_caller)
    {
        sellingPrice = _newPrice;
    }

    function setSaleState(bool _state, address _caller)
        external
        onlyOwner(_caller)
    {
        forSale = _state;
    }

    function changeOwner(address _caller) public payable isForSale {
        if (msg.value < sellingPrice) {
            payable(_caller).transfer(msg.value);
            revert("Not enough ether was sent");
        }
        houseOwner.transfer(msg.value);
        lastOwner = houseOwner;
        houseOwner = payable(_caller);
        forSale = false;
        lastSoldPrice = sellingPrice;
        sellingPrice = 0;
        emit ChangedOwner(lastOwner, lastSoldPrice);
    }

    event ChangedOwner(address lastOwner, uint256 soldPrice);
}
