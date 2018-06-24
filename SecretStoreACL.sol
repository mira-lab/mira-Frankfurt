pragma solidity ^0.4.18;
contract SecretStoreACL {
    struct Mirabox{
        bytes32 document;
        address user;
    }
    
    mapping (uint => Mirabox) private miraboxes;
    uint private miraboxesCount = 0;
    
    address private owner;

    function SecretStoreACL() public{
        owner = msg.sender;
    }
    function setMiraBox(address _user, bytes32 document) public {
        require(msg.sender == owner);
        miraboxes[miraboxesCount] = Mirabox({
            document: document,
            user: _user
        });
        miraboxesCount++;
    }
    function checkPermissions(address user, bytes32 document) constant returns (bool) {
        bool isIt = false;
        address userAddress;
        for(uint i = 0; i < miraboxesCount; i++){
            if(miraboxes[i].document == document){
                isIt = true;
                userAddress = miraboxes[i].user;
            }
        }
        if(isIt){
            if(user == userAddress){
                return true;
            }
            else{
                return false;
            }
        }else{
            return true;
        }
    }
    
}
