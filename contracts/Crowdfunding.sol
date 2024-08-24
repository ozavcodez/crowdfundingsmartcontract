// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;
contract CrowdFunding{
 struct Campaign{
    string title;
    string description;
    address benefactor;
    uint goal;
    uint deadline;
    uint amountRaised;
 }
address public owner;
uint public campaignCount;
mapping(uint => Campaign) public campaigns;

 constructor(){
        owner = msg.sender;
    }
// create campaign
    function createCampaign(string memory _title, uint _goal, string memory _description,  address _benefactor, uint _duration) public {

    }

    function donateCampaign() public {

    }

    function endCampaign() public {

    }
 }


// Each campaign should have the following properties:
// title (string): The name of the campaign.
// description (string): A brief description of the campaign.
// benefactor (address): The address of the person or organization that will receive the funds.
// goal (uint): The fundraising goal (in wei).
// deadline (uint): The Unix timestamp when the campaign ends.
// amountRaised (uint): The total amount of funds raised so far.