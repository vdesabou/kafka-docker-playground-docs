# playground consumer-group delete

🗑️ Delete a consumer group, or its offsets for one topic

Wraps kafka-consumer-groups `--delete`. With `--topic`, only the  
committed offsets of that topic are deleted (`--delete-offsets`), the  
group keeps its other offsets.

The group must have no active member: for a sink connector, stop or  
delete the connector first.

## Usage

```bash
playground consumer-group delete [OPTIONS]
```

## Options

#### `--group, -g GROUP`

👥 Consumer group name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--topic, -t TOPIC`

🗳 Only delete the committed offsets of this topic

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
playground consumer-group delete --group my-app
```

```bash
playground consumer-group delete --group my-app --topic orders
```


