# playground connector lint

🧪 Best-practice warnings on a connector config (no environment needed)

'connector validate' only prints what the plugin rejects. A config that  
validates can still lose records or fail later: lint flags the risky  
or useless settings, each with why and how to fix it.

Rules: errors.tolerance=all without a dead letter queue (records lost)  
or without errors.log.enable, a dead letter queue that is never  
written (errors.tolerance=none) or set on a source, replication  
factors above the number of brokers, tasks.max above the number of  
partitions of a sink, client overrides (consumer.override.\*,  
producer.override.\*) against connector.client.config.override.policy  
of the worker, consumer.override.max.poll.records too high for  
max.poll.interval.ms, a max.poll.interval.ms lowered below 60 s,  
auto.offset.reset=latest, producer acks not all,  
an Avro / Protobuf / JSON Schema converter set on the connector without  
its schema.registry.url (a converter set on the connector does not  
inherit the converter settings of the worker), JsonConverter with a  
schema.registry.url, JsonConverter expecting the schema / payload  
envelope on a sink, a single task Debezium connector with tasks.max \> 1,  
and secrets in clear text (not ${file:...} / ${secret:...}).

Severity: 🔴 HIGH (fails), 🟠 MEDIUM (loses records or misbehaves),  
🟡 LOW (risky), 🔵 INFO (a note, does not count). Exits with 1 when there  
is at least one warning (HIGH, MEDIUM or LOW).

The config is read from stdin, in the same formats as 'connector  
validate': json, a CFK / Strimzi custom resource, terraform, a  
.properties, a dump of GET /connectors?expand=info (`--connector` picks  
one). Without stdin, `--connector` lints the config of that running  
connector.

When a local environment runs, the number of brokers, the partitions of  
the topics of a sink and the override policy of the worker are read  
from it (`--offline` to skip). For a customer config, `--brokers` gives the  
size of their cluster.

☁️ Fully managed: supported for the generic rules (the converter and secret rules are skipped, a fully managed config holds its secrets)

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-connector-troubleshooting

## Usage

```bash
playground connector lint [JSON] [OPTIONS]
```

## Arguments

#### `JSON`

json (reads from stdin if empty)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `-`

## Options

#### `--verbose, -v`

🐞 Show command being ran.

#### `--connector, -c CONNECTOR`

🔗 Connector name

With a config on stdin: the name shown, or the connector to pick in  
a dump that has several. Without stdin, the running connector whose  
config is linted.

#### `--brokers BROKERS`

🔢 Number of brokers of the target cluster (the customer's), to check the replication factors without a running environment

#### `--offline`

✈️ Do not read the running environment (brokers, partitions, worker override policy): the config only

#### `--json`

🤖 Print the result as JSON on stdout, and nothing else (the log lines go to stderr)

## Examples

```bash
playground connector lint << EOF
{
  "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
  "topics": "orders",
  "tasks.max": "4",
  "connection.url": "jdbc:postgresql://postgres/postgres",
  "connection.password": "postgres",
  "errors.tolerance": "all",
  "value.converter": "io.confluent.connect.avro.AvroConverter",
  "consumer.override.max.poll.records": "10000"
}
EOF
```

```bash
playground connector lint --brokers 3 < customer-connector-cr.yaml
```

```bash
playground connector lint --connector jdbc-sink --json
```

## Example output

```text
$ playground connector lint (the JDBC sink above, plaintext environment with 1 broker, topic orders with 1 partition)
🧪 connector (io.confluent.connect.jdbc.JdbcSinkConnector, sink)
🟠 MEDIUM consumer.override.max.poll.records  = 10000
          why: 10000 records per poll with max.poll.interval.ms=300000: a slow put() makes the consumer leave its group (rebalances, commits failing)
          fix: lower consumer.override.max.poll.records or raise consumer.override.max.poll.interval.ms
🟠 MEDIUM errors.tolerance                    = all
          why: bad records are skipped and lost: no dead letter queue (errors.deadletterqueue.topic.name)
          fix: set errors.deadletterqueue.topic.name to keep them, read it with playground topic dlq inspect
🟠 MEDIUM value.converter.schema.registry.url
          why: value.converter=AvroConverter is set on the connector without value.converter.schema.registry.url: a converter set on the connector does not inherit the converter settings of the worker
          fix: add value.converter.schema.registry.url (and its value.converter.basic.auth.* / ssl settings) to the connector
🟡 LOW    connection.password                 = ****
          why: secret in clear text in the connector config (visible in GET /connectors and in the config topic)
          fix: use a config provider: ${file:/path:key}, ${secret:…} or ${vault:…}
🟡 LOW    errors.log.enable                   = false (default)
          why: with errors.tolerance=all the records skipped are not even logged
          fix: set errors.log.enable=true and errors.log.include.messages=true
🟡 LOW    tasks.max                           = 4
          why: 4 tasks for 1 partition(s): 3 task(s) stay idle
          fix: set tasks.max=1 or add partitions (playground topic add-partitions)
❌ 6 warning(s), 0 note(s)
```


