# playground schema list

📋 List the subjects of the registry

One line per subject: number of versions, latest version and its schema  
id, schema type, and the compatibility rule and mode in force. A 🌍  
marks a value inherited from the global setting of the registry  
(no subject-level rule), which is what applies when a producer  
registers a new version.

🎓 Tip: the subject names tell you the subject name strategy of the  
producers: `<topic>`-value (TopicNameStrategy), `<record name>`  
(RecordNameStrategy) or `<topic>`-`<record name>` (TopicRecordNameStrategy).

## Usage

```bash
playground schema list [OPTIONS]
```

## Options

#### `--prefix PREFIX`

🔎 Only the subjects starting with this prefix

#### `--deleted`

🧟 Include soft deleted subjects

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
playground schema list
```

```bash
playground schema list --prefix orders --deleted
```

```bash
playground schema list --json | jq -r '.subjects[] | select(.compatibility_source == "subject") | .subject'
```


