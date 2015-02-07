# Database Schema

## Version 0.1

    * people
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
        * person_id
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
        * person_id
        * role_id
    * [Cryptocurrency]
        * ccrr_id
        * symbol
        * name
    * [wallets]
        * wallet_id
        * person_id
        * ccrr_id
        * address
    * [status]
        * status_id
        * name
    * [Value]
        * contract_id
        * key
        * value

## Version 0.2



## Version 1.0

## Version 1.1

## Version 2.0

