// SPDX-License-Identifier: UNLICIENCE

pragma solidity 0.8.8;

/// @title NFTTickets
/// @author AiB Study Group on 01/2022

import "@openzeppelin/contracts/access/Ownable.sol";
import "./TicketNFT.sol";

contract NFTTickets is Ownable, TicketNFT {

    struct Event {
        uint256 eventId;
        address eventManager; 
        uint256 maxTicketsCount; 
        uint256 startDate; 
        uint256 endDate; 
        bool isApproved; 
        bool isSaleReady; 
        uint256[] pricesForEachTicketType;
        Ticket[] ticketsMinted; 
        string metadataURI;
    }

    struct Ticket {
        uint256 eventId; // Linked Event ID
        uint256 ticketId; // ticketId is the tokenId
        TicketType ticketType;
        uint256 purchaseDate; //EPOCH date of ticket purchase date
        uint256 price;
    }

    enum TicketType {SPEAKER, ORGANIZER, ATTENDEE, SPONSOR}

    mapping (uint256 => Event) public eventsDB;
    mapping (uint256 => mapping (uint256 => Ticket)) public eventTickets;
    mapping(uint256 => address) public managerOfEvent;

    event EventCreated(uint256 eventId);
    event SaleStarted(uint256 eventId, uint256 maxTicketsCount, bool isSaleReady);

    // Modifiers

    modifier isEventManager(uint256 eventID_) {
        require(
            eventsDB[eventID_].eventManager == msg.sender,
            "Only Event Managers are allowed to do this action"
        );
        _;
    }

    modifier isSaleReady(uint256 eventID_) {
        require(
            eventsDB[eventID_].isSaleReady == true,
            "Event ticket sales should be approved first"
        );
        _;
    }

    // Functions
    function generateRandNum() public view returns (uint256) {
        uint256 randomNumber = uint256(
            keccak256(
                abi.encodePacked(
                    block.number,
                    block.difficulty,
                    block.timestamp,
                    msg.sender
                )
            )
        );
        return (randomNumber % (1000000 - 100000)) + 100000;
    }

    function createEvent(
        uint256 amount_,
        uint256 startDate_,
        uint256 endDate_,
        uint256[] memory prices_,
        string memory metadataURI_
    ) public payable {
        uint256 _eventID = generateRandNum();

        eventsDB[_eventID].eventId = _eventID;
        eventsDB[_eventID].eventManager = msg.sender;
        eventsDB[_eventID].maxTicketsCount = amount_;
        eventsDB[_eventID].startDate = startDate_;
        eventsDB[_eventID].endDate = endDate_;
        eventsDB[_eventID].pricesForEachTicketType = prices_;
        eventsDB[_eventID].metadataURI = metadataURI_;

        emit EventCreated(_eventID);
    }

    function approveEvent(uint256 eventID_) public onlyOwner returns (bool) {
        require(eventsDB[eventID_].eventId > 0, "Event Not Found");

        require(
            eventsDB[eventID_].isApproved == false,
            "Event already approved before"
        );

        eventsDB[eventID_].isApproved = true;

        return true;
    }

    function allowTicketsSale(uint256 eventID_)
        public
        isEventManager(eventID_)
    {
        require(eventsDB[eventID_].eventId > 0, "Event Not Found");

        require(
            eventsDB[eventID_].isApproved == true,
            "Event should be approved first by the contract admin"
        );

        require(
            eventsDB[eventID_].isSaleReady == false,
            "Event ticket sales already approved by an event manager"
        );

        require(
            eventsDB[eventID_].endDate > block.timestamp,
            "Event has already been ended"
        );

        eventsDB[eventID_].isSaleReady = true; 

        emit SaleStarted(eventID_, eventsDB[eventID_].maxTicketsCount, eventsDB[eventID_].isSaleReady);
    }

    function getTicketPrice(uint256 eventID_, TicketType type_) private view returns (uint256) {

        uint256 price;

        if(type_ == TicketType.SPEAKER) {
            price = eventsDB[eventID_].pricesForEachTicketType[0];
        } else if (type_ == TicketType.ORGANIZER) {
            price = eventsDB[eventID_].pricesForEachTicketType[1];
        } else if (type_ == TicketType.ATTENDEE) {
            price = eventsDB[eventID_].pricesForEachTicketType[2];
        } else if (type_ == TicketType.SPONSOR) {
            price = eventsDB[eventID_].pricesForEachTicketType[3];
        }

        return price;

    }

    function buyTickets(uint256 eventID_, uint256 numOfTickets_, TicketType type_)
        public
        payable
        isSaleReady(eventID_)
    {
        require(
            eventsDB[eventID_].endDate > block.timestamp,
            "Event should be started first and/or shouldn't be ended too"
        );

        require(
            numOfTickets_ > 0 &&
                eventsDB[eventID_].maxTicketsCount >= // Number of max allowed tickets to be sold
                (eventsDB[eventID_].ticketsMinted.length + numOfTickets_), // Number of already purchased tickets
            "You must supply an amount of tickets that is less than the max allowed tickets to be ever sold"
        );

        uint256 totalPrice = getTicketPrice(eventID_, type_) * numOfTickets_;

        require(
            msg.sender.balance >= totalPrice,
            "Please transfer some ETHer to your wallet first"
        );

        require(msg.value >= totalPrice, "Insufficient amount of ETHer sent");

        uint256 remainingAmount = totalPrice - msg.value;

        (bool sent,) = msg.sender.call{value: remainingAmount}("");

        require(sent, "Failed to send remaining Ether back to the client");

        for (uint256 i = 0; i < numOfTickets_; i++) {

            uint256 tkId = mintNFT(msg.sender, eventsDB[eventID_].metadataURI);

            uint256 tkPrice = getTicketPrice(eventID_, type_);

            eventsDB[eventID_].ticketsMinted.push(
                Ticket(
                    eventID_,
                    tkId,
                    type_,
                    block.timestamp,
                    tkPrice
                )
            );

            eventTickets[eventID_][tkId] = Ticket(
                eventID_,
                tkId,
                type_,
                block.timestamp,
                tkPrice
            );

        }
    }
}