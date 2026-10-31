# playground schema get-compatibility

🛡️ Get the compatibility rule in force

The rule that decides whether a new schema version is accepted. When a  
producer fails with "Schema being registered is incompatible with an  
earlier schema", this is what rejected it.

With `--subject`, the subject-level rule, or the global rule of the  
registry when the subject has none (the command says which one  
applies). With `--global`, the global rule.

## Usage

```bash
playground schema get-compatibility [OPTIONS]
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
playground schema get-compatibility --subject orders-value
```

```bash
playground schema get-compatibility --global
```

```bash
playground schema get-compatibility --subject orders-value --json
```


