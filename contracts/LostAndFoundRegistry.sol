// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract LostAndFoundRegistry {
    string public name = "LostAndFoundAsset";
    string public symbol = "LFA";

    struct Item {
        string description;
        uint256 bounty;
        bool isLost;
        address finder;
    }

    uint256 public nextItemId;
    mapping(uint256 => Item) public items;
    mapping(uint256 => address) private _owners;
    mapping(address => uint256) private _balances;

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event ItemRegistered(uint256 itemId, address owner, string description, uint256 bounty);
    event ItemFound(uint256 itemId, address finder);
    event BountyClaimed(uint256 itemId, address finder, uint256 amount);

    // ---------------------------
    // Basic ERC-721-like logic
    // ---------------------------
    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "Token does not exist");
        return owner;
    }

    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0), "Invalid address");
        return _balances[owner];
    }

    function _mint(address to, uint256 tokenId) internal {
        require(to != address(0), "Invalid address");
        require(_owners[tokenId] == address(0), "Token already exists");
        _owners[tokenId] = to;
        _balances[to] += 1;
        emit Transfer(address(0), to, tokenId);
    }

    // ---------------------------
    // Lost & Found Logic
    // ---------------------------
    function registerItem(string calldata description) external payable {
        require(msg.value > 0, "Bounty required");

        uint256 itemId = nextItemId++;
        _mint(msg.sender, itemId);

        items[itemId] = Item({
            description: description,
            bounty: msg.value,
            isLost: true,
            finder: address(0)
        });

        emit ItemRegistered(itemId, msg.sender, description, msg.value);
    }

    function reportFound(uint256 itemId) external {
        require(_owners[itemId] != address(0), "Item does not exist");
        Item storage item = items[itemId];
        require(item.isLost, "Item not marked as lost");
        require(item.finder == address(0), "Already reported found");

        item.finder = msg.sender;
        emit ItemFound(itemId, msg.sender);
    }

    function confirmReturn(uint256 itemId) external {
        require(ownerOf(itemId) == msg.sender, "Not item owner");
        Item storage item = items[itemId];
        require(item.finder != address(0), "No finder reported");

        item.isLost = false;
        uint256 reward = item.bounty;
        item.bounty = 0;

        payable(item.finder).transfer(reward);
        emit BountyClaimed(itemId, item.finder, reward);
    }
}
