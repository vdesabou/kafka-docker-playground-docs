# playground topic dlq inspect

🩺 Show what is in a dead letter queue, grouped by error

Reads the whole dead letter queue (up to `--max-messages`) and groups  
the records by connector, stage (key / value converter,  
transformation, task put...) and exception, most frequent first.  
For each group: the exception and its message, the root cause (last  
"Caused by:" of the stack trace), the original topic, partition and  
offsets, the offsets in the dead letter queue and a sample value.

Keys and values are read as raw bytes, so it works whatever the  
format of the records (avro, protobuf, json schema, plain json).

👉 Example: https://github.com/vdesabou/kafka-docker-playground/tree/master/other/reprocess-dlq-messages-with-sink-connector

## Usage

```bash
playground topic dlq inspect [OPTIONS]
```

## Options

#### `--topic, -t TOPIC`

📬 Dead letter queue topic

ℹ️ If not set, the dead letter queue of `--connector`, or of the only running connector that has one

#### `--connector, -c CONNECTOR`

🔗 Connector whose dead letter queue is used (errors.deadletterqueue.topic.name, or dlq-`<lcc id>` for a fully managed connector)

#### `--max-messages MAX_MESSAGES`

🔢 Maximum number of records to read (default is 10000)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `10000`

#### `--grep REGEX`

🔎 Only the records whose exception class, message or root cause match this regex (java syntax)

#### `--json`

🤖 Print the groups as JSON

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground topic dlq inspect --topic dlq
```

```bash
playground topic dlq inspect --connector http-sink
```

```bash
playground topic dlq inspect --topic dlq --grep "Unknown magic byte"
```

## Example output

```text
$ playground topic dlq inspect --topic dlq
17:22:05 ℹ️ 🩺 Inspecting dead letter queue dlq
17:22:09 ℹ️ 📊 10 records in 1 group(s), most frequent first

🔢 10 record(s) of connector filestream-sink, stage VALUE_CONVERTER (io.confluent.connect.avro.AvroConverter)
  ❌ org.apache.kafka.connect.errors.DataException: Failed to deserialize data for topic filestream to Avro:
  🌱 root cause: org.apache.kafka.common.errors.SerializationException: Unknown magic byte!
  📍 original records: topic filestream partition 0 offsets 0..9 (10)
  📬 dlq partition 0 offsets 0..9
  🔎 sample value: {"f1":"value1"}

17:22:09 ℹ️ 🎓 replay them once the cause is fixed: playground topic dlq replay --topic dlq
```


