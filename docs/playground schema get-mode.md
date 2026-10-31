# playground schema get-mode

🔏 Get the mode in force

READWRITE normally; READONLY if registration has been frozen; IMPORT  
while schemas are being migrated with their original ids and versions.

With `--subject`, the subject-level mode, or the global mode when the  
subject has none. With `--global`, the global mode of the registry.

## Usage

```bash
playground schema get-mode [OPTIONS]
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

#### `--json`

📗 Print the result as JSON, and nothing else

#### `--verbose, -v`

🐞 Show command being ran.

#### `--context CONTEXT`

🗂️ Schema Registry context (.europe, or europe): every call goes to /contexts/`<context>`/…

The subjects exported by Schema Linking land in a context of the destination registry. Default: the default context.

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

## Examples

```bash
playground schema get-mode --subject orders-value
```

```bash
playground schema get-mode --global --json
```


