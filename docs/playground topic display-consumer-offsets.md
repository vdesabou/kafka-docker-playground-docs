# playground topic display-consumer-offsets

📭 Display content of __consumer_offsets topic

Decodes the internal topic where Kafka keeps committed offsets, so you  
can see exactly what each consumer group, including a sink connector,  
has committed and when.

## Usage

```bash
playground topic display-consumer-offsets [OPTIONS]
```

## Options

#### `--verbose, -v`

🐞 Show command being ran.

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`


