# playground schema delete

🧟 Delete schema

Without `--version` the whole subject goes; with it, only that version.

A plain delete is soft: the schema is hidden but its id and version  
number stay taken, so re-registering does not reuse them. Add  
`--permanent` to really remove it, which is what you need before  
re-creating the same subject from scratch.

❕ The registry requires a soft delete before a permanent one; with  
`--permanent` the command does both for you.

The command fails (exit 1) when the registry refuses the delete, and  
lists the schemas that reference a version it can't delete (42206).

🎓 Tip: `--dry-run` shows the versions and ids that would be deleted, and  
which ids would stop resolving after a permanent delete (old records  
written with them could not be deserialized any more).

## Usage

```bash
playground schema delete [OPTIONS]
```

## Options

#### `--subject SUBJECT`

📛 Subject name to delete:

if `--version` is provided, only that version will be deleted. Otherwise the complete subject will be deleted

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--version VERSION`

🔢 Schema version of the provided subject to delete

Can only be used when `--subject` is provided

#### `--permanent`

💀 Hard delete (default is soft delete)

#### `--dry-run`

🧪 Show what would be deleted, and its effect on the schema ids, without deleting anything

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
playground schema delete --subject orders-value --version 2
```

```bash
playground schema delete --subject orders-value --permanent --dry-run
```

```bash
playground schema delete --subject orders-value --permanent
```


