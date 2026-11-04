# playground connector display-leader-name

👑 Display Connect Worker leader name using JMX MBean leader-name from kafka.connect:type=connect-worker-rebalance-metrics

This is useful when you have multiple connect workers and want to know which one is the leader.

For self managed connectors, it reads the leader-name attribute with `playground get-jmx-metrics --container <worker> --domain kafka.connect` on each running connect worker (connect, connect2, connect3, or the connect-N pods on cfk) until one answers.

For Fully Managed connectors, this is not available as JMX is not accessible.

☁️ Fully managed: not supported

## Usage

```bash
playground connector display-leader-name [OPTIONS]
```

## Options

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

## Examples

```bash
playground connector display-leader-name
```


