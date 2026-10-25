# playground topic dlq

📬 Dead letter queue commands

Read the dead letter queue of a sink connector  
(errors.tolerance=all with errors.deadletterqueue.topic.name, or the  
dlq-`<lcc id>` topic of a fully managed connector) without decoding  
its headers by hand, and send the records back once the cause is  
fixed.

- **inspect**: records grouped by error (exception, message, root cause, original topic, partition and offsets)
- **replay**: produce the records again to their original topic, or to `--to`

Without `--topic`, the dead letter queue of `--connector`, or of the only  
running connector that has one, is used.

The errors are in the __connect.errors.\* headers, which are only  
written with "errors.deadletterqueue.context.headers.enable": "true"  
(`playground connector snippets --dlq` has it).

👉 Example: https://github.com/vdesabou/kafka-docker-playground/tree/master/other/reprocess-dlq-messages-with-sink-connector

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-connector-troubleshooting  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%A9%BA-a-sink-is-running-but-writes-nothing

## Usage

```bash
playground topic dlq COMMAND
```

## Topic commands

- [inspect](playground%20topic%20dlq%20inspect) - 🩺 Show what is in a dead letter queue, grouped by error
- [replay](playground%20topic%20dlq%20replay) - 🔁 Produce the records of a dead letter queue again


