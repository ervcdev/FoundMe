// Get funds from users
//witdrw funds
//set a minimum funding value in USD

//SPDX-License-Identifier: MIT
pragma solidity 0.8.18;
import {AggregatorV3Interface} from "./AggregatorV3Interface.sol"

interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  function getRoundData(
    uint80 _roundId
  ) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

  function latestRoundData()
    external
    view
    returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
}

contract FUndMe {
    uint256 public minimumUsd = 5;
    

    function fund() public payable{
        // Allow user to send $
        // Have a minimum $ sent
        // 1. How do we send ETH to this contract
        require(msg.value >= minimumUsd, "didn't send enough ETH");

        //What is a revert?
        // Undo any actions that have been done, and send the remaining gas back



    }
    function withdraw() public {}

    function getPrice() public {
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        //Abi
    }

    function getConversionRate() public {}

    function getVersion() public view returns (uint256){
      return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}


