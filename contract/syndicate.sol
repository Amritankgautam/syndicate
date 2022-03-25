// SPDX-License-Identifier:GPL-3.0
pragma solidity  0.8.12;


contract syndicate{
    
    struct LoanSeeker {
        uint companyId;
        string companyName;
        address userAddress;
        bool isLoanSeeker;
    }
    
    struct  Lender {
        uint lenderId;
        string lenderName;
        address lenderAddress;
        uint term;
       uint amountOffered;
        uint interestRate;  
    }
    
    struct LoanRequest{
         uint amountNeeded;
         uint term;
          address loanSeekerAddress;
    }
    mapping(address =>uint)  public contributors;
    mapping(address =>uint)  public balances;
    mapping(address =>mapping(address=>uint))allowed;
    
event Transfer(address indexed from, address indexed to,
 uint tokens);    

    
    LoanSeeker[] public loanSeekers;
    LoanRequest[] public loanRequests;
    Lender[]public lenders;
    address public creator;
    uint private loanAmountNeeded;
    string companyName;
    uint public minimumContribution;
    uint public noofLenders;
    uint public raisedAmount;
    uint totalSupply_;
    address public myAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    constructor(uint total) {
        creator = msg.sender; //who is sending the message
        minimumContribution= 1000 wei;
        totalSupply_ = total;
        balances[msg.sender]=totalSupply_;
    }
    
      function getAllTheLoanSeekers(uint _companyId) public view returns (string memory) 
    {
                return loanSeekers[_companyId].companyName;
                


    }
    
    function getCompanyName() public view returns (string memory) {
        return companyName;
    }
    
    
        
    
    modifier ifCreator(){
        require (msg.sender == creator);{
            _;
        }
        
    }
    
      modifier ifLender(){
        require (msg.sender == creator);{
            _;
        }
        
    }
    
        modifier ifLoanSeeker(){
        require(msg.sender == creator);{
            _;
        }
        
    }
       function SendEth() public payable{
           require(msg.value>minimumContribution,"mimimum Contribution is not met");
           require(msg.sender == myAddress);
           if(contributors[msg.sender]==0){
                noofLenders++;
            }
            
            contributors[msg.sender]+=msg.value;
            raisedAmount+=msg.value;
               }
        
        function getContractBalance() public view returns(uint){
            return address(this).balance;
        }
        function totalSupply() public view returns (uint256) {
  return totalSupply_;
}
function balanceOf(address tokenContributor) public view returns (uint) {
  return balances[tokenContributor];
}
   function onProposal(address changeAddress)public  {
       myAddress=changeAddress;
   }


      function validateLoanSeekerRequest(uint _companyId) public view returns(bool accepted){
          
            for(uint i=0 ; i<loanSeekers.length; i++){
              if(loanSeekers[i].companyId == _companyId){
                  return(true);
              }
             }
    }
    
    function raiseLoanRequest(uint _companyId,uint _loanAmountNeeded, uint _term ) public ifLender{
             {
               loanRequests.push() ;
               
                    uint index = loanRequests.length-1;
                    loanRequests[index].amountNeeded = _loanAmountNeeded;
                    loanRequests[index].term =_term;
                    
                    require(validateLoanSeekerRequest(_companyId));{
                       
                    }
                    loanRequests[index].loanSeekerAddress =msg.sender;
    
                    
               }
                
    }
    
    function addLoanSeeker(uint _companyId, string memory _companyName) public ifLoanSeeker{
               
               loanSeekers.push();
                    uint index = loanSeekers.length-1;
                    loanSeekers[index].companyName=_companyName;
                    loanSeekers[index].companyId =_companyId;
                    loanSeekers[index].userAddress =msg.sender;

        
    }
    
    function addContributor(  uint _lenderId, uint _amountOffered, uint _interestRate,  uint _term, string memory _lenderName)public  ifLender{
              
                    lenders.push();
                    uint index = lenders.length-1;
                    lenders[index].lenderId=_lenderId;
                    lenders[index].lenderName =_lenderName;
                    lenders[index].term =_term;
                    lenders[index].amountOffered =_amountOffered;
                    lenders[index].interestRate =_interestRate;
               
        
    }
    function getContributor(uint id)public view  returns (string memory accepted){
         for(uint i=0 ; i<lenders.length; i++){
              if(lenders[i].lenderId == id){
                  return lenders[i].lenderName;
              }
             }
    } 
    

}
