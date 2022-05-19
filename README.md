# Storage_design
Storage patterns

To be efficient and write code with less storage we need to choose patterns depending on ours use cases
We need to have to think of our needs

For example:
        
        - If we want to build token, we probably not interested to have enumerable storage, where we can iterate throw it.
        That's probably not the most important instead what is maybe the simplicity of having only one MAPPING and the 
        simplicity of being able to do all of the different operations we want to do in our storage in a fast way.
        Where they don't depend on some size of array. They just instant
        
        
        - If we need enuberable objects in our contract to be able iterate throw an array, to get all of the specific                 entities,
        and do some operations with this data, we probalbly need an Array and it migth be a good idea to create more complex 
        storage to have both mapping and array. Usually this combination is the best.
        If we need to have enuberable storage with instant writing and reading and update, which we do when we have MAPPING
        combainig with an ARRAY
        
        
        - But if we don't need it there are n point to going with this complex storage design because it makes our contract 
        more complicated and makes it more complicated to other people to understand what's going on
        
        - Another thing to thing is do we need DELETE functionality or is it enought to us just be able to set something to 0
        For example ERC-20 token contracts very rarely have DELETE function functionality, we just set the balance to 0,
        so there is no difference in this case, because at the begging every address is pointing to 0 in mapping
        
        - Think what sort of operations do I need in my storage and depending on that choose your solution
        
        - Another thing is very important to think about is what sort of operations will you do a lot of.
        Let's say you will be doing a lot of create functions calls, you'll be do a lot of create operations, but you will not
        do delete operations.
        Than you can think I want to create operations to be very fast . I don't want that be depend on the size of the
        storage. You know that you want to do a lot of update calls, then an pure ARRAY is probably not good idea,
        because you need to loop throw an array every time you need to update something
        The same for reading. If you know you gonna do a lot of reading and searching for data then have only an ARRAY is 
        probably a bad idea
        
        - But maybe you want storage with enumerable data, and you will only input data. You will not read or update 
        specific address or KEYS. You will only add data and calculations of data set, then there are no use cases for mapping
        If you need to iterate some data, then using only ARRAY is good idea
        
