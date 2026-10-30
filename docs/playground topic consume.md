# playground topic consume

📥 Consume topic from beginning

Reads from the earliest offset and deserialises records on its own:  
the subjects `<topic>`-key and `<topic>`-value of Schema Registry decide  
between the avro, protobuf, json schema and plain console consumers  
(use `--key-subject` / `--value-subject` for other subject names).

🎓 Tip: `--min-expected-messages` turns it into an assertion. It waits  
up to `--timeout` for that many records, consumes them and fails if  
fewer could be consumed (records that cannot be deserialized do not  
count), which is how examples verify that data actually flowed.

The consumer stops when no record arrives for 10 seconds (30 seconds  
on Confluent Cloud), so it never waits for records that cannot come  
(transaction markers and compacted records use offsets).

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-topic-consume  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%93%A5-read-a-topic

## Usage

```bash
playground topic consume [OPTIONS]
```

## Options

#### `--verbose, -v`

🐞 Show command being ran.

#### `--topic, -t TOPIC`

🗳 Topic name

#### `--max-messages MAX-MESSAGES`

Max number of messages to display (default is 100)

You can use -1 to display all messages

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `100`

#### `--min-expected-messages MIN-EXPECTED-MESSAGES`

Minimum expected number of records to be consumed from the topic, returns an error if this is not the case

Records that cannot be deserialized are reported and do not count.

Note: `--topic` should be specified in this case.

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `0`

#### `--grep GREP`

Verify that topic content contains record which contains specified string

It is searched in the records as displayed (decoded when base64 encoded), and the command fails when no record contains it.

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | ``

#### `--timeout TIMEOUT`

Max number of seconds to wait when `--min-expected-messages` is used.

Default is 60 seconds

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `60`

#### `--tail`

Tail on logs.

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--min-expected-messages`, `--max-messages`, `--open`

#### `--key-subject KEY-SUBJECT`

📛 Subject for key in schema-registry to use (useful when data was produced with `--key-subject-name-strategy` other than TopicNameStrategy)

Note: `--topic` should be specified in this case.

#### `--value-subject VALUE-SUBJECT`

📛 Subject for value in schema-registry to use (useful when data was produced with `--value-subject-name-strategy` other than TopicNameStrategy)

Note: `--topic` should be specified in this case.

#### `--max-characters MAX-CHARACTERS`

Max characters per message to display (default is 3000, 0 for no limit)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `3000`

#### `--open, -o`

🔖 Save full dump of topic to a file and open with text editor set with playground config editor `<editor>` (default is code)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--max-characters`, `--tail`, `--min-expected-messages`

#### `--isolation-level ISOLATION-LEVEL`

🫥 The isolation level to use, see https://docs.confluent.io/platform/current/installation/configuration/consumer-configs.html#isolation-level  
If not set, default is read_uncommitted

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `read_uncommitted`
| Allowed Values: | `read_uncommitted`, `read_committed`

#### `--last LAST`

⏮️ Display the last N records of the topic (the most recent ones, sorted by timestamp across partitions),  
instead of the first `--max-messages`

Example: `--last` 10

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--tail`, `--from-timestamp`, `--offset`, `--min-expected-messages`, `--open`, `--count`

#### `--from-timestamp FROM-TIMESTAMP`

⏱️ Display the records from this time (sorted by timestamp across partitions, `--max-messages` still applies)

Accepted values:

- a date, in local time: "2026-10-22 10:30", "2026-10-22T10:30:00.250" (add Z for UTC: "2026-10-22T08:30:00Z")
- an epoch, in milliseconds or seconds: 1792660170522
- a duration ago: 30s, 10m, 2h, 1d

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--tail`, `--last`, `--offset`, `--open`

#### `--partition PARTITION`

🧩 Only consume this partition (with `--offset`, from that offset; otherwise from the beginning, or new records with `--tail`)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--open`

#### `--offset OFFSET`

📍 Offset of `--partition` to start from: a number, earliest or latest

Example: `--partition` 0 `--offset` 1234 `--max-messages` 1, the record a connector is stuck on

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--tail`, `--last`, `--from-timestamp`, `--open`

#### `--json`

🧾 Print each record as a json object on one line (topic, partition, offset, timestamp, date, headers, key,  
value, schema ids): key and value are embedded as json when they are valid json, as strings otherwise.

Only the records go to stdout, everything else goes to stderr, so the output can be piped to jq.

Example: playground topic consume `--topic` orders `--json` | jq -r '.value.id'

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--open`, `--count`, `--tail`

#### `--count`

🔢 Only print the number of records consumed (with `--grep`, the number of records containing that string),  
on stdout: logs go to stderr. Without `--topic`, one "`<topic>` `<number>`" line per topic.

Unlike playground topic get-number-records, records are counted, not offsets (transaction markers,  
compacted records and records that cannot be deserialized do not count)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--tail`, `--open`, `--json`

#### `--no-decode`

🤖 Never decode the values, even when they look base64 encoded (by default, they are decoded when the first  
record is valid base64 of printable utf-8)

#### `--print-schema`

📜 Also print the key and value schemas registered for the topic

## Examples

```bash
playground topic consume --topic filestream --min-expected-messages 2 --timeout 30
```

## Example output

```text
$ playground topic consume --topic filestream --min-expected-messages 2 --timeout 30
17:23:00 ℹ️ ✨ Display content of topic filestream, it contains 5 messages
17:23:00 ℹ️ 🔮🙅 topic is not using any schema for key
17:23:00 ℹ️ 🔮🙅 topic is not using any schema for value
CreateTime:2026-10-13 16:28:16.239|Partition:0|Offset:0|Headers:NO_HEADERS|Key:null|Value:{"id":1,"name":"Asha_Fadel50","email":"Euna.Anderson37@example.com","city":"Duluth","company":"Jacobson - Crooks"}
CreateTime:2026-10-13 16:28:16.243|Partition:0|Offset:1|Headers:NO_HEADERS|Key:null|Value:{"id":2,"name":"Clare50","email":"Pat4@example.net","city":"West Dinoboro","company":"Hodkiewicz, Effertz and Heidenreich"}
...
```


