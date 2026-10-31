# playground schema set-compatibility

🛡️ Set the compatibility rule of a subject (`--subject`), or of the whole registry (`--global`)

Overrides the rule for one subject, or changes the default of every  
subject without a rule of its own:

- **BACKWARD**: new schema can read data written with the previous one
- **FORWARD**: previous schema can read data written with the new one
- **FULL**: both
- **NONE**: anything is accepted
- **\*_TRANSITIVE checked against all past versions, not just the last**

Set it to NONE when you deliberately want to register an incompatible  
schema, typically to reproduce what it does to consumers downstream.

## Usage

```bash
playground schema set-compatibility [OPTIONS]
```

## Options

#### `--subject SUBJECT`

📛 Subject name

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--global`

#### `--global`

🌍 The global setting of the registry, instead of one subject

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--subject`

#### `--verbose, -v`

🐞 Show command being ran.

#### `--compatibility COMPATIBILITY`

Schema Registry compatibility rule

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes
| Allowed Values: | `BACKWARD`, `BACKWARD_TRANSITIVE`, `FORWARD`, `FORWARD_TRANSITIVE`, `FULL`, `FULL_TRANSITIVE`, `NONE`

#### `--context CONTEXT`

🗂️ Schema Registry context (.europe, or europe): every call goes to /contexts/`<context>`/…

The subjects exported by Schema Linking land in a context of the destination registry. Default: the default context.

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`


