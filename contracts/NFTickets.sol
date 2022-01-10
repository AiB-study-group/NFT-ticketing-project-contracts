// SPDX-License-Identifier: UNLICIENCE

pragma solidity 0.8.8;

/// @title NFTickets
/// @author AiB Study Group on 01/2022

contract NFTickets {

  // Needs more properties
  struct TicketDetails {
    uint256 purchasePrice;
    uint256 sellingPrice;
    bool forSale;
  }

  // Modifiers
  modifier onlyOwner {}
  modifier isEventManager {}
  modifier isAttendee {}
  
  // Functions
  function createEvent() isEventManager {}
  function disableEvent() onlyOwner {}
  function buyTickets() {}
  function requestRefund() isAttendee {}
  function refundAttendee() isEventManager {}
  function refundAll() isEventManager {}
  function setCommissionPercentage() onlyOwner {}
  function withdrawCommissions() onlyOwner {}
  
  function getTicketPrice() view returns () {}
  function getRemainingTickets() view returns() {}
  function getOrganizers() view returns () {}
  function getTicketCount() view returns () {} // is there a getBalanceOf() function that we can use?
  function getAllEvents() view returns () {}
  

}
