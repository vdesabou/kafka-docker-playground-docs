# playground schema get-mode

🔏 Get subject-level mode

READWRITE normally; READONLY if registration has been frozen; IMPORT  
while schemas are being migrated with their original ids and versions.

## Usage

```bash
playground schema get-mode [OPTIONS]
```

## Options

#### `--subject SUBJECT`

📛 Subject name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--verbose, -v`

🐞 Show command being ran.

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`


