pragma solidity ^0.8.6;

contract ShahbazToken {
    constructor() {
        string memory tokenName = """SHAHBAZ TOKEN""";
        string memory tokenSymbol = "ST";
    }
    
    //mapping of O=Particular Owner's NFT's
    mapping(address => uint) private NFT;
   
    //mapping of approved operators
    mapping(address => mapping(address => bool)) private allowed;
    
    //mapping of owner of an NFT
    mapping (uint => address) private OWNERS;
    
    // Mapping from token ID to approved address
    mapping(uint256 => address) private  _tokenApprovals;
    
    
    
    event Approval(address  _owner, address  _approved, uint256  _tokenId);
    event Transfer(address  _from, address  _to, uint256  _tokenId);
    event ApprovalForAll(address  _owner, address  _operator, bool _approved);
   
    
    function balanceOf(address _owner) external view returns (uint256 NFTS )
    {
            // if(_owner != address(0))
            // {
            //     return NFT[_owner];
        
            // }
            
            //  else
            //  {
            
            //      return  ;
            //  }
            
            require(_owner != address(0) , "Invalid Address");
            NFTS=NFT[_owner];
                
            
    }
    
      function approve(address _approved, uint256 _tokenId) external payable returns (bool success)
    {
        
       // allowed[msg.sender][_approved] = _tokenId;
       _tokenApprovals[_tokenId] = _approved;
        //return true;
        emit Approval(msg.sender , _approved ,  _tokenId);
        //success = true;
    }
    
    
     function ownerOf(uint256 _tokenId) external view returns (address OWNER)
     {
         OWNER = OWNERS[_tokenId];
         
     }
     
      function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable
      {
          delete NFT[_from];
          NFT[_to] = _tokenId;
          emit Transfer(_from , _to, _tokenId);
      }
      
      function transferFrom(address _from, address _to, uint256 _tokenId) external payable
      {
          require(_to != address(0),"Enter The Valid Address");
          uint ownerShip = NFT[_from];
          require(ownerShip != _tokenId , "You're not the owner of this NFT");
          address realOwnerr = OWNERS[_tokenId];
          bool authorized = allowed[realOwnerr][_from];
          require(authorized != true , "You're not approved");
          require(_to != address(0) , "Invalid Address");
          delete NFT[_from];
          NFT[_to] = _tokenId;
          emit Transfer(_from , _to, _tokenId);
      }
      
      function setApprovalForAll(address _operator, bool _approved) external
      {
          require(_operator != msg.sender , "Enter Other Address For Approval");
          
          allowed[msg.sender][_operator] = _approved;
          emit  ApprovalForAll(msg.sender, _operator, _approved);
          
          
          
      }
            
            
    function isApprovedForAll(address _owner, address _operator) external view returns (bool)
    {
        return allowed[_owner][_operator] ;
    }
    
     function getApproved(uint256 _tokenId) external view returns (address)
     {
         require(OWNERS[_tokenId] != address(0) , "The Token Is'nt Valid");
          return _tokenApprovals[_tokenId];
         
     }
        

}
