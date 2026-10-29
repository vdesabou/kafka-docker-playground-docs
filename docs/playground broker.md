# playground broker

🖥️ Broker commands

- **config**: read and change dynamic broker configs
- **health**: brokers down, partition problems, KRaft quorum
- **stop / start**: stop (or kill) a broker, start it again
- **rolling-restart**: restart the brokers one by one, safely
- **transactions**: list transactions, find and abort hanging ones
- **describe**: brokers, KRaft quorum, feature levels, API versions
- **metrics**: key JMX metrics of each broker

Not available on Confluent Cloud and multi data center environments.

## Usage

```bash
playground broker COMMAND
```

## Kafka commands

- [config](playground%20broker%20config) - ⚙️ Dynamic broker config commands
  - [get](playground%20broker%20config%20get) - 🔎 Display dynamic broker configs
  - [set](playground%20broker%20config%20set) - ⚙️ Set a dynamic broker config
  - [delete](playground%20broker%20config%20delete) - 🗑️ Remove a dynamic broker config
- [health](playground%20broker%20health) - 🩺 Check the health of the cluster
- [stop](playground%20broker%20stop) - 🛑 Stop a broker
- [start](playground%20broker%20start) - ▶️ Start a broker stopped with `playground broker stop`
- [rolling-restart](playground%20broker%20rolling-restart) - 🔄 Restart the brokers one by one, like a rolling upgrade
- [transactions](playground%20broker%20transactions) - 💱 Transaction commands
  - [list](playground%20broker%20transactions%20list) - 📋 List the transactional ids
  - [describe](playground%20broker%20transactions%20describe) - 🔎 Describe a transactional id
  - [describe-producers](playground%20broker%20transactions%20describe-producers) - 🏭 Describe the active producers of a topic
  - [find-hanging](playground%20broker%20transactions%20find-hanging) - 🧟 Find hanging transactions
  - [abort](playground%20broker%20transactions%20abort) - 🧹 Abort a hanging transaction
- [describe](playground%20broker%20describe) - 🗺️ Describe the cluster
- [metrics](playground%20broker%20metrics) - 📈 Display the key JMX metrics of the brokers


