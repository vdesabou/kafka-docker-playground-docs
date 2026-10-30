# playground topic set-schema-compatibility

🛡️ Change topic's schema compatibility

Sets the compatibility level on the subjects of the topic, which is  
what you relax to let an otherwise rejected schema evolution through,  
for instance to reproduce a schema compatibility issue.

## Usage

```bash
playground topic set-schema-compatibility [OPTIONS]
```

## Options

#### `--topic, -t TOPIC`

🗳 Topic name

#### `--compatibility COMPATIBILITY`

Schema Registry compatibility rule

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes
| Allowed Values: | `BACKWARD`, `BACKWARD_TRANSITIVE`, `FORWARD`, `FORWARD_TRANSITIVE`, `FULL`, `FULL_TRANSITIVE`, `NONE`

#### `--verbose, -v`

🐞 Show command being ran.

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`


