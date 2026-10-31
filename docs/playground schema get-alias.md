# playground schema get-alias

🔯 Get subject alias

Shows which real subject an alias resolves to. Use it when a client reads  
schemas that do not match the subject it asked for, the alias is often  
the missing piece.

CP 7.4.1 or higher is required to have this feature.

## Usage

```bash
playground schema get-alias [OPTIONS]
```

## Options

#### `--alias ALIAS`

🔯 Alias name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

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
playground schema get-alias --alias legacy-orders-value
```

```bash
playground schema get-alias --alias legacy-orders-value --json
```


