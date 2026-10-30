# playground broker stop

🛑 Stop a broker

Stops the container of a broker with a controlled shutdown: its leaders  
move to the other replicas first. With `--kill`, the container is killed  
instead, like a crash (no controlled shutdown, the leaders move only after  
the broker session times out).

Useful to reproduce what clients and connectors do when a broker goes  
away: `NOT_LEADER_OR_FOLLOWER`, NotEnoughReplicasException, metadata  
refresh, retries. Start it again with `playground broker start`.

🎓 Tip: needs several brokers to keep the cluster available, start the  
example with `playground run --enable-multiple-brokers`.

## Usage

```bash
playground broker stop [OPTIONS]
```

## Options

#### `--broker, -b BROKER`

🖥️ Broker id

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--kill`

🔫 Kill the broker (like a crash) instead of a controlled shutdown

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
playground broker stop --broker 2
```

```bash
playground broker stop --broker 2 --kill
```


