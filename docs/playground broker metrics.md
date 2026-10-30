# playground broker metrics

📈 Display the key JMX metrics of the brokers

One column per broker: partitions and leaders, under-replicated and  
under min ISR partitions, request handler and network processor idle  
ratio, request queue size, produce and fetch p99 latency, messages and  
bytes in and out per second, ISR shrinks and expands, failed produce and  
fetch requests. ⚠️ marks the values to look at.

Answers "is the broker the bottleneck?", for example during a  
`playground connector benchmark`. With `--topic`, the rates and failed  
requests are the ones of this topic.

🎓 Tip: every metric of a broker: playground get-jmx-metrics -c broker

## Usage

```bash
playground broker metrics [OPTIONS]
```

## Options

#### `--broker, -b BROKER`

🖥️ Only this broker (default: all brokers)

#### `--topic, -t TOPIC`

🗳 Rates and failed requests of this topic only

#### `--json`

📗 Print the raw values as JSON, one object per broker, and nothing else

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground broker metrics
```

```bash
playground broker metrics --topic orders
```

```bash
playground broker metrics --broker 1 --json
```


