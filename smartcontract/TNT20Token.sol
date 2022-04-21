// SPDX-License-Identifier: MIT
pragma solidity >=0.8.9;

import "https://github.com/thetatoken/theta-openzeppelin-demo/blob/master/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "https://github.com/thetatoken/theta-openzeppelin-demo/blob/master/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "https://github.com/thetatoken/theta-openzeppelin-demo/blob/master/contracts/access/AccessControlEnumerable.sol";

contract THT20Token is AccessControlEnumerable, ERC20 {

  uint256 private immutable _cap;
  bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

  constructor(
    string memory name,
    string memory symbol,
    uint256 cap_
  ) ERC20(name, symbol) {
    require(cap_ > 0, "Cap can't be zeor");
    _cap = cap_;

    _setupRole(DEFAULT_ADMIN_ROLE, tx.origin);
    _setupRole(MINTER_ROLE, tx.origin);
  }

  function cap() public view virtual returns (uint256) {
    return _cap;
  }

  function mint(address account, uint256 amount) public {
    require(hasRole(MINTER_ROLE, _msgSender()), "must have minter role to mint");
    require(ERC20.totalSupply() + amount <= cap(), "cap exceeded");

    _mint(account, amount);
  }

  function checkIfMinter(address _address) public view returns(bool){
    return hasRole(MINTER_ROLE, _address);
  }

}