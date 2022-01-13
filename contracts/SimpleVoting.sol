// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0;

import "./CommunityToken.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SimpleVoting is Ownable{
    mapping(uint256 => Proposal) proposals;

    uint256 countProposals = 0;

    enum VoteStatus{
        Missing,
        Approved,
        Declined    
    }

    struct Proposal{
        bool wasApproved;
        bool isCompleted;
        string name;
        string description;
        address creator;
        uint8 approvals;
        uint8 declines;
        address[] voters;
    }

    constructor() {
        
    }

    function propose(string memory name) public returns(uint256 proposalId){
        require(bytes(name).length != 0, "Enter a valid name!");
        proposalId = countProposals;
        Proposal storage newProposal = proposals[countProposals++];

        newProposal.wasApproved = false;
        newProposal.isCompleted = false;
        newProposal.name = name;
        newProposal.description = name;
        newProposal.creator = msg.sender;
    }
    
    function finishProposal(uint256 proposalId) public view returns(bool wasApproved){
        Proposal memory proposal = proposals[proposalId];

        proposal.wasApproved = wasApproved = proposal.approvals > proposal.declines;
        proposal.isCompleted = true;
    }

    function getProposal(uint256 proposalId) public view returns(Proposal memory proposal){
        proposal = proposals[proposalId];
    }

    function approve(uint256 proposalId) public {
        Proposal storage proposal = proposals[proposalId];
        
        require(!_addressExists(msg.sender, proposal.voters), "Already voted!");


        proposal.voters.push(msg.sender);
        proposal.approvals++;
    }

    function decline(uint256 proposalId) public {
        Proposal storage proposal = proposals[proposalId];
        
        require(!_addressExists(msg.sender, proposal.voters), "Already voted!");

        proposal.voters.push(msg.sender);
        proposal.declines++;
    }


    function _addressExists(address addrs, address[] memory addresses) private pure returns(bool) {
        for(uint256 i = 0; i < addresses.length; i++)        
        {
            if(addresses[i] == addrs){
                return true;
            }
        }

        return false;
    }
}