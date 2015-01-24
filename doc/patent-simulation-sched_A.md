# Database Tables

## Previously Required Tables

SC_STATUS||Lookup table for Smart Contract status
:---|:---|:---
`sc_status_id`|`integer`|Primary key
`name`|`varchar`|Human readable description


SMART_CONTRACT||Defines Smart Contracts
:---|:---|:---
`sc_id`|`integer`|Primary key
`sc_status_id`|`integer`|Foreign key to SC_STATUS
`name`|`varchar`|Smart Contract name
`descr`|`varchar`|Description

SC_CODE||Tracks versions of code
:---|:---|:---
`sc_code_id`|`integer`|Primary key
`sc_id`|`integer`|Foreign key to SMART_CONTRACT
`version`|`varchar`|Unique version identifier for the code

SC_VALUE||Records real-time values of contracts
:---|:---|:---
`sc_code_id`|`integer`|Foreign key to SC_CODE
`key`|`varchar`|Unique identifier acting as variable name
`value`|`varchar`|Acts as the variable's value

## New Tables

CODE_EVENT||Generated table that tracks events in contracts
:---|:---|:---
`code_event_id`|`integer`|Primary key
`sc_code_id`|`integer`|Foreign key to SC_CODE
`callback`|`varchar`|The function name for the event
`param_list`|`varchar`|The parameter list for invocation

CODE_EXT_CALL||Generated table that tracks external calls in contracts
:---|:---|:---
`code_ext_call_id`|`integer`|Primary key
`code_event_id`|`integer`|Foreign key to CODE_EVENT
`tag`|`varchar`|An optional identifier for the external call
`param_list`|`varchar`|The parameter list for invocation

SCENARIO||Defines Scenarios
:---|:---|:---
`scenario_id`|`integer`|Primary key
`sc_code_id`|`integer`|Foreign key to SC_CODE
`name`|`varchar`|A unique identifier
`descr`|`varchar`|Description

SCENARIO_EVENT||Defines the events in a scenario
:---|:---|:---
`scenario_event_id`|`integer`|Primary key
`scenario_id`|`integer`|Foreign key to SCENARIO
`code_event_id`|`integer`|Foreign key to CODE_EVENT
`schedule`|`varchar`|Describes when the event is to be called
`params`|`varchar`|Specifies parameters for the invocation

SCENARIO_EXT_CALL||Defines the external call interception
:---|:---|:---
`scenario_ext_call_id`|`integer`|Primary key
`code_ext_call_id`|`integer`|Foreign key to CODE_EXT_CALL
`return_value`|`varchar`|Specifies code to be processed instead of the external call

SCENARIO_RUN||Tracks a simulation run
:---|:---|:---
`scenario_run_id`|`integer`|Primary key
`scenario_id`|`integer`|Foreign key to SCENARIO
`timestamp`|`datetime`|When the run was simulated

SCENARIO_VALUE||Records values from a scneario
:---|:---|:---
`scenario_run_id`|`integer`|Foreign key to SCENARIO_RUN
`key`|`varchar`|Acts as a variable name
`value`|`varchar`|Acts as the value for the variable

SCENARIO_NOTE||Record messages from a scenario
:---|:---|:---
`scenario_run_id`|`integer`|Foreign key to SCENARIO_RUN
`note`|`varchar`|Records trace messages
