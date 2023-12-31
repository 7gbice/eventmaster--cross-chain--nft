// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EventMaster is ERC721, ERC721URIStorage, Ownable {
    string constant TOKEN_URI = "https://ipfs.io/ipns/k51qzi5uqu5djy87jd3f1ytwqhkg9eky9q8xajr5x8mqbw2vi9ye7632cei310";
    uint256 internal currentTokenId;
    address public _contractOwner;
    uint256 public totalOccasions;
    uint256 public totalSupply;

    struct Occasion {
        uint256 id;
        string name;
        uint256 cost;
        uint256 tickets;
        uint256 maxTickets;
        string date;
        string time;
        string location;
    }

    mapping(uint256 => Occasion) occasions;
    mapping(uint256 => mapping(address => bool)) public hasBought;
    mapping(uint256 => mapping(uint256 => address)) public seatTaken;
    mapping(uint256 => uint256[]) seatsTaken;

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {
        _contractOwner = msg.sender;
    }

    function list(
        string memory _name,
        uint256 _cost,
        uint256 _maxTickets,
        string memory _date,
        string memory _time,
        string memory _location
    ) public onlyOwner {
        totalOccasions++;
        occasions[totalOccasions] =
            Occasion(totalOccasions, _name, _cost, _maxTickets, _maxTickets, _date, _time, _location);
    }

    function mint(address to, uint256 _id, uint256 _seat) public payable {
        _safeMint(to, currentTokenId);
        _setTokenURI(currentTokenId, TOKEN_URI);
        unchecked {
            currentTokenId++;
        }
        // Require that _id is not 0 or less than total occasions...
        require(_id != 0);
        require(_id <= totalOccasions);
        bool _cost;

        // Require that ETH sent is greater than cost...
        require(msg.value >= occasions[_id].cost);
        if (msg.value > 1e18) {
            _cost = true;
        } else {
            _cost = false;
        }

        // Require that the seat is not taken, and the seat exists...
        require(seatTaken[_id][_seat] == address(0));
        require(_seat <= occasions[_id].maxTickets);

        occasions[_id].tickets -= 1; // <-- Update ticket count

        hasBought[_id][msg.sender] = true; // <-- Update buying status
        seatTaken[_id][_seat] = msg.sender; // <-- Assign seat

        seatsTaken[_id].push(_seat); // <-- Update seats currently taken

        totalSupply++;

        _safeMint(msg.sender, totalSupply);
    }

    function getOccasion(uint256 _id) public view returns (Occasion memory) {
        return occasions[_id];
    }

    function getSeatsTaken(uint256 _id) public view returns (uint256[] memory) {
        return seatsTaken[_id];
    }

    function withdraw() public onlyOwner {
        payable(_contractOwner).transfer(address(this).balance);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        // Your implementation here
    }

    function _burn(uint256 tokenId) internal virtual override(ERC721, ERC721URIStorage) {
        // Your implementation here
    }
}
