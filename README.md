# Contract Workflow

## Contract Description

### Description

```text
An NFT enabled tickets mechanism that allows event creators to easily create and maintain long term relationships with their fans. And it also enables users/attendees a way of proofing they were attending a specific event at a given point of time as an NFT that lives on the blockchain as-long-as this specific blockchain exists.
```

### Workflow from the `Contract Admin` point of view

```text
1. Admin will deploy the contract and set the owner/s
2. Admin will set the commission percentage that will be deducted by the contract as fees. This percentage needs to be flexible so it can easily follow the supply and demand economic model
3. Admin will have specific roles to disable specific events that doesn't follow terms and conditions agreed upon
4. Admin will be able to withdraw the funds/fees held by the contract to a predefined address (this address maybe a multi-sig wallet that owners of the contract can all withdraw from when withdrawal conditions are met)
5. Admin can't change, alter, transfer, edit, any of the events' details. He/she are only allowed to disable the whole event or leave it running

```

### Workflow from the `Event Manager` point of view

```text
1. Event admin will be able to create, update, disable his/her events
2. Event admin will be able to refund attendees for the tickets. The fees of the contract will not be refunded.
3. Event admin will have a simple web panel for him/her to be able to do #1 and #2

```

### Workflow from the `Event Attendants` point of view

```text
1. A user will be able to buy a ticket
2. A user will be able to request a refund for their tickets
3. A user will be able to hold more than one NFT for multiple related or different events on the same address

```

---

## Data

### Data that need to be stored on the blockchain and their visibility

* How many events are their (Total events created and are in circulation)
* Event Managers addresses
* Events attendees and their balances
* Unique ID for each ticket to be stored on IPFS
* Unique ID for each event to be stored on IPFS
* A way to concatenate EventID with TicketID to generate the IPFS ID, so we will be storing only one unique ID matching the event and the ticket
* Event start and expiry dates

---

## Design Patterns

1. ERC-721 VS ERC-1155 (I propose for ERC-1155 but don't know how to fix the problem in #2 using ERC-1155 yet)

2. How the contract will have multiple NFTs, if each event will be having their own unique quantity? (Metadata of all the events will be the same for now, like `Name, price, quantity, etc.,`)

3. Should the NFT Tickets for any event be minted all at once? Should the Event Manager address be the only one who is capable of transferring the NFTs to event users? Or should all the NFTs be minted at once, but users can transfer them alongside with the event manager to their wallets using the contract?
