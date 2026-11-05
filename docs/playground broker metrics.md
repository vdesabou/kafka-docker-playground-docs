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

Then the controller section: active controller, offline partitions,  
partitions and topics of the cluster, preferred replica imbalance, last  
applied record lag, unclean leader elections. In KRaft these metrics are  
the ones of the controller containers (controller, controller2,  
controller3); with ZooKeeper, of the broker that is the active  
controller. `--controller` shows only this section.

🎓 Tip: every metric of a broker: playground get-jmx-metrics -c broker  
`--domain` kafka.server

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-observability

## Usage

```bash
playground broker metrics [OPTIONS]
```

## Options

#### `--broker, -b BROKER`

🖥️ Only this broker (default: all brokers)

#### `--topic, -t TOPIC`

🗳 Rates and failed requests of this topic only

#### `--controller`

🗳️ Only the controller section (KRaft controllers, or the brokers with  
ZooKeeper), with `--json` too

#### `--json`

📗 Print the raw values as JSON, one object per broker (per controller  
with `--controller`), and nothing else

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
playground broker metrics
```

```bash
playground broker metrics --topic orders
```

```bash
playground broker metrics --broker 1 --json
```

```bash
playground broker metrics --controller
```


