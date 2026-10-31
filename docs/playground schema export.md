# playground schema export

📦 Export the subjects of the registry to a folder

One file per version (`<subject>`/v`<n>`.avsc|json|proto, pretty-printed)  
and a manifest.json with the ids, versions, references, metadata, rule  
sets, and the subject-level compatibility, mode and alias. 'playground  
schema import' loads it into another registry with the same ids, so  
records copied from the source still decode.

🎓 Tip: export into the folder of a reproduction model and add  
`playground schema import -f <the model folder>/schemas` before  
creating the connector: the model ships the customer's schemas.

## Usage

```bash
playground schema export [OPTIONS]
```

## Options

#### `--subject-prefix PREFIX`

🔎 Only the subjects starting with this prefix

#### `--output-dir, -o FOLDER`

📁 Folder to write (created if needed, files of the same name are overwritten)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `schemas-export`

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
playground schema export -o /tmp/schemas
```

```bash
playground schema export --subject-prefix orders -o ./schemas
```


