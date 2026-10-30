# playground broker config delete

🗑️ Remove a dynamic broker config

The broker falls back to the next value: the cluster-wide default  
(when removing it from `--broker`), the static one of server.properties,  
or the Kafka default.

## Usage

```bash
playground broker config delete [OPTIONS]
```

## Options

#### `--broker, -b BROKER`

🖥️ Broker id (default: all brokers, plus the cluster-wide default for set and delete)

#### `--key, -k KEY`

🔑 Config key (e.g. log.retention.ms)

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

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
playground broker config delete --key log.retention.ms
```

```bash
playground broker config delete --broker 1 --key num.io.threads
```


