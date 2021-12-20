// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/// @title A Yield Farming Contract that allows you to stake supported tokens
/// @notice Can be used to stake, unstake, add, and issue allowed tokens
/// @author Rodgeno K. Albury

contract TokenFarm is Ownable { 
    mapping(address => mapping(address => uint256)) public stakingBalance;
    mapping(address => uint256) public uniqueTokensStaked;
    mapping(address => address) public tokenPriceFeedMapping;
    address[] public stakers;
    address[] public allowedTokens;
    IERC20 public swiftToken;

    constructor(address _swiftTokenAddress) public {
        swiftToken = IERC20(_swiftTokenAddress);
    }

    function setPriceFeedContract(address _token, address _priceFeed)
        public
        onlyOwner 
    {
        tokenPriceFeedMapping[_token] = _priceFeed;
    }

    /// @notice Issue tokens to all stakers that staked 1ETH or more
    /// @dev Will increment stakersIndex by 1

    function issueTokens() public onlyOwner {
        for ( 
            uint256 stakersIndex = 0;
            stakersIndex < stakers.length;
            stakersIndex++
        ){
            address recipient = stakers[stakersIndex];
            uint256 userTotalValue = getUserTotalValue(recipient);
            swiftToken.transfer(recipient, userTotalValue);
        }
    }

    /// @notice Get the user's total value of tokens staked
    /// @param _user The address of the user
    /// @return The total value of tokens staked

    function getUserTotalValue(address _user) public view returns (uint256){
        uint256 totalValue = 0;
        require(uniqueTokensStaked[_user] > 0, "No tokens staked!");
        for (
            uint256 allowedTokensIndex = 0;
            allowedTokensIndex < allowedTokens.length;
            allowedTokensIndex++
        ){
            totalValue = totalValue + getUserSingleTokenValue(_user, allowedTokens[allowedTokensIndex]);
        }
        return totalValue;
    }

    /// @notice Get the value of a user's single token
    /// @param _user The address of the user
    /// @param _token The address of the token
    /// @return The staking balance of the token and user multiplied by the price of the token

    function getUserSingleTokenValue(address _user, address _token) 
    public
    view 
    returns (uint256) {
        if (uniqueTokensStaked[_user] <= 0){
            return 0;
        }
        // price of the token * stakingBalance[_token][user]
        (uint256 price, uint256 decimals) = getTokenValue(_token);
        return 
            // 10000000000000000000 ETH
            // ETH/USD -> 10000000000
            // 10 * 100 = 1,000
            (stakingBalance[_token][_user] * price / (10**decimals));
    }

    /// @notice Get the token's value
    /// @param _token The token's address
    /// @return Returns the price using the priceFeedAddress

    function getTokenValue(address _token) public view returns (uint256, uint256) {
        // priceFeedAddress
        address priceFeedAddress = tokenPriceFeedMapping[_token];
        AggregatorV3Interface priceFeed = AggregatorV3Interface(priceFeedAddress);
        (,int256 price,,,)= priceFeed.latestRoundData();
        uint256 decimals = uint256(priceFeed.decimals());
        return (uint256(price), decimals);
    }

    /// @notice This functions allows you to stake allowed tokens
    /// @param _amount The amount you would like to stake
    /// @param _token The token's address
    /// @dev Requires allowed tokens

    function stakeTokens(uint256 _amount, address _token) public {
        require(_amount > 0, "Amount must be more than 0");
        require(tokenIsAllowed(_token), "Token is currently not allowed");
        IERC20(_token).transferFrom(msg.sender, address(this), _amount);
        updateUniqueTokensStaked(msg.sender, _token);
        stakingBalance[_token][msg.sender] = stakingBalance[_token][msg.sender] + _amount;
        if (uniqueTokensStaked[msg.sender] == 1){
            stakers.push(msg.sender);
        }
    }
    
    /// @notice This functions allows users to unstake tokens
    /// @param _token The token's address
    /// @dev Balance must be greater than 0 to unstake


    function unstakeTokens(address _token) public {
        uint256 balance = stakingBalance[_token][msg.sender];
        require(balance > 0, "Staking balance cannot be 0");
        IERC20(_token).transfer(msg.sender, balance);
        stakingBalance[_token][msg.sender] = 0 ;
        uniqueTokensStaked[msg.sender] = uniqueTokensStaked[msg.sender] - 1;
    }

    /// @notice Updates the amount of tokens staked by user
    /// @param _user The address of the user
    /// @param _token The token's address

    function updateUniqueTokensStaked(address _user, address _token) internal {
        if (stakingBalance[_token][_user] <= 0){
            uniqueTokensStaked[_user] = uniqueTokensStaked[_user] + 1;
        }
    }

    /// @notice Adds allowed tokens
    /// @param _token The token's address

    function addAllowedTokens(address _token) public onlyOwner {
        allowedTokens.push(_token);
    }

    /// @notice Checks if tokens are allowed
    /// @param _token The token's address
    /// @return A boolean if tokens are allowed


    function tokenIsAllowed(address _token) public returns (bool) {
        for( uint256 allowedTokensIndex=0; allowedTokensIndex < allowedTokens.length; allowedTokensIndex++){
            if(allowedTokens[allowedTokensIndex] == _token){
                return true;
            }
        }
        return false; 
    }
    
}
