pragma solidity 0.8.11;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract lockedSale {
    
    address public token;
    uint public bnbAmount;
    uint public ratio;
    uint public period;

    mapping (address => uint) forPeriod;
    mapping (address => uint) forAmount;

    constructor (address _token, uint _period, uint _ratio) {
        token = _token;
        ratio = _ratio;
        period = _period;
    }

    function buyTokens(uint tokenAmount) external payable {
        forPeriod[msg.sender] = block.timestamp;
        forAmount[msg.sender] = tokenAmount;

        require(IERC20(token).balanceOf(address(this)) >= forAmount[msg.sender], "Insufficient Tokens");
        require(msg.value >= forAmount[msg.sender] * 1e8  / ratio, "Need more BNB"); 
        if (msg.value > forAmount[msg.sender] * 1e8  / ratio)
            payable(msg.sender).transfer(msg.value - forAmount[msg.sender] * 1e8 / ratio);
    }
    function withDraw() external {
        require(forPeriod[msg.sender] + period < block.timestamp, "Too Early, Come here later");    
        IERC20(token).transfer(msg.sender, forAmount[msg.sender]);
    }
}