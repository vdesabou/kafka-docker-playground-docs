# playground mq get

🔎 Show the messages of a queue, without removing them

A source connector reads the same queue: 'mq get' never takes its  
messages away.

- **IBM MQ**: amqsbcg browses the queue (body, MsgId, Format, properties)
- **RabbitMQ**: rabbitmqadmin get (or the HTTP API) reads the messages and puts them back (ackmode ack_requeue_true): they stay in the queue, marked redelivered; the exchange and routing key are shown
- **ActiveMQ**: Jolokia browse() of the queue (body, JMSMessageID, properties)
- **Solace**: SEMP lists the spooled messages: their id, size and time, not their body (SEMP does not return it)
- **MQTT**: no queue: subscribes to `--topic` for `--timeout` seconds and prints what arrives (and the retained message)

`--json` prints a json array of {"id", "body", "headers"}.

## Usage

```bash
playground mq get [OPTIONS]
```

## Options

#### `--container, -c CONTAINER`

🐳 Container of the broker

ℹ️ If not set, the only running container whose image is a supported broker

#### `--broker BROKER`

📨 Broker of `--container`, when the image name does not tell it

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `ibmmq`, `rabbitmq`, `mqtt`, `activemq`, `solace`

#### `--user, -u USER`

👤 User (RabbitMQ, MQTT, ActiveMQ, Solace SEMP)

ℹ️ If not set, from the container environment, else the user of the examples

#### `--password PASSWORD`

🔑 Password of `--user`

#### `--vhost VHOST`

🏠 RabbitMQ virtual host (default is /)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `/`

#### `--vpn VPN`

🏠 Solace message VPN (default is default)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `default`

#### `--queue, -q QUEUE`

📥 Queue

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--topic`

#### `--topic, -t TOPIC`

📢 Topic (MQTT; also IBM MQ, ActiveMQ and Solace for put)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--queue`

#### `--max-messages MAX_MESSAGES`

🔢 Maximum number of messages to show (default is 100)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `100`

#### `--timeout TIMEOUT`

⏳ MQTT: seconds to stay subscribed (default is 10)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `10`

#### `--json`

🤖 Print the messages as a json array

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground mq get --queue DEV.QUEUE.1
```

```bash
playground mq get --queue myqueue --max-messages 5 --json
```

```bash
playground mq get --topic sink-messages --timeout 30
```

## Example output

```text
$ playground mq get --container rabbitmq --queue orders
16:01:34 ℹ️ 🔎 Browsing queue orders (rabbitmq, RabbitMQ vhost /, user myuser): read and requeued, the messages stay in the queue (marked redelivered)
#1 {"id": 1, "product": "product1"}
   source=playground
#2 {"id": 2, "product": "product2"}
   source=playground
#3 {"id": 3, "product": "product3"}
   source=playground
📬 3 message(s) in queue orders
```

```text
$ playground mq get --container ibmmq --queue DEV.QUEUE.3
16:01:36 ℹ️ 🔎 Browsing queue DEV.QUEUE.3 (ibmmq, IBM MQ queue manager QM1), the messages stay in the queue
#1 Message 1
   id=414D5120514D312020202020202020206D47086B012F0040, format=MQSTR, put_time=2026-11-26 15:01:35
#2 Message 2
   id=414D5120514D312020202020202020206D47086B022F0040, format=MQSTR, put_time=2026-11-26 15:01:35
📬 2 message(s) in queue DEV.QUEUE.3
```


