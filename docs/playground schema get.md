# playground schema get

🔰 Get all schemas versions for specified subject (if `--subject` is not specified, all subjects will be used)

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

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `subject`, `deleted`

#### `--verbose, -v`

🐞 Show command being ran.

#### `--deleted`

🧟 Include soft deleted subjects

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `id`

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
playground schema get --deleted
```


