# playground schema check-compatibility

🧪 Check whether a schema would be accepted, without registering it

Asks the registry the same question as a register (or a producer with  
auto.register.schemas=true) would, and prints its verdict with the  
reasons (`READER_FIELD_MISSING_DEFAULT_VALUE`, `TYPE_MISMATCH`…). Nothing  
is registered.

Without `--version`, the schema is checked against what the rule of the  
subject says: the latest version, or every version with a  
\*_TRANSITIVE rule. `--compatibility` evaluates it under another rule  
(in a temporary copy of the subject, permanently deleted afterwards).

Exit code: 0 compatible, 1 not compatible, 2 the check could not be  
done (invalid schema, unknown version…).

🎓 Tip: `playground schema diff --subject <s> --to @<file>` shows  
field by field what changed and why a rule refuses it.

## Usage

```bash
playground schema check-compatibility [OPTIONS]
```

## Options

#### `--subject SUBJECT`

📛 Subject name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--schema SCHEMA`

🔥 The schema to check (avro, json schema, protobuf): on stdin (default), @`<file>`, a file path, or the schema itself

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `-`

#### `--version VERSION`

🔢 Check against this version only (a number, or latest), instead of what the rule of the subject checks

#### `--compatibility COMPATIBILITY`

🛡️ Evaluate under this rule instead of the one of the subject

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `BACKWARD`, `BACKWARD_TRANSITIVE`, `FORWARD`, `FORWARD_TRANSITIVE`, `FULL`, `FULL_TRANSITIVE`, `NONE`

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
playground schema check-compatibility --subject orders-value < customer-v2.avsc
playground schema check-compatibility --subject orders-value --schema @customer-v2.avsc --compatibility FULL_TRANSITIVE
playground schema check-compatibility --subject orders-value --version 1 --json < customer-v2.avsc

```


