# playground broker transactions describe-producers

🏭 Describe the active producers of a topic

For each partition (or `--partition` only): the producers that wrote  
to it recently, and the start offset of their open transaction (⚠️).  
That offset is where read_committed consumers are blocked.

## Usage

```bash
playground broker transactions describe-producers [OPTIONS]
```

## Options

#### `--topic, -t TOPIC`

🗳 Topic name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--partition, -p PARTITION`

🔢 Only this partition (default: all the partitions of the topic)

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
playground broker transactions describe-producers --topic orders
```

```bash
playground broker transactions describe-producers --topic orders --partition 0
```


