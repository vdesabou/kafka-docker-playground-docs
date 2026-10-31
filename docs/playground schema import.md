# playground schema import

📥 Import schemas into the registry, keeping their ids

Loads what a customer can send about their registry:

- a folder (or .tgz / .zip) written by `playground schema export`
- a JSON array of versions: curl `<registry>`/schemas, or

`playground schema get --json`

- a dump of the _schemas topic ('playground topic consume -t _schemas

`--json`', or kafka-console-consumer with print.key=true and  
print.timestamp=true): the last state of every live version

Every version is registered in IMPORT mode with its original id and  
version number (in id order, so references exist first), then the  
subject goes back to its normal mode and gets the compatibility, mode  
and alias of the source. Records written with those ids decode here.

⚠️ IMPORT mode needs mode.mutability=true on the registry (the  
playground's has it), and an id already used by another schema here is  
refused (42205): import into a fresh registry, or use `--new-ids`.

## Usage

```bash
playground schema import [OPTIONS]
```

## Options

#### `--file, -f FILE`

📄 Export folder, .tgz / .zip of one, JSON array of versions, or _schemas dump

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--on-conflict ACTION`

🤝 What to do with a subject that already exists: skip it, overwrite it (permanently deleted first), or merge (versions added to it)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `skip`
| Allowed Values: | `skip`, `overwrite`, `merge`

#### `--new-ids`

🆕 Let the registry assign new ids (no IMPORT mode): the schemas are the same, the ids in old records don't match

#### `--with-global-settings`

🌍 Also apply the global compatibility of the source

#### `--subject-prefix PREFIX`

🔎 Only the subjects starting with this prefix

#### `--dry-run`

🧪 Show what would be imported, and the conflicts, without changing anything

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
playground schema import -f /tmp/schemas --dry-run
```

```bash
playground schema import -f customer-schemas.json --on-conflict overwrite
```

```bash
playground schema import -f customer-_schemas-dump.txt --new-ids
```


