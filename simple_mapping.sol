pragma solidity 0.8.0;
contract mappingWithStruct {

// We have the struct that contain some data
  struct EntityStruct {
    uint entityData;
    // This bool type is for distinguish between data that we actively set to 0 or mapping that doesn't exist
    bool isEntity;
  }

// And we have mapping
  mapping (address => EntityStruct) public entityStructs;

  function newEntity(address entityAddress, uint entityData) public returns(bool success) {
    if(isEntity(entityAddress)) revert(); 
    entityStructs[entityAddress].entityData = entityData;
    entityStructs[entityAddress].isEntity = true;
    return true;
  }
  
  function isEntity(address entityAddress) public view returns(bool isIndeed) {
    return entityStructs[entityAddress].isEntity;
  }

  function deleteEntity(address entityAddress) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();
    entityStructs[entityAddress].isEntity = false; // or delete entityStructs[entityAddress];
    return true;
  }

  function updateEntity(address entityAddress, uint entityData) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();
    entityStructs[entityAddress].entityData = entityData;
    return true;
  }
}


// We have as truct that contain some data
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
       - We don't have dublicate, now we can directly get the entity of the address. No needs of looping to get data
       
Drawbacks of this type of pattern :
       - We don't know how many of this entities is in the mapping, because we can't loop throw them all
       and there are no such a thins like "length of the mapping", because it's just a KEY-VALUE type storage.
       This is a big drawback depending of what we need of course
       - We can't get enumerates throw the KEY-VALUE to get all of entities
       - There are always data in the mapping. Regardless of the key we use if we haven't set the mapping 
       it will be set to the initial value, which is 0 for uint, empty string for string, false for bool and so on.
       - So we need to add extra data and it's just sort messy to work with
*/
