# Simulation Report Example

**Contract**: Ars_v_Man_2015_05_16

**Description**: A friendly bet between friends; Sam ("Player A") is betting on Arsenal, Henry ("Player B") is betting on ManU.

**Scenario List**:

1. Bet goes into effect
1. Player A's team wins
1. Player B's team wins
1. Game is tied
1. Bet not paid by a party
1. Game delayed
1. Game forfeited
1. 3rd party data supplier error--incorrect data
1. 3rd party data supplier error--invalid data
1. Bet underpaid
1. Bet overpaid

## Scenario 1: Bet goes into effect

This is a partial scenario examining the normal course of dealings to bring the contract into effect.

### Preconditions

None

### Events

Time Offset|Event|Parameters|External Calls|URL|Results
---|---|---|---|---|---
0|Check Balance||Balance from Blockchain|`blockchain.info/wallet/get_balance`|`{"balance":2}`

### Diagram

![Scenario 1](./images/scenario_1.png)


