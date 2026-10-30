# playground broker config set

⚙️ Set a dynamic broker config

Applied right away, without restart, cluster-wide or on `--broker` only.  
A value with commas (a list) is sent as one value.

## Usage

```bash
playground broker config set [OPTIONS]
```

## Options

#### `--broker, -b BROKER`

🖥️ Broker id (default: all brokers, plus the cluster-wide default for set and delete)

#### `--key, -k KEY`

🔑 Config key (e.g. log.retention.ms)

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--value VALUE`

✏️ New value

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
playground broker config set --key log.retention.ms --value 60000
```

```bash
playground broker config set --broker 1 --key num.io.threads --value 16
```

```bash
playground broker config set --key leader.replication.throttled.rate --value 1048576
```


