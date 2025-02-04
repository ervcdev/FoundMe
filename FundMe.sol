// Get funds from users
//witdrw funds
//set a minimum funding value in USD

//SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    AggregatorV3Interface internal priceFeed;

    constructor() {
        // Dirección del oráculo de ETH/USD en la red Ethereum Mainnet
        priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
    }

    uint256 public minimumUsd = 5e18;

    address[] public funders; 
    mapping(address => uint256) public addressToAmountFunded;

    //priceFeed = AggregatorV3Interface(0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43);

    function fund() public payable {
        // Allow user to send $
        // Have a minimum $ sent
        // 1. How do we send ETH to this contract
        require(
            getConversionRate(msg.value) >= minimumUsd,
            "didn't send enough ETH"
        );

        //What is a revert?
        funders.push(msg.sender);
        // Undo any actions that have been done, and send the remaining gas back
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    function getLatestPrice() public view returns (uint256) {
        (, int256 price, , , ) = priceFeed.latestRoundData();
        //price of ETH in terms of USD
        return uint256(price * 1e10);
    }

    function withdraw() public {}

    function getConversionRate(uint256 ethAmount)
        public
        view
        returns (uint256)
    {
        uint256 ethPrice = getLatestPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    function getVersion() public view returns (uint256) {
        return
            AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306)
                .version();
    }
}
