# playground schema set-alias

🔯 Set a subject alias

Makes `--alias` point at `--subject`, so a client asking for the alias gets  
the real subject's schemas. That is how you let a consumer keep its own  
subject name while the data actually lives under another one, typically  
after a topic rename or a migration between registries.

CP 7.4.1 or higher is required to have this feature.

See https://docs.confluent.io/platform/current/schema-registry/fundamentals/index.html#subject-aliases

## Usage

```bash
playground schema set-alias [OPTIONS]
```

## Options

#### `--subject SUBJECT`

📛 Subject name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--alias ALIAS`

🔯 Alias name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

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
playground schema set-alias --subject orders-value --alias legacy-orders-value
```


