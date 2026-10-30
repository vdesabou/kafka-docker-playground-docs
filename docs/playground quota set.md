# playground quota set

🚦 Set client quotas

Set one or more of `--producer-byte-rate`, `--consumer-byte-rate`,  
`--request-percentage` and `--controller-mutation-rate`, on `--user`,  
`--client-id`, `--connector`, `--all-users` or `--all-client-ids`. The  
quotas already set on the entity and not given here are kept.

Clients are throttled right away, without restart: the broker delays  
its responses, and the clients report it in their produce-throttle-time-avg  
and fetch-throttle-time-avg metrics.

## Usage

```bash
playground quota set [OPTIONS]
```

## Options

#### `--user, -u USER`

👤 User (principal name, e.g. client for User:client)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--all-users`

#### `--client-id CLIENT-ID`

🏷️ Client id (client.id of the producer or consumer)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--connector`, `--all-client-ids`

#### `--connector, -c CONNECTOR`

🔗 Self-managed connector: use the client ids of its tasks

connector-consumer-`<connector>`-`<task>` for a sink,  
connector-producer-`<connector>`-`<task>` for a source.

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--client-id`, `--all-client-ids`

#### `--all-users`

👥 Default quota of all users (used by the users without their own quota)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--user`

#### `--all-client-ids`

🏷️ Default quota of all client ids (used by the client ids without their own quota)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--client-id`, `--connector`

#### `--producer-byte-rate BYTES`

📤 Produce bandwidth, in bytes per second, per broker (producer_byte_rate)

#### `--consumer-byte-rate BYTES`

📥 Fetch bandwidth, in bytes per second, per broker (consumer_byte_rate)

#### `--request-percentage PERCENTAGE`

⏱️ Share of the broker request handler and network threads time, in percent of one thread (request_percentage, decimals allowed, e.g. 0.2)

#### `--controller-mutation-rate RATE`

🧬 Partitions created or deleted per second (controller_mutation_rate)

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
playground quota set --connector filestream-sink --consumer-byte-rate 1024
```

```bash
playground quota set --client-id my-producer --producer-byte-rate 10240
```

```bash
playground quota set --all-users --request-percentage 50
```

## Example output

```text
$ playground quota set --connector filestream-sink --consumer-byte-rate 1024
15:02:10 ℹ️ 🚦 Setting consumer_byte_rate=1024 on client-id connector-consumer-filestream-sink-0
Completed updating config for client-id connector-consumer-filestream-sink-0.
Quota configs for client-id 'connector-consumer-filestream-sink-0' are consumer_byte_rate=1024.0
```


