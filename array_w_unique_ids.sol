// This is improve of simple_array storage patern with using mapping of address => bool
// in order to solve problem with having duplicates data in array

pragma solidity 0.8.0;

contract arrayWithUniqueIds {

// We have a struct that contain some data
  struct EntityStruct {
    address entityAddress;
    uint entityData;
  }

// We stored this structs in an array
  EntityStruct[] public entityStructs;
  
// With this we can know has this address already enter the data into the mapping
  mapping(address => bool) knownEntity;

  function newEntity(address entityAddress, uint entityData) public returns(uint rowNumber) {
 
 // and if it have once we create an entity we check this and revert if it's not the case
    if(knownEntity(entityAddress)) revert();
    
    // Creating new entity
    EntityStruct memory newEntity;
    newEntity.entityAddress = entityAddress;
    newEntity.entityData = entityData;
    knownEntity[entityAddress] = true;
    
    // Pushing it to the array
    return entityStructs.push(newEntity) - 1;
  }

  function updateEntity(uint rowNumber, address entityAddress, uint entityData) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();
    if(entityStructs[rowNumber].entityAddress != entityAddress) revert();
    entityStructs[rowNumber].entityData    = entityData;
    return true;
  }

  function isEntity(address entityAddress) public view returns(bool isIndeed) {
    return knownEntity[entityAddress];
  }

  function getEntityCount() public view returns(uint entityCount) {
    return entityStructs.length;
  }
}

/* 
Benefits of this type of pattern :
       - It's simple
       - Everything that we save would be in a chronological order
       - We can see how many things we've been saved instead of mapping, where we can't check the sum of all data
       
Drawbacks of this type of pattern :
       - We could input the id and get struct data, but we can't input address and get back the struct, 
       instead we must search throw with the loop looking for the entity that has my address. This is VERY costly
       - There is no good easy solution to delete data from an array in this case
*/
