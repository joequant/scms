# Libraries for Drafting Smart Contracts

## Introduction

This list of pre-defined functions are made available to drafters for ease-of-use.

The libraries are to be used to follow the standards that allow proper simulation, to generate simulation reports.

### Naming Convention

To easily recognize the library functions, they are encapsulated into two objects:

Class|Description
---|---
`fct`|All general functions to make external calls
`sc_fct`|All functions specific to the currenct contract

## Specifications

### Classes

Name|Description
`Sc`|The current Smart Contract
`ScEvent`|A scheduled event

### SC-specific libraries

All functions herein are methods of the `sc_fct` object.

Name|Invocation|Parameters|Returns|Description
---|---|---|---|---
Set Status|`set_sc_status`|`status`|none|Sets the status of the SC
Get Status|`get_status`|none|`ScStatus`|Returns the status of the SC
Get Value|`set_value`|`key, value`|none|Sets the value for the SC's specified key
Set Value|`get_value`|`key`|`String`|Returns the value of the specified key for the SC
Get Party|`get_party`|`role`|`Person`|Returns the person for the party with the specified role
Reassign Party|`reassign`|`role, assignee`|none|Reassigns the party for the specified role
Get all Scheduled Events|`get_sched_events`|none|`[ScEvents]`|Returns all scheduled events
Get Scheduled Events|`get_sched_event`|`event_name`|`ScEvent`|Returns scheduled event that match the name
Add Scheduled Events|`add_sched_event`|`ScEvent`|none|Adds a new scheduled event
Delete Scheduled Event|`rm_sched_event`|`ScEvent`|none|Deletes a scheduled event

### General libraries

All functions herein are methods of the `fct` object.

Name|Invocation|Parameters|Returns|Description
---|---|---|---|---
Synchronous HTTP Call|`sync_http_call`|`method, url, payload`|`String`|Makes a blocking external HTTP call
Asynchronous HTTP Call|`async_http_call`|`method, url, payload, callback`|`CallId`|Makes an non-blocking, asynchronous external HTTP call
Check HTTP Call|`check_http_call`|`call_id`|`[status, return_value]`|Check the return status of an asynchronous HTTP call
Get Wallet|`get_wallet`|`person, ccurr`|`Wallet`|Returns the person's cryptocurrency wallet
Check Balance|`get_ccurr_balance`|`wallet`|`Integer`|Returns the cryptocurrency wallet balance
Make Payment|`automate_payment`|`from_wallet, to_wallet, amount`|none|Makes a cryptocurrency payment
