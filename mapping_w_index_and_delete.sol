// This is improve simple_mapping storage patern with using array of mapping KEYS
// in order to solve problem with impossibility to loop and enumerates throw the 
// KEY-VALUE storage to get all of entitities
// and also fixing problem with DELETING data from an array

pragma solidity 0.8.0;

contract mappedWithUnorderedIndexAndDelete {

// We have a struct that contain some data
  struct EntityStruct {
    uint entityData;
    // each struct will have an index in the array
    uint listPointer; //0
  }

// We have mapping
  mapping(address => EntityStruct) public entityStructs;
  
// And we have array that save all of the KEYS of addresses to the mapping
  address[] public entityList;

  function isEntity(address entityAddress) public view returns(bool isIndeed) {
    if(entityList.length == 0) return false;
    return (entityList[entityStructs[entityAddress].listPointer] == entityAddress);
  }

  function getEntityCount() public view returns(uint entityCount) {
    return entityList.length;
  }

  function newEntity(address entityAddress, uint entityData) public returns(bool success) {
    
    // check if we this address already have an entity in this contract, if yes -> thrown an error and revert
    // because we want each address have one row of data in order to avoid duplicates of data
    if(isEntity(entityAddress)) revert();
    
    // set the data 
    entityStructs[entityAddress].entityData = entityData;
    
    // push address into array
    entityList.push(entityAddress);
    
    // and set the pointer
    entityStructs[entityAddress].listPointer = entityList.length - 1;
    return true;
  }


  // We need function to update data
  function updateEntity(address entityAddress, uint entityData) public returns(bool success) {
    
    // Check is entity exist
    if(!isEntity(entityAddress)) revert();
    
    //Replace data with the new data
    entityStructs[entityAddress].entityData = entityData;
    
    return true;
  }
 
   // BEFORE DELETING ADDRESS 2
   // [ADRESS1, ADDRESS2, ADDRESS3, ADDRESS4].pop()
   // AFTER DELETING ADDRESS 2
   // [ADRESS1, ADDRESS4, ADDRESS3]

  function deleteEntity(address entityAddress) public returns(bool success) {
    // Check is entity exist before delete it
    if(!isEntity(entityAddress)) revert();
    
    // Find what to delete
    uint rowToDelete = entityStructs[entityAddress].listPointer; // = 1
     
    // Find address at the end of the list
    address keyToMove   = entityList[entityList.length-1]; //save address4
    
    // Delete data and put data from the last address
    entityList[rowToDelete] = keyToMove;
    
    // Set the new list pointer
    entityStructs[keyToMove].listPointer = rowToDelete; // from 4 to 2
    
    // Remove the last element from array
    entityList.pop();
    
    // We can also set initial value in struct for this address
    delete entityStructs[entityAddress];
    
    return true;
  }

}


/* 
Benefits of this type of pattern :
       - We don't have dublication, now we can directly get the entity of the address. No needs of looping to get data
       - Now we can count the number of inserted values into the mapping(number of users or entities etc.)
       - Now we can enumarate this data(loop)
       - This array is solving problem with "0 value struct", because we have the list of addresses in array
       - Now we have solution to delete data from an array
       
Drawbacks of this type of pattern :
       - So we need to add extra data and it's just sort messy to work with
       - More complex code
*/
