# playground mq put

📤 Send messages to a queue or a topic

One message per line, from `--message` (with `--nb-messages`, %g is  
replaced by 1, 2, 3...), `--file` or stdin (a heredoc). Empty lines are  
skipped.

- **IBM MQ**: amqsput to a queue, amqspub to a topic (local bindings: no channel, no user); `--header` is not supported
- **RabbitMQ**: published to the queue through the default exchange (rabbitmqadmin publish, or the HTTP API); a queue that does not exist is declared first (durable false, like the producer of the examples); `--header` sets AMQP headers
- **MQTT**: mosquitto_pub -l to a topic; `--header` sends MQTT 5 user properties
- **ActiveMQ**: REST API (POST /api/message), to a queue or a topic; `--header` sets JMS string properties
- **Solace**: REST messaging (port 9000, default message VPN), to a queue (it must exist) or a topic; `--header` is not supported

Exits with 1 when the broker refused a message, with 2 when it could  
not send (no broker, no destination, no message).

## Usage

```bash
playground mq put [OPTIONS]
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

#### `--message, -m MESSAGE`

✍️ Message to send (a template with %g when `--nb-messages` is set)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--file`

#### `--file, -f FILE`

📄 File with the messages, one per line

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--message`

#### `--nb-messages, -n NB_MESSAGES`

🔢 Send the message N times, %g replaced by 1..N

#### `--header HEADER`

🏷️ Property of the messages, key=value (repeat it for several)

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground mq put --queue myqueue --message '{"id": %g, "name": "product%g"}' --nb-messages 5
```

```bash
playground mq put --queue DEV.QUEUE.1 << 'EOF'
Message 1
Message 2
EOF
```

```bash
playground mq put --topic my-mqtt-topic --message sample-msg-1
```

```bash
playground mq put --queue DEV.QUEUE.1 --message hello --header source=playground --container activemq
```

## Example output

```text
$ playground mq put --container rabbitmq --queue orders --message '{"id": %g, "product": "product%g"}' --nb-messages 3 --header source=playground
16:01:32 ℹ️ 📤 Sending 3 message(s) to rabbitmq queue orders (rabbitmq, RabbitMQ vhost /, user myuser)
16:01:33 ℹ️ 🆕 declaring queue orders (durable=false) in vhost /
16:01:33 ℹ️ ✅ 3 message(s) sent to queue orders
```

```text
$ playground mq put --container mosquitto --topic my-mqtt-topic --message sample-msg-1
16:01:43 ℹ️ 📤 Sending 1 message(s) to mqtt topic my-mqtt-topic (mosquitto, MQTT (mosquitto), user myuser)
16:01:44 ℹ️ ✅ 1 message(s) sent to topic my-mqtt-topic
```


