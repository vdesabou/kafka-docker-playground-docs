# playground connector flow

🗺️ Show the flow of the running connectors: source → topic → sinks, with the records, the lag and the DLQ

Where are the records stuck? One tree per source connector: its state and tasks, the topics it writes with their number of records, then each sink reading them, with its state, its consumer lag and its dead letter queue. Topics read by a sink with no source connector (a producer) are listed too.

The topics of a source are the active topics tracked by the worker (KIP-558, self-managed), else its kafka.topic / topic config. A storage sink (S3, GCS, Azure Blob, HDFS) commits its offsets when it writes a file, so its lag stays above 0 until then.

🎓 Tip: a reproduction model created with `playground repro bootstrap --pipeline` prints this command at the end.

☁️ Fully managed: supported (the topics of a source come from its config)

## Usage

```bash
playground connector flow [OPTIONS]
```

## Options

#### `--verbose, -v`

🐞 Show command being ran.

#### `--json`

🤖 Print the flow as JSON on stdout (connectors with the topics they write and read, topics with their records), the log lines go to stderr

#### `--fail-on-error`

❌ Exit 1 when a connector or one of its tasks is FAILED, or the connector is not found (by default the command exits 0, it only displays)

## Examples

```bash
playground connector flow
```

```bash
playground connector flow --json
```

```bash
playground connector flow --fail-on-error
```

## Example output

```text
$ playground connector flow
12:01:44 ℹ️ 🗺️ flow of the 3 🌎onprem connectors
🔌 debezium-mysql-source · MySqlConnector · ✅ RUNNING 1/1 tasks
  └─▶ 🗳 server1_mydb_CUSTOMERS · 2 records
        ├─▶ 🔌 postgres-sink · JdbcSinkConnector · ✅ RUNNING 1/1 tasks · lag 0 ✔️
        └─▶ 🔌 s3-sink · S3SinkConnector · ✅ RUNNING 1/1 tasks · lag 2 (offsets committed when a file is written) ⏳
```


