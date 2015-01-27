# Workflow (Use Cases)

## In Scope

### Registering a Person

1. [PUT]: baseurl/person `{[person_info]}`

### Drafting a SC

1. [PUT]: baseurl/sc `{“title”: <string>, “descr”: <string>}`
1. [PUT]: baseurl/code `{“sc_id”: <GUID>, “version”: <string>, “code”: <TEXT>}`

### Setting the party(ies)

1. [PUT]: baseurl/sc_party `{“sc_id”: <GUID>, “person_id”: <GUID>, “role”: <GUID>}`

### Schedule an SC Event on a pending contract

1. [PUT]: baseurl/sc_event_sched `{“sc_id”: <GUID>, “event_id”: <GUID>, “timestamp”: <int>}`

### Negotiating a SC
Pre-condition: Workflow - Drafting a SC and Setting the party(ies)

1. (Making the proposal) [GET]: baseurl/sc/propose/{sc_id}/{code_id}
1. (Counterparty makes changes) [PUT]: baseurl/code `{“sc_id”: <GUID>, “version”: <string>, “code”: <TEXT>}`
1. (Making the proposal) [GET]: baseurl/sc/propose/{sc_id}/{code_id}
1. (Process can continue, but eventually signed) [GET]: baseurl/sc/sign/{sc_id}/{code_id}

## Not Yet in Scope

### Schedule an SC Event on a contract in effect
1. (Turn into a proposal) [PUT]: baseurl/sc_event_sched `{“sc_id”: <GUID>, “event_id”: <GUID>, “timestamp”: <int>}`
1. (Approve the event) [GET]: baseurl/sc_event_sched/approve/{sc_event_id}

### Amending a SC
Pre-condition: Workflow - Negotiating a SC

> Ask to copy events when new versions are created
