# playground mq wait

⏳ Wait for a queue to contain at least (or at most) N messages

Counts the messages of `--queue` every `--interval` seconds until there  
are at least `--min-expected-messages`, or at most  
`--max-expected-messages` (0: a source connector consumed them all),  
and fails after `--max-wait` seconds. A queue that does not exist yet  
counts as empty.

Counted with runmqsc (IBM MQ CURDEPTH), rabbitmqctl list_queues,  
the ActiveMQ admin queue list, Solace SEMP (up to 1000 spooled  
messages). MQTT keeps no queue: with `--topic`, the messages received  
while subscribed are counted, from now on.

## Usage

```bash
playground mq wait [OPTIONS]
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

#### `--min-expected-messages MIN_EXPECTED_MESSAGES`

🔢 Minimum number of messages to wait for (default is 1)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `1`

#### `--max-expected-messages MAX_EXPECTED_MESSAGES`

🔢 Wait until the queue has at most N messages (0: drained by a source connector)

#### `--max-wait MAX_WAIT`

⏳ Max time in seconds to wait (default is 120)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `120`

#### `--interval INTERVAL`

🔁 Interval in seconds between checks (default is 5)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `5`

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground mq wait --queue DEV.QUEUE.1 --min-expected-messages 3
```

```bash
playground mq wait --queue myqueue --max-expected-messages 0 --max-wait 60
```

```bash
playground mq wait --topic sink-messages --min-expected-messages 1
```

## Example output

```text
$ playground mq wait --container rabbitmq --queue orders --min-expected-messages 3 --interval 2
16:01:37 ℹ️ ⏳ Waiting up to 120 seconds for queue orders to contain at least 3 message(s) (rabbitmq, RabbitMQ vhost /, user myuser)
16:01:38 ℹ️ ✅ queue orders contains 3 message(s) (expected at least 3) after 0 seconds
```

```text
$ playground mq wait --container ibmmq --queue DEV.QUEUE.3 --max-expected-messages 0 --max-wait 4 --interval 2
16:01:38 ℹ️ ⏳ Waiting up to 4 seconds for queue DEV.QUEUE.3 to contain at most 0 message(s) (ibmmq, IBM MQ queue manager QM1)
16:01:38 ℹ️ ⌛ queue DEV.QUEUE.3 contains 2 message(s)
16:01:43 🔥 ❌ queue DEV.QUEUE.3 contains 2 message(s) after 4 seconds, expected at most 0
```


