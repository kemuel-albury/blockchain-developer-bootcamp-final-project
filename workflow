1. Users get to set their ownership of the contract and date to unlock the funds

constructor(address _creator, address _owner, uint256 _releaseDate) {
     // setting up their Time Locked Wallets
    }
    
2. Only owners can withdraw their funds after a specific time

function withdraw() onlyOwner public {
  // check set time
  // then send all the balance
}

3. Only owners can withdraw their tokens(ERC-20 Only) after a specific time

  function withdrawTokens(address _tokenContract) onlyOwner public {
  // check set time
  // then send all token balance
 }
 
 4. User can get information about who owns, what is the unlock date and how much the wallet has
 
  function info() public view returns(address, address, uint256, uint256, uint256) {
  //returns information on the wallet initiation
  }
