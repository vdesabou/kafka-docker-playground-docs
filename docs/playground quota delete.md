# playground quota delete

🗑️ Remove client quotas

Removes the quotas given with `--producer-byte-rate`,  
`--consumer-byte-rate`, `--request-percentage` and  
`--controller-mutation-rate` (no value), or all the quotas of the  
entity when none is given.

## Usage

```bash
playground quota delete [OPTIONS]
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

#### `--producer-byte-rate`

📤 Only remove producer_byte_rate

#### `--consumer-byte-rate`

📥 Only remove consumer_byte_rate

#### `--request-percentage`

⏱️ Only remove request_percentage

#### `--controller-mutation-rate`

🧬 Only remove controller_mutation_rate

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
playground quota delete --connector filestream-sink
```

```bash
playground quota delete --all-users --request-percentage
```


