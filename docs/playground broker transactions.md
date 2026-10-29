# playground broker transactions

💱 Transaction commands

Inspect the transactions of the cluster and recover from hanging ones  
(wraps kafka-transactions). Works on plaintext, secured environments and  
cfk.

- **list**: transactional ids, coordinator and state
- **describe**: one transactional id: partitions, duration
- **describe-producers**: producers of a topic, open transactions
- **find-hanging**: transactions forgotten by their coordinator
- **abort**: abort a hanging transaction

An open transaction holds the last stable offset (LSO) of its partitions:  
read_committed consumers (sink connectors of a topic written by an  
exactly-once source, Kafka Streams with exactly_once_v2...) don't read  
past it, and their lag never drains. It ends when it commits, aborts, or  
after transaction.timeout.ms. A hanging transaction never ends: find it  
with find-hanging and abort it.

## Usage

```bash
playground broker transactions COMMAND
```

## Kafka commands

- [list](playground%20broker%20transactions%20list) - 📋 List the transactional ids
- [describe](playground%20broker%20transactions%20describe) - 🔎 Describe a transactional id
- [describe-producers](playground%20broker%20transactions%20describe-producers) - 🏭 Describe the active producers of a topic
- [find-hanging](playground%20broker%20transactions%20find-hanging) - 🧟 Find hanging transactions
- [abort](playground%20broker%20transactions%20abort) - 🧹 Abort a hanging transaction


