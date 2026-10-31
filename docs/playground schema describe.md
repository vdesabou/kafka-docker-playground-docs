# playground schema describe

🔎 Everything about one subject, or one schema id, in one call

For a subject: the compatibility rule and mode in force (and whether  
they come from the subject or the global setting), its alias and other  
settings, every version (soft-deleted ones too) with its id and  
registration date, its references, the schemas that reference it (a  
version they use can't be deleted), the other subjects sharing the same  
schema id, metadata and rule set, and the subject name strategy its  
name suggests, with the topic it belongs to.

For `--id`: the schema type, record name, and every subject and version  
using that id (what a consumer resolves from the id in a record).

## Usage

```bash
playground schema describe [OPTIONS]
```

## Options

#### `--subject SUBJECT`

📛 Subject name

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--id`

#### `--id ID`

💯 Schema id (the ValueSchemaId: of `playground topic consume`)

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
playground schema describe --subject orders-value
```

```bash
playground schema describe --id 3
```

```bash
playground schema describe --subject orders-value --json | jq '.versions[] | select(.deleted)'
```


