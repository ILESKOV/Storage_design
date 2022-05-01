pragma solidity 0.8.0;

contract simpleList {

// We have a struct that contain some data
  struct EntityStruct {
    address entityAddress;
    uint entityData;
  }

// We stored this structs in an array
  EntityStruct[] public entityStructs;

  function newEntity(address entityAddress, uint entityData) public returns(EntityStruct memory) {
// Creating new entity
    EntityStruct memory newEntity;
    newEntity.entityAddress = entityAddress;
    newEntity.entityData    = entityData;
    
// Pushing it to the array
    entityStructs.push(newEntity);
    
// And return the id
    return entityStructs[entityStructs.length - 1];
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
       - We have dublicates and we can add the same address with the same data hundreds times into the array
       - There is no good easy solution to delete data from an array in this case
*/
