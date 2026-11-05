# playground ksqldb metrics

📈 Display the key JMX metrics of the ksqlDB server

The engine statistics of ksqldb-server: persistent queries, and how many  
are running, in ERROR, not running, rebalancing or pending shutdown,  
active and idle queries, messages consumed and produced per second, and  
the liveness indicator. ⚠️ marks the values to look at.

Answers "is a query in ERROR or stuck rebalancing?" and "does ksqlDB  
consume anything?", next to `playground ksqldb list` (the state of each  
query) and `playground ksqldb describe` (its errors and lag).

Read over JMX in the ksqldb-server container, with jmxterm (no restart,  
nothing to install).

🎓 Tip: every metric of the container: playground get-jmx-metrics -c  
ksqldb-server `--domain` io.confluent.ksql.metrics

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-observability

## Usage

```bash
playground ksqldb metrics [OPTIONS]
```

## Options

#### `--json`

📗 Print the raw values as JSON, and nothing else

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground ksqldb metrics
```

```bash
playground ksqldb metrics --json
```


