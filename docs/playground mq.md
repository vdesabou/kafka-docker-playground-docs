# playground mq

📨 Message broker commands

Send messages to the broker of a source example, read what a sink wrote,  
and wait for a queue to fill up or to be drained by a connector, without  
docker exec and the client command line of each broker.

- **put**: send messages to a queue or a topic (`--message`, `--file` or stdin)
- **get**: show the messages of a queue without removing them
- **wait**: wait until a queue contains at least (or at most) N messages

Supported: IBM MQ (amqsput, amqsbcg, runmqsc in its container), RabbitMQ  
(rabbitmqctl, and rabbitmqadmin of the -management images, else the HTTP  
API of rabbitmq_management, enabled on the fly), MQTT with mosquitto  
(mosquitto_pub, mosquitto_sub), ActiveMQ classic (REST API and Jolokia)  
and Solace (REST messaging and SEMP). The HTTP APIs are called from a  
curl container that joins the network of the broker (curlimages/curl):  
nothing to install, no published port needed.

The broker is the only running container whose image is one of them  
(icr.io/ibm-messaging/mq, rabbitmq, eclipse-mosquitto, rmohr/activemq,  
solace/solace-pubsub-standard in the examples): pass `--container` when  
there are several, and `--broker` when the image name does not tell which  
broker it is.

The users and passwords come from the container environment  
(`RABBITMQ_DEFAULT_USER`, `MQ_QMGR_NAME`, username_admin_password...) and the  
defaults of the examples (myuser / mypassword for mosquitto, admin /  
admin for ActiveMQ): pass `--user` and `--password` for others.

🎓 Tip: in a source example, 'mq put' then 'topic consume  
`--min-expected-messages`', and 'mq wait `--max-expected-messages` 0' to  
check that the connector removed the messages from the queue.

☸️ cfk: everything runs in the broker pod with kubectl exec (the curl of  
the ActiveMQ and Solace images, rabbitmqadmin of the RabbitMQ -management  
images); RabbitMQ put / get with an image that has no rabbitmqadmin (the  
-alpine one) is not supported

## Usage

```bash
playground mq COMMAND
```

## Messaging commands

- [get](playground%20mq%20get) - 🔎 Show the messages of a queue, without removing them
- [put](playground%20mq%20put) - 📤 Send messages to a queue or a topic
- [wait](playground%20mq%20wait) - ⏳ Wait for a queue to contain at least (or at most) N messages


