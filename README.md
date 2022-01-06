# Contract Workflow

## Contract Description

### Description

```text

```

### Workflow from the `Contract Admin` point of view

### Workflow from the `Event Manager` point of view

### Workflow from the `Event Attendants` point of view

---

## Data

* How many events are their (Total events in circulation)
* Event Managers addresses
* Events attendees and their balances
* Unique ID for each ticket to be stored on IPFS
* Unique ID for each event to be stored on IPFS
* A way to concatenate EventID with TicketID to generate the IPFS ID, so we will be storing only one unique ID matching the event and the ticket

### Data that need to be stored on the blockchain and their visibility

---

## Design Patterns

1. ERC-721 VS ERC-1155 (I propose for ERC-1155 but don't know how to fix the problem in #2 using ERC-1155 yet)

2. How the contract will have multiple NFTs, if each event will be having their own unique quantity? (Metadata of all the events will be the same for now, like `Name, price, quantity, etc.,`)

3. Should the NFT Tickets for any event be minted all at once? Should the Event Manager address be the only one who is capable of transferring the NFTs to event users? Or should all the NFTs be minted at once, but users can transfer them alongside with the event manager to their wallets using the contract?
