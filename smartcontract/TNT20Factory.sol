// SPDX-License-Identifier: MIT
pragma solidity >=0.8.9;

import "./TNT20Token.sol";

contract ERC20Factory {
    event ERC20TokenCreated(address indexed tokenAddress, string symbol, uint256 indexed cap);

    function deployNewERC20Token(
        string calldata name,
        string calldata symbol,
        uint256 cap
    ) public returns (address) {
        TNT20Token t = new TNT20Token(
            name,
            symbol,
            cap
        );
        emit ERC20TokenCreated(address(t), symbol, cap);

        return address(t);
    }



    function deployNewERC721Token(string memory name, string memory symbol)
        public
        returns (address)
    {
        // ERC721Token t = new ERC721Token(name, symbol);
        // emit ERC721TokenCreated(address(t));

        // return address(t);
    }
}