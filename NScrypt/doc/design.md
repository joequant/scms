-----------------
￼CryptoLaw © Copyright 2015

www.crypto-law.com

￼￼Unit B, 18/F, Li Dong Building

11 Yuen Street East, Central

Hong Kong

------------------

STRICTLY CONFIDENTIAL

NScrypt – Smart Contract Management System
￼Design Architecture

Author: Samuel Bourque 

￼Version: 0.9

Date: 2 December 2014

---------------

# Introduction
## Purpose
The purpose of this document is to capture the design as intended for CryptoLaw’s NScrypt Smart Contract Management System.

This document is intended to evolve over time.

## Overview
The NScrypt system is a system that combines user profiles management and their contractual agreements, and provides a development platform to draft and edit said contracts.

## Scope
This document limits the discussion to a cursory introduction of the concepts of Smart Contracts, and focuses on the design and architecture requirements of NScrypt.

No visual specifications (such as User Interface) are described herein; rather only logical overview of the architecture and design.
￼
# Smart Contracts

## Overview

The general idea is for a development platform for contractual agreements. As such, it combines many concepts of Technology and Law, in order to allow the construction of legally binding self-executing contracts.

## Hierarchy

### Smart Contracts

A Smart Contract (“SC”) is essentially a contract that is drafted in scripting language instead of natural language. As such, can be interpreted, executed, tested, simulated, stored, copied, encrypted, edited, tracked, etc.

### Smart Contract Platform

A Smart Contract Platform (“SCP”) is an interpreter and executer of SCs. It includes a data store for SC’s state data; optionally it includes libraries for code-reuse.

### Smart Contract Management System

A Smart Contract Management System (“SCMS”) is a system that manages user profiles and their SCs. It includes functionality for user privileges and legal workflow management.

# Version 1.0 Scope

The scope of features to be implemented for Version 1.0 is as follows:

* Basic User Management
 * Profiles
 * Privileges
* Development Platform
 * Contract Repository
 * Editor
* Workflow Management
 * Proposal
 * Amendment
* Cryptography
 * Key Management
 * Signature & Hash
 * Encryption
* SC Interface
 * Standard Reporting
 * Email Notices
* External Calls
 * Bitcoin Support
 * HTTP Methods
￼
Note: All features above are to be implemented—where appropriate—as both API and View functionality.

# Technology Stack

The following technologies are to be used:
* Model
 * MySql
* Controller
 * Linux
 * Python

# Design
## Overview

* API
 * REST, JSON
* View
 * ExtJS

The design follows a MVC paradigm. The focus herein is more on the Controller, as clients may implement their own View.

## Model

Here are a list of tables and respective columns([] means to-be-implemented).
Note that created_at and updated_at columns are added to each table by default.

    * users
        * id
        * [contact_info]
    * roles
        * id
        * name       
    * contracts
        * id
        * title
        * description
        * code_id -- FK, the code that is in effect
    * codes
        * id
        * contract_id -- FK, the contract that this code belongs to
        * version
        * code -- code content
    * sc_events
        * id
        * code_id -- FK, the code that should get evaluated when this sc_event gets triggered
        * callback -- name of the function in the code
    * parties
        * id
        * code_id
        * user_id
        * role_id
        * status
    * schedules
        * id
        * sc_event_id
        * timestamp
        * argument -- cron arguments
        * recurrent -- this column can be removed if one-time or recurrent is defined in cron argument
        * status
    * [privileges]
        * user_id
        * role_id
    * [Cryptocurrency]
        * ccrr_id
        * symbol
        * name
    * [wallets]
        * wallet_id
        * user_id
        * ccrr_id
        * address
    * [status]
        * status_id
        * name
    * [Value]
        * contract_id
        * key
        * value
        
￼
Note: All tables herein are to have a duplicate with the suffix ‘_history,’ which has two additional columns: ‘start_date’ and ‘end_date.’

## Controller

The basic design mirrors that of a courthouse.

### Interpreter

The Interpreter simply interprets (runs) the SC’s code.

### Executor

The Executor executes commands from the SC when: (1) commanded by the interpreter, and (2) set to production mode.

### Clerk

The Clerk schedules SCs to the interpreter when called by: (1) events, or (2) API calls.

### Registrar

The Registrar handles all CRUD operations for: (1) users, (2) privileges, (3) contracts, and (4) parties.

The Registrar also handles all cryptographic functions, including signing.

### Library

The library is a collection of helpful snippets for reuse across SCs. They fall into various categories: (1) external calls, (2) internal calls and (3) reporting; see section Library.
Depending on the category, it either makes for an (1) External Adapter, (2) SC Adapter, or (3) Internal Library, respectively.

### API/View
Please set up the environment and browse all the API/View relationships at http://{baseurl:port}/routes
e.g. http://localhost:3000/routes

# Library
## References
### Generate Bootstrap views for model
https://github.com/seyhunak/twitter-bootstrap-rails
### Implement login/logout/session
https://github.com/ryanb/railscasts-episodes/tree/master/episode-250
### Implement OmniAuth
http://railscasts.com/episodes/241-simple-omniauth

## External calls

### Bitcoin

Basic functions for Bitcoin handling; such as: (1) balance, (2) transaction verification, and (3) automate transfer.

### Email

The basic function of sending pre-defined email from the SC’s own email account.

### HTTP Methods

The basic function of making pre-defined GET and POST method HTTP calls.

## Internal calls

### Values

The basic function of CRUD SC-specific values, including the SC’s status.

## Reporting

### Standard Report

The basic function of responding to report calls to produce a report.
