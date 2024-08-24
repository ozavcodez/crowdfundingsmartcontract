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
    bool ended;
 }
    address public owner;
    uint public campaignCount;
    mapping(uint => Campaign) public campaigns;


    // Events
    event CampaignCreated(uint campaignId, string title, string description, address benefactor, uint goal, uint deadline);
    event DonationReceived(uint campaignId, address donor, uint amount);
    event CampaignEnded(uint campaignId, uint amountRaised, address benefactor);

    // Modifier to check if the caller is the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    // Modifier to check if the campaign exists
    modifier campaignExists(uint _campaignId) {
        require(_campaignId < campaignCount, "Campaign does not exist");
        _;
    }

    // Modifier to check if the campaign has ended
    modifier notEnded(uint _campaignId) {
        require(!campaigns[_campaignId].ended, "Campaign has ended");
        _;
    }


 constructor(){
        owner = msg.sender;
    }
// create campaign
    function createCampaign(string memory _title, uint _goal, string memory _description,  address _benefactor, uint _duration) public {
        require(_goal > 0, "Goal must be greater than zero");
        require(_benefactor != address(0), "Invalid benefactor address");

        uint deadline = block.timestamp + _duration;
        campaigns[campaignCount] = Campaign({
            title: _title,
            description: _description,
            benefactor: _benefactor,
            goal: _goal,
            deadline: deadline,
            amountRaised: 0,
            ended: false
        });

        emit CampaignCreated(campaignCount, _title, _description, _benefactor, _goal, deadline);
        campaignCount++;

    }

    // user donation

    function donate(uint _campaignId) public payable campaignExists(_campaignId) notEnded(_campaignId) {
        Campaign storage campaign = campaigns[_campaignId];
        require(msg.value > 0, "Donation amount must be greater than zero");
        require(block.timestamp < campaign.deadline, "Campaign deadline has passed");

        campaign.amountRaised += msg.value;
        emit DonationReceived(_campaignId, msg.sender, msg.value);
    }

    // Function to end a campaign and transfer funds to the benefactor
    function endCampaign(uint _campaignId) public campaignExists(_campaignId) notEnded(_campaignId) {
        Campaign storage campaign = campaigns[_campaignId];
        require(block.timestamp >= campaign.deadline, "Campaign has not ended yet");
        require(!campaign.ended, "Campaign already ended");

        campaign.ended = true;
        payable(campaign.benefactor).transfer(campaign.amountRaised);

        emit CampaignEnded(_campaignId, campaign.amountRaised, campaign.benefactor);
    }

    // Function to withdraw leftover funds by the owner
    function withdrawFunds() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    // Fallback function to accept incoming Ether
    receive() external payable {}

 }


// Each campaign should have the following properties:
// title (string): The name of the campaign.
// description (string): A brief description of the campaign.
// benefactor (address): The address of the person or organization that will receive the funds.
// goal (uint): The fundraising goal (in wei).
// deadline (uint): The Unix timestamp when the campaign ends.
// amountRaised (uint): The total amount of funds raised so far.

// Users should be able to donate to any campaign of their choice by specifying the campaign ID.
// The donation amount should be added to the amountRaised of the selected campaign.
// The donation should only be accepted if the campaign's deadline has not passed.