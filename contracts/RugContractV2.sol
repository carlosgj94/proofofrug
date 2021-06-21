// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BankRunner is ERC721URIStorage, Ownable {
  uint256 public tokenCounter;
  string public internalTokenURI;
  IERC20 public titanToken;
  mapping(address => bool) public minted;

  constructor(string memory _tokenURI, address _titanAddress)
    ERC721("BankRunner", "BRR")
  {
    tokenCounter = 0;
    internalTokenURI = _tokenURI;
    titanToken = IERC20(_titanAddress);
  }

  function mintCollectible() public returns (uint256) {
    require(tokenCounter < 1000, "All tokens already minted");
    //require(titanToken.balanceOf(msg.sender) > 0, "Owner doesn't have Titan");
    require(minted[msg.sender] == false, "NFT already minted");
    minted[msg.sender] = true;

    uint256 newTokenId = tokenCounter;
    _safeMint(msg.sender, newTokenId);
    _setTokenURI(newTokenId, internalTokenURI);

    tokenCounter = tokenCounter + 1;

    return newTokenId;
  }

  function hasBalance() public view returns (bool) {
    return titanToken.balanceOf(msg.sender) > 0;
  }
}
