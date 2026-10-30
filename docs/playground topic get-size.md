# playground topic get-size

📏 Get size of topics

Shows the size and number of partitions of each topic, largest first,  
to find which topics take the most disk space. Without `--topic`, all  
topics are shown (add `--show-internal` to include internal topics).

The size of a partition is the size of its largest replica, the size  
of a topic is the sum of its partitions.

With ccloud environment, sizes come from the retained_bytes metric of  
the Metrics API, which lags a few minutes behind and requires  
`CONFLUENT_CLOUD_API_KEY` and `CONFLUENT_CLOUD_API_SECRET` (Cloud API key).

## Usage

```bash
playground topic get-size [OPTIONS]
```

## Options

#### `--topic, -t TOPIC`

🗳 Topic name

#### `--show-internal`

🫥 Include internal topics (when `--topic` is not set)

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

## Examples

```bash
playground topic get-size
```

```bash
playground topic get-size --topic filestream
```

```bash
playground topic get-size --show-internal
```


