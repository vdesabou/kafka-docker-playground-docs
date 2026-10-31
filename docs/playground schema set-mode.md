# playground schema set-mode

🔏 Set the mode of a subject (`--subject`), or of the whole registry (`--global`)

- **READWRITE**: the normal mode, schemas can be read and registered
- **READONLY**: freeze the subject, registration is refused
- **IMPORT**: allow registering schemas at a chosen id and version, which is what a migration between registries needs

⚠️ To enable mode changes on a Schema Registry cluster, you must also set  
mode.mutability=true in the Schema Registry properties file before  
starting Schema Registry, otherwise this command is rejected.

## Usage

```bash
playground schema set-mode [OPTIONS]
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

#### `--mode MODE`

Schema Registry mode

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes
| Allowed Values: | `IMPORT`, `READONLY`, `READWRITE`

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
playground schema set-mode --subject orders-value --mode READONLY
```

```bash
playground schema set-mode --global --mode READWRITE
```


