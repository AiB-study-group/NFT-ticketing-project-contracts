// SPDX-License-Identifier: UNLICIENCE

pragma solidity 0.8.8;

/// @title NFTickets
/// @author AiB Study Group on 01/2022

contract NFTickets {
    //TODO: Needs more properties
    struct TicketDetails {
        uint256 purchasePrice;
        uint256 sellingPrice;
        bool forSale;
    }

    // Modifiers
    /// @notice This modifier restricts access of running the function assigned to this modifier to only the Contract Admin
    /// @dev This shouldn't be used everywhere, only when needed
    modifier onlyOwner() {
        _;
    }

    /// @notice This modifier restricts access of running the function assigned to this modifier to only the Event Manager Role
    modifier isEventManager() {
        _;
    }

    /// @notice This modifier restricts access of running the function assigned to this modifier to only the Event Attendee
    modifier isAttendee() {
        _;
    }

    // Functions

    /// @notice Create the Tickets NFT Collection of the Event
    /// @dev TODO: How we will determine the event manager if we're restricting it to isEventManager{} before assigning the event manager :D
    /// @param TODO: Parameters of the NFT Collection struct
    /// @return TODO: The whole NFT Collection ID? The NFT Collection as an array{bad idea I guess}?
    function createEvent() isEventManager {}

    /// @notice Allows the Contract Admin to disable a specific event before it's grace period has passed
    /// @dev Should check if the grace period has passed or not first
    /// @param TODO: eventID
    /// @return if the action of disabling the event has been successful or not
    function disableEvent() onlyOwner {}

    /// @notice This function allows the Attendee to buy the NFT Ticket after the grace period has passed and the tickets are available for sale
    /// @dev Should check if the grace period has passed first and the tickets are available for sale or not
    /// @param TODO: WIP
    /// @return IF the action is successful of not, and the id of the purchased Ticket NFT
    function buyTickets() {}

    /// @notice Allows the Attendee to request a refund {if certain criteria are met} and the middle-man here will be the contract itself. Contract fees aren't refundable.
    /// @dev Should check first if the event itself has finished or not? A refund grace period has passed or not? etc.,. Should subtract the contract fees when calculating the refund amount
    /// @param TODO: WIP
    /// @return If the refund request is successful or not
    function requestRefund() isAttendee {}

    /// @notice Allows the Event Manager to refund a specific attendee to disable/restrict his/her access to the event
    /// @dev Should check if specific criteria are met, like, event start and end dates, refund grace period, etc.,
    /// @param TODO: WIP
    /// @return If the refund request is successful or not
    function refundAttendee() isEventManager {}

    /// @notice Allows the Event Manager to refund all attendees all at once
    /// @dev Only the event manager should be allowed to make this action
    /// @param TODO: WIP
    /// @return If the refund request is successful or not
    function refundAll() isEventManager {}

    /// @notice Allows the contract admin to set and update the commission percentage of the contract fees
    /// @dev Only the contract admin is allowed to make this action
    /// @param TODO: WIP
    /// @return True or False
    function setCommissionPercentage() onlyOwner {}

    /// @notice Allows the Contract Admin to withdraw the fees stored in the contract to the ONLY ADDRESS allowed to be transferee
    /// @dev The transferee address should be declared once in the constructor of the contract or as a CONST variable at the top, and should't be editable
    /// @param TODO: WIP
    /// @return If the transfer is successful or not
    function withdrawCommissions() onlyOwner {}

    /// @notice Allows the msg.sender to be able to get the current price of the ticket, or the nft ticket collection
    /// @dev Should allow the msg.sender to specify an ID and a type of that ID {either it is a single ticket or an NFT Ticket Collection}
    /// @param TODO: WIP
    /// @return The current price of a specific ticket, or a specific NFT Ticket Collection
    function getTicketPrice() view returns () {}

    /// @notice Allows the msg.sender to get all the remaining IDs of the NFT Ticket Collection and their count
    /// @dev Is it a good idea to grab all the remaining IDs in a single array? Their should be a way of grabbing all the remaining ticket IDs tho.
    /// @param TODO: WIP
    /// @return The number of remaining tickets in a specific NFT Ticket Collection, in an array
    function getRemainingTickets() view returns () {}

    /// @notice Allows the msg.sender to get the event manager address/s of a specific event
    /// @dev
    /// @param TODO: WIP
    /// @return The address of the Event Manager/s of a specific event
    function getOrganizers() view returns () {}

    /// @notice Allows the msg.sender to get all the event managers address/s of all events
    /// @dev
    /// @param TODO: WIP
    /// @return The address of all Event Manager/s of all events
    function getAllOrganizers() view returns () {}

    /// @notice Allows the msg.sender to get all the tickets of a specific attendee/user/address for all events or specific ones
    /// @dev Should allow the msg.sender to specify an address and an ID for the event, if the ID is NULL it should return all available tickets for all events
    /// @param TODO: WIP
    /// @return Returns all tickets for specific event or for all events
    function getTicketCount() view returns () {} // is there a getBalanceOf() function that we can use?

    /// @notice Allow the msg.sender to get available events
    /// @dev Should allow the msg.sender to choose either to get all events including the disabled ones or only active and expired events
    /// @param TODO: WIP
    /// @return All available events that met the input data
    function getAllEvents() view returns () {}
}
