# API

## Person

Action|Method|URL|Payload
:---|:---|:---|:---
Create a person|PUT|baseurl/person|`{[person_info]}`
Retrieve a person|GET|baseurl/person/{id}|
Update a person|POST|baseurl/person/{id}|`{[person_info]}`
Delete a person|DELETE|baseurl/person/{id}|

## Smart Contract

Action|Method|URL|Payload
:---|:---|:---|:---
Create a SC|PUT|baseurl/sc|`{“title”: <string>, “descr”: <string>}`
Retrieve a SC|GET|baseurl/sc/{id}|
Update a SC|POST|baseurl/sc/{id}|`{“title”: <string>, “descr”: <string>}`
Delete a SC|DELETE|baseurl/sc/{id}|
List SC for a person|GET|baseurl/sc/list|

## Code Version

Action|Method|URL|Payload
:---|:---|:---|:---
Create code|PUT|baseurl/code|`{“sc_id”: <GUID>, “version”: <string>, “code”: <TEXT>}`
Retrieve code|GET|baseurl/code/{id}|
Update code|POST|baseurl/code/{id}|`{“sc_id”: <GUID>, “version”: <string>, “code”: <TEXT>}`
Delete code|DELETE|baseurl/code/{id}|
List code versions|GET|baseurl/code/{sc_id}|
Propose a SC|GET|baseurl/sc/propose/{sc_id}/{code_id}|
Sign a SC|GET|baseurl/sc/sign/{sc_id}/{code_id}|

## Smart Contract Event

Action|Method|URL|Payload
:---|:---|:---|:---
Manually trigger a SC_Event|POST|baseurl/sc_event|`{“sc_id”: <GUID>, “event_id”: <GUID>, “params”: <JSON_string>}`
List SC Events|GET|baseurl/sc_event/list/{sc_id}|

## SC_Event Schedule

Need to support both one-time and recurrent schedule.

Action|Method|URL|Payload
:---|:---|:---|:---
Create a SC_Event|PUT|baseurl/sc_event_sched|`{“sc_id”: <GUID>, “event_id”: <GUID>, “timestamp”: <int>}`
Retrieve a SC_Event|GET|baseurl/sc_event_sched/{id}|
Update a SC_Event|POST|baseurl/sc_event_sched|`{“sc_id”: <GUID>, “event_id”: <GUID>, “timestamp”: <int>}`
Delete a SC_Event|DELETE|baseurl/sc_event_sched/{id}|
List SC Event Schedules|GET|baseurl/sc_event_sched/list/{sc_id}|
Approve SC Event Schedule|GET|baseurl/sc_event_sched/approve/{sc_event_id}|
Disapprove SC Event Schedule|GET|baseurl/sc_event_sched/disapprove/{sc_event_id}|

## Smart Contract Report

Action|Method|URL|Payload
:---|:---|:---|:---
Generate Real-time Report|GET|baseurl/sc_report/{id}|

## Party

Action|Method|URL|Payload
:---|:---|:---|:---
Create a Party|PUT|baseurl/sc_party|`{“sc_id”: <GUID>, “person_id”: <GUID>, “role”: <GUID>}`
Retrieve a party|GET|baseurl/sc_party/{id}|
Update a party|POST|baseurl/sc_party/{id}|`{“sc_id”: <GUID>, “person_id”: <GUID>, “role”: <GUID>}`
Delete a party|DELETE|baseurl/sc_party/{id}|
List parties of a SC|GET|baseurl/sc_party/list/{sc_id}|

