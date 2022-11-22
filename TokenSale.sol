//SPDX-License-Identifier: MIT
pragma solidity 0.8.16;


// takes functions through openZepplin contracts inherited on the token contract
interface IERC20 {
    function transfer(address to, uint amount) external;
    function decimals()external view returns(uint);

}

contract tokenSale{

    uint tokenPriceInWei = 1 ether;

    IERC20 token;   

    // Takes ERC20 token contract address 
    constructor(address _token){
        token = IERC20(_token);
    }

    //Function checks for enough Money, will send back remaing balance if over pay
    function purchase() public payable {
        require(msg.value >= tokenPriceInWei, "Not Enough Money Sent");
        uint tokensToTransfer = msg.value / tokenPriceInWei;
        uint remainder = msg.value - tokensToTransfer * tokenPriceInWei;
        token.transfer(msg.sender, tokensToTransfer * 10 ** token.decimals());
        payable(msg.sender).transfer(remainder); //send the rest back
    }
}
