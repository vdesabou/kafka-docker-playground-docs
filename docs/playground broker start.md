# playground broker start

▶️ Start a broker stopped with `playground broker stop`

Starts the container of the broker, waits for it to be registered, then  
for the cluster to be healthy again (its replicas back in sync, see  
`playground broker health`), up to `--max-wait` seconds.

## Usage

```bash
playground broker start [OPTIONS]
```

## Options

#### `--broker, -b BROKER`

🖥️ Broker id

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--max-wait MAX-WAIT`

⏳ Maximum time to wait for the broker and the cluster, in seconds (default 180)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `180`

#### `--no-wait`

⏩ Do not wait for the broker to be registered and the cluster to be healthy

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
playground broker start --broker 2
```

```bash
playground broker start --broker 2 --no-wait
```


