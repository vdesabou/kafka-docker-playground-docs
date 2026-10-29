# playground connector metrics

📈 Show the metrics of a connector: throughput, time, errors, and the metrics of the connector itself

Answers "is it making progress?", "how many records were tolerated,  
skipped, retried or sent to the dead letter queue?" and "where does  
the time go, poll or put?", one column per task:

- **throughput**: records polled / written per second (source), read / sent per second (sink), and the totals since the task started
- **time**: average time of a poll (source) or a put (sink) batch, offset commit time and failures, running / pause ratio
- **errors**: records that failed, were skipped (errors.tolerance=all), retried or sent to the DLQ, last error time

- **connector**: the other MBeans of the connector: Debezium (debezium.`<plugin>`:server=`<topic.prefix>`, also Oracle XStream), MongoDB, Oracle CDC... any MBean with a connector=`<connector>` key

Ends with what stands out (errors, skipped records, a slow put, a task  
that never got a record, a Debezium connector lagging, disconnected,  
with a full queue or snapshotting) and the command to run next. Rates  
are the averages Kafka Connect computes over its last samples (about 1  
minute).

Read over JMX from the connect worker(s) running the tasks, with the  
kafka-jmx tool of the connect image: no restart, nothing to install.  
For a fully managed connector, the metrics come from the Confluent  
Cloud Telemetry API (`playground connector display-metrics-api`).

🎓 Tip: use `--watch` 10s while a load runs, or 'playground connector  
benchmark' to measure the throughput.

⚠️ Not on cfk environments: use 'playground get-jmx-metrics -c connect-0  
`--domain` kafka.connect'.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-connector-troubleshooting

## Usage

```bash
playground connector metrics [OPTIONS]
```

## Options

#### `--verbose, -v`

🐞 Show command being ran.

#### `--connector, -c CONNECTOR`

🔗 Connector name

🎓 Tip: If not specified, the command will apply to all connectors

#### `--watch, -w INTERVAL`

🔁 Refresh every `<interval>` (30, 30s, 5m) until ctrl-c

#### `--json`

🤖 Print the result as JSON

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--watch`

## Examples

```bash
playground connector metrics
```

```bash
playground connector metrics --connector jdbc-sink --watch 10s
```

```bash
playground connector metrics --connector jdbc-sink --json
```


