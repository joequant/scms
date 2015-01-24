Inventor: Samuel Bourque

Filer: New System Technologies Limited

Filing Date: [TBD]

Filing Number: [TBD]

---
# Title

**A SIMULATION SYSTEM FOR IDENTIFYING AND PREDICTING POSSIBLE OUTCOMES OF CONTRACTS**

---
# Summary

An information system that simulates a pre-defined set of scenarios of a contract. Said contract is to be firstly formatted as a Smart Contract[1], so that the authoritative version of the contract is drafted in machine interpretable scripting language. In order for this to work--other than the Smart Contract Management System--, there needs to be in place: (i) coding standards, and (ii) a simulation engine. This approach, in turn, enables the process of understanding a contract into a black-box process, rather than a white-box one.

[1] As defined in previous filing entitled: AN INFORMATION SYSTEM THAT AUTOMATES INTERPRETATION AND PERFORMANCE OF CONTRACTS INVOLVING DIGITAL ASSETS

---
# Description

## Introduction

Smart Contracts have several advantages over traditional paper contracts in that they provide automation, and enforce transparency of terms and disambiguation.

### Problem

The major drawback for Smart Contracts is that traditional contracts written in legalese are already rather difficult to understand. As such, having contracts drafted in machine interpretable scripting language compounds the complexity, and hence provides additional credibility to the argument that a possible claimant did not understand the terms, nor its outcome.

### Solution

The best way to approach this problem is to provide a black-box view of the contract; i.e. to examine all possible outcomes in terms of input and output. This is preferred over the white-box approach--i.e. reading the legal language--as the latter is complex, and generally does not represent the weaker party's understanding.

By getting all of the possible scenarios defined and simulated, we can then generate a simulation report that makes the contract much more predictable. This report may then be included as a schedule or exhibit to the contract, as evidence of its understanding by the parties. Hence, making the argument of lack of understanding rather untenable.

## Review

Prior to examining the system in question, the reader must first grasp the Smart Contract system, as defined in *AN INFORMATION SYSTEM THAT AUTOMATES INTERPRETATION AND PERFORMANCE OF CONTRACTS INVOLVING DIGITAL ASSETS*.

As, such, here's a brief recap.

### Smart Contract

A Smart Contract is formally defined as:

> **Smart Contract**: (noun) a digital record of a contract or agreement, which (1) contains terms that are machine interpretable and/or machine executable; (2) represents the actual agreement as accepted by signature; and (3) is stored and administered by a third party system.

The short description is that it is a contract drafted where its authoritative version is encapsulated within machine interpretable code. This is useful for: (i) automation, (ii) verifiability of parties, (iii) safekeeping of the contract, (iv) cost effectiveness, (v) predictability, (vi) disambiguity, (vii) reportability, (viii) recording of events, (ix) scalability and (x) automated analysis.

### Smart Contract Management System

A Smart Contract Management System is an information system that combines: (i) Client Relationship Management (CRM), (ii) Smart Contract interpretation, (iii) cryptographic services for signatures, and integrity, (iv) debugging tools, (v) integrated libraries, including APIs, and (vi) workflows for negotiation, dispute resolution and amendments.

## Standardization

To make this possible in a user-friendly and scalable way, we must make use of standardization in the code libraries.

### Events

The code composing the Smart Contracts shall be written using the event-driven methodology--i.e. that any type of event occurring that affects the contract is mapped to a function (or method). Given such a mapping of types of events to functions is required to the defining of scenarios.

### External Calls

Smart Contracts have the ability to make calls to external systems; such calls, to enable simulation, must use the integrated library tools available to make the request. Such libraries will compose all HTTP methods as defined in the Internet Engineering Task Force's (IETF) RFC 2616.

Such calls shall have a harness that intercepts simulated calls and injects pre-defined results.

This forces all external calls to be done as HTTP method calls.

## System Design

### Scenarios

Scenarios represent one possible outcome/contingency of a contract's lifecycle. It composes a timeline series of simulated events.

### Simulated Events

In order to run a scenario, a timeline of event must be defined--preferably in chronological order. As per the standards as established supra, each event shall be captured by a function; as such, the function may require parameters to be defined.

#### Preconditions

* That the scenarios are defined, and their parameters when needed.
* That the code is being run in Simulation Mode.

#### Process

1. Verify that the Smart Contract is run in Simulation Mode.
1. Process the event as specified as the callback
1. 

### External Call Stubs

The Smart Contract code may require making external calls to other systems as defined in the standards supra. The libraries will intercept the call and inject pre-defined data instead.

#### Preconditions

* That the scenarios are defined 

#### Process

When the code is being processed and runs into a library invocation for an external call.
1. Verify that the Smart Contract is run in Simulation Mode.
1. If so, then bypass the actual HTTP method
1. Look up the 

### Schema

The Database schema in Relational format is described in Schedule A.

## Example

### Description

### Smart Contract Code

### Scenarios



---
# Claims

1. 
