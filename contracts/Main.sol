// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;
import "./House.sol";
import "./Flat.sol";

contract Main {
    mapping(uint256 => address) public houses;
    mapping(uint256 => Flat) flats;
    // mapping(uint256 => Commercial) commercial;
    // mapping(uint256 => Land) land;
    address payable public owner;
    uint256 private counter;

    constructor() {
        owner = payable(msg.sender);
        counter = 0;
    }

    function AddHouse(
        uint256 _bedrooms,
        uint256 _bathrooms,
        uint256 _sqrFootLand,
        uint256 _floors,
        string memory _country,
        string memory _city,
        bool _forSale,
        uint256 _price
    ) public returns (uint256) {
        address house = address(
            new House(
                _bedrooms,
                _bathrooms,
                _sqrFootLand,
                _floors,
                _country,
                _city,
                _forSale,
                _price,
                msg.sender
            )
        ); // creates new House and returns contract address
        counter++;
        uint256 houseId = uint256(
            keccak256(
                abi.encodePacked(
                    msg.sender,
                    keccak256(abi.encodePacked(counter))
                )
            )
        ); // creates a unique id for the house
        houses[houseId] = house;
        emit NewHouse(houseId, house, msg.sender);
        return houseId;
    }

    // function AddFlat(
    //     uint256 _bedrooms,
    //     uint256 _bathrooms,
    //     uint256 _floor,
    //     string memory _country,
    //     string memory _city,
    //     bool _forSale,
    //     uint256 _price
    // ) public returns (uint256) {
    //     Flat flat = new Flat(
    //         _bedrooms,
    //         _bathrooms,
    //         _floor,
    //         _country,
    //         _city,
    //         _forSale,
    //         _price
    //     ); // creates new House and returns contract address
    //     counter++;
    //     uint256 flatId = uint256(
    //         keccak256(
    //             abi.encodePacked(
    //                 msg.sender,
    //                 keccak256(abi.encodePacked(counter))
    //             )
    //         )
    //     ); // creates a unique id for the house
    //     flats[flatId] = flat;
    //     emit NewFlat(flatId, flat, msg.sender);
    //     return flatId;
    // }

    // function buyHouse(uint256 houseId) public payable {
    //     address house = houses[houseId];
    //     house.changeOwner{value: msg.value}(msg.sender);
    // }

    // function getDetails(uint256 houseId)
    //     public
    //     view
    //     returns (
    //         uint256,
    //         uint256,
    //         uint256,
    //         uint256,
    //         string memory,
    //         string memory,
    //         bool,
    //         uint256
    //     )
    // {
    //     House house = houses[houseId];
    //     return house.getDetails();
    // }

    // function buyFlat(uint256 flatId) public payable {
    //     Flat flat = flats[flatId];
    //     flat.changeOwner{value: msg.value}(msg.sender);
    // }

    event NewHouse(uint256 houseId, address house, address owner);
    event NewFlat(uint256 flatId, Flat flat, address owner);
}
