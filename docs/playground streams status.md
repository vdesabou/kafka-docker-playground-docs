# playground streams status

🌊 Show the state of the Kafka Streams instances

For each application (application.id) and each instance (container):  
the state of the KafkaStreams client and since when, the number of  
rebalances and the time spent in REBALANCING, the stream threads with  
their active and standby tasks, the active tasks not restored yet, the  
changelog partitions being restored, the records restored, and the  
known Kafka Streams errors of the logs (task migrated, fenced producer,  
deserialization or production handler, missing source topic, topics  
not co-partitioned, state directory locked, uncaught exception...) with  
their advice. Then the consumer group of each application: its state,  
members and lag.

Everything comes from the lines that the Kafka Streams library logs at  
INFO (State transition from ... to ..., Handle new assignment with:,  
Restored and ready to run, Finished restoring changelog...), so it works  
with any application and any Kafka Streams version since 3.0, as long  
as its logs are at INFO. The logs of a restarted container hold its  
previous runs too: only the current run is shown, the restarts are  
counted (and drawn in the timeline of `--html`).

`--html` also writes an HTML report (timeline of the states, task  
assignment, errors). The same view of a customer's log files is the  
🌊 Kafka Streams section of `playground analyze logs`.

Exits with 1 when an instance is not RUNNING (or its container is  
stopped), so that an example can check it.

## Usage

```bash
playground streams status [OPTIONS]
```

## Options

#### `--container, -c CONTAINER`

🐳 Container of a Kafka Streams instance, can be set several times

ℹ️ If not set, the containers named streams, streams2, streams3... (other/kafka-streams)

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--application-id, -a APPLICATION_ID`

🆔 Only this application.id (an instance can run several applications, like the demo  
applications of other/kafka-streams)

#### `--json`

🤖 Print the result as JSON (applications, instances, threads, tasks, errors, consumer group)

#### `--html`

📊 Also write an HTML report: the same view with a timeline of the state of each instance  
(restarts and the time without logs), the task assignment (task × instance) and the  
known errors with their advice, opened in the browser

#### `--output-dir, -o OUTPUT_DIR`

📂 Folder of the HTML report of `--html` (default is /tmp/playground-streams)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `/tmp/playground-streams`

#### `--no-open`

🙈 Do not open the HTML report in the browser (it is still written, and its path printed)

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground streams status
```

```bash
playground streams status --container streams2
```

```bash
playground streams status --html
```

```bash
playground streams status --application-id streams-count --json | jq '.applications[0].instances[] | {instance, state, rebalances}'
```


