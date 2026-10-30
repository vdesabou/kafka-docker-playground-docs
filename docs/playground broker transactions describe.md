# playground broker transactions describe

🔎 Describe a transactional id

State, producer id and epoch, timeout, start time and duration of the  
current transaction, and the partitions it writes to.

## Usage

```bash
playground broker transactions describe [OPTIONS]
```

## Options

#### `--transactional-id, -i TRANSACTIONAL-ID`

🆔 Transactional id (playground broker transactions list)

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
playground broker transactions describe --transactional-id my-txn-producer
```


