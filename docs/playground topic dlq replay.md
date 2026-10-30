# playground topic dlq replay

🔁 Produce the records of a dead letter queue again

Once the cause is fixed (converter, schema, mapping...), sends the  
records back to the topic they came from (their  
__connect.errors.topic header), or to `--to`, so that the sink  
connector processes them again. Keys, values, timestamps and the  
other headers are kept as they are (raw bytes), the  
__connect.errors.\* headers are removed unless  
`--keep-error-headers` is set.

Only the records already in the dead letter queue when the command  
starts are read, and they are not deleted from it: a record that  
fails again is added to the dead letter queue a second time.

🎓 Tip: `--dry-run` shows how many records would go to which topic,  
and `--grep` replays only one kind of error.

👉 Example: https://github.com/vdesabou/kafka-docker-playground/tree/master/other/reprocess-dlq-messages-with-sink-connector

## Usage

```bash
playground topic dlq replay [OPTIONS]
```

## Options

#### `--topic, -t TOPIC`

📬 Dead letter queue topic

ℹ️ If not set, the dead letter queue of `--connector`, or of the only running connector that has one

#### `--connector, -c CONNECTOR`

🔗 Connector whose dead letter queue is used (errors.deadletterqueue.topic.name, or dlq-`<lcc id>` for a fully managed connector)

#### `--to TO`

📤 Topic to produce to

ℹ️ If not set, each record goes back to its original topic (__connect.errors.topic header)

#### `--max-messages MAX_MESSAGES`

🔢 Maximum number of records to read (default is 10000)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `10000`

#### `--grep REGEX`

🔎 Only the records whose exception class, message or root cause match this regex (java syntax)

#### `--keep-error-headers`

🏷️ Keep the __connect.errors.\* headers on the replayed records

#### `--dry-run`

🧪 Only display how many records would be replayed, and to which topics

#### `--verbose, -v`

🐞 Show command being ran.

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

## Examples

```bash
playground topic dlq replay --topic dlq --dry-run
```

```bash
playground topic dlq replay --topic dlq
```

```bash
playground topic dlq replay --connector http-sink --grep "Unknown magic byte" --to retry-topic
```

## Example output

```text
$ playground topic dlq replay --topic dlq
17:22:05 ℹ️ 🔁 Replaying dead letter queue dlq to the original topics (__connect.errors.topic header)
  📤 10 record(s) to topic filestream
17:22:09 ℹ️ ✅ 10 records replayed
```


