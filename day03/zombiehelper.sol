pragma solidity >=0.5.0 <0.6.0;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  modifier aboveLevel(uint _level, uint _zombieId) {
    require(zombies[_zombieId].level >= _level);
    _;  // this calls the rest of the function
  }

  function changeName(uint _zombieId, string calldata _newName) external aboveLevel(2, _zombieId) {  // calldata is similar to memory, but it's only available to external functions
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].name = _newName;
  }

  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].dna = _newDna;
  }

  function getZombiesByOwner(address _owner) external view returns(uint[] memory) {  // view functions don't cost any gas when they're called externally by a user
    uint[] memory result = new uint[](ownerZombieCount[_owner]);  // memory arrays must be created with a length argument
    // they currently cannot be resized like storage arrays can with array.push()
    
    uint counter = 0;  // keep track of the index in the new array
    for (uint i = 0; i < zombies.length; i++){
      if (zombieToOwner[i] == _owner){
        result[counter] = i;
        counter++;  // Increment counter to the next empty index in 'result'
      }
    }
    return result;
  }

}
