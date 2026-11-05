# playground schema metrics

📈 Display the key JMX metrics of Schema Registry

Whether it is the leader, requests per second, client (4xx) and server  
(5xx) errors, average and p99 request latency, active connections, registered  
schemas, and the Avro / JSON / Protobuf schemas created and deleted  
since it started. ⚠️ marks the values to look at.

Answers "is Schema Registry slow or failing requests?" and "how many  
schemas were registered or deleted?", next to `playground schema list`  
for the subjects themselves.

Read over JMX in the schema-registry container, with jmxterm (no  
restart, nothing to install).

🎓 Tip: every metric of the container: playground get-jmx-metrics -c  
schema-registry `--domain` kafka.schema.registry

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-observability

## Usage

```bash
playground schema metrics [OPTIONS]
```

## Options

#### `--json`

📗 Print the raw values as JSON, and nothing else

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
playground schema metrics
```

```bash
playground schema metrics --json
```


