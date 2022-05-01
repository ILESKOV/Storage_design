// // This is improve of simple storage patern with using array of mapping KEYS
// in order to solve problem with impossibility to loop and enumerates throw the 
// KEY-VALUE storage to get all of entitities


pragma solidity 0.8.0;

contract MappedStructsWithIndex {

// We have a struct that contain some data
struct EntityStruct {
    uint entityData;
    // This bool type is for distinguish between data that we actively set to 0 or mapping that doesn't exist
    bool isEntity;
  }

// We have mapping
  mapping(address => EntityStruct) public entityStructs;
  
// And we have array that save all of the KEYS of addresses to the mapping
  address[] public entityList;
  
  function newEntity(address entityAddress, uint entityData) public returns(uint rowNumber) {
    if(isEntity(entityAddress)) revert();
    entityStructs[entityAddress].entityData = entityData;
    entityStructs[entityAddress].isEntity = true;
    return entityList.push(entityAddress) - 1;
  }

  function updateEntity(address entityAddress, uint entityData) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();
    entityStructs[entityAddress].entityData = entityData;
    return true;
  }

  function isEntity(address entityAddress) public view returns(bool isIndeed) {
      return entityStructs[entityAddress].isEntity;
  }

  function getEntityCount() public view returns(uint entityCount) {
    return entityList.length;
  }
}

/* 
Benefits of this type of pattern :
       - We don't have dublication, now we can directly get the entity of the address. No needs of looping to get data
       - Now we can count the number of inserted values into the mapping(number of users or entities etc.)
       - Now we can enumarate this data(loop)
       
Drawbacks of this type of pattern :
       - There are always data in the mapping. Regardless of the key we use if we haven't set the mapping 
       it will be set to the initial value, which is 0 for uint, empty string for string, false for bool and so on.
       - So we need to add extra data and it's just sort messy to work with
*/
