# playground schema get

🔰 Get all schemas versions for specified subject (if `--subject` is not specified, all subjects will be used)

🎓 Tip: `--schema-only` prints the schema alone (latest version, or  
`--version`), ready to be redirected to a file:

```bash
playground schema get --subject orders-value --version 2 --schema-only > v2.avsc
```

## Usage

```bash
playground schema get [OPTIONS]
```

## Options

#### `--subject SUBJECT`

📛 Subject name

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `id`

#### `--id ID`

💯 Schema id

With `--json`, the subjects and versions using this id are added.

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `subject`, `deleted`, `--version`

#### `--version VERSION`

🔢 Only this version of `--subject`: a number, or latest

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--id`

#### `--schema-only`

📄 Print only the schema (pretty-printed avro / json schema, protobuf as is), without the log lines

Needs `--subject` (latest version unless `--version` is set) or `--id`.

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--json`

#### `--json`

📗 Print the versions as a JSON array (subject, version, id, schemaType, schema, references, metadata, ruleSet, deleted), and nothing else

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--schema-only`

#### `--verbose, -v`

🐞 Show command being ran.

#### `--deleted`

🧟 Include soft deleted subjects

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `id`

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
playground schema get
```

```bash
playground schema get --subject <SUBJECT>
```

```bash
playground schema get --subject <SUBJECT> --version latest --schema-only > schema.avsc
```

```bash
playground schema get --id 3 --json
```

```bash
playground schema get --deleted
```


