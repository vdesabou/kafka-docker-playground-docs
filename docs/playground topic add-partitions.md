# playground topic add-partitions

➕ Add partitions to an existing topic

A topic can only grow: Kafka refuses to remove partitions. The records  
already in the topic stay where they are, only new records use the new  
partitions.

⚠️ The partition of a record with a key is hash(key) % number of  
partitions: after the change, new records of a key can land in another  
partition than the older ones, and a consumer no longer sees all the  
records of a key in order.

🎓 Tip: a sink connector runs at most one task per partition that it  
reads: tasks.max above the number of partitions leaves tasks idle.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-topic-administration

## Usage

```bash
playground topic add-partitions [OPTIONS]
```

## Options

#### `--verbose, -v`

🐞 Show command being ran.

#### `--topic, -t TOPIC`

🗳 Topic name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--nb-partitions NB-PARTITIONS`

🔢 New total number of partitions (more than the current one)

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

## Examples

```bash
playground topic add-partitions --topic atopic --nb-partitions 4

```


