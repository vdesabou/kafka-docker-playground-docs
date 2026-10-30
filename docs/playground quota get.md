# playground quota get

🔎 Display client quotas

Without any flag, displays every quota (users, client ids, and users +  
client ids).

## Usage

```bash
playground quota get [OPTIONS]
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
playground quota get
```

```bash
playground quota get --connector filestream-sink
```

```bash
playground quota get --user client --client-id my-app
```


