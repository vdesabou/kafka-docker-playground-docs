# playground schema diff

🔀 Compare two schemas field by field, with the verdict of each compatibility rule

Shows what changed between two versions of a subject, a version and a  
file, or two files: ➕ added and ➖ removed fields (with or without a  
default), ✏️ type, default, enum symbol, field number or required  
changes, each with a hint on the rule it breaks. Avro (nested records,  
unions, enums, logical types), JSON Schema and Protobuf are supported.

Then, when a Schema Registry is running, its verdict for BACKWARD,  
FORWARD and FULL (asked in a temporary subject, permanently deleted  
afterwards; a `--from` file not registered yet consumes a schema id).

`--from` and `--to` take a version number, latest, id:`<schema id>`, or  
@`<file>`. Defaults: `--to` the latest version of `--subject`, `--from` the  
version before it (the latest one when `--to` is a file).

## Usage

```bash
playground schema diff [OPTIONS]
```

## Options

#### `--subject SUBJECT`

📛 Subject of the versions to compare (not needed for id:`<n>` and @`<file>`)

#### `--from FROM`

⬅️ The old schema: a version number, latest, id:`<schema id>` or @`<file>`

#### `--to TO`

➡️ The new schema: a version number, latest, id:`<schema id>` or @`<file>`

#### `--no-verdict`

🙅 Only the field-level diff, don't ask the registry for the compatibility verdicts

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
playground schema diff --subject orders-value
playground schema diff --subject orders-value --from 1 --to 3
playground schema diff --subject orders-value --to @customer-v4.avsc
playground schema diff --from @v1.avsc --to @v2.avsc --no-verdict
playground schema diff --from id:12 --to id:15 --json

```


