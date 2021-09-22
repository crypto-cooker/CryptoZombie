pragma solidity >=0.5.0 <0.6.0;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

    uint levelUpFee = 0.001 ether;
    modifier aboveLevel(uint _level, uint _zombieId) {
        require(zombies[_zombieId].level>=_level);
        _;
    }
    function changeName(uint _zombieId, string calldata _newName) external aboveLevel(2, _zombieId) {
        require(zombieToOwner[_zombieId]==msg.sender);
        zombies[_zombieId].name = _newName;
    }
    function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
        require(zombieToOwner[_zombieId]==msg.sender);
        zombies[_zombieId].dna = _newDna;
    }
    function getZombiesByOwner(address owner) external view returns (uint[] memory){
        uint[] memory result = new uint[](ownerZombieCount[owner]);
        uint counter = 0;
        for(uint i=0;i<zombies.length;i++){
            if(zombieToOwner[i]==owner){
                result[counter] = i;
            }
        }
        return result;
    }
    function levelUp(uint _zombieId) external payable {
        require(msg.value==levelUpFee);
        zombies[_zombieId].level++;
    }

}