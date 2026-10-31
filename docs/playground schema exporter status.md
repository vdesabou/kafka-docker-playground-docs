# playground schema exporter status

🚦 State of an exporter (RUNNING, PAUSED, ERROR with its trace), offset and number of objects exported

Exit code 1 when the exporter is in ERROR.

## Usage

```bash
playground schema exporter status [OPTIONS]
```

## Options

#### `--name NAME`

📛 Exporter name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--wait`

⏳ Wait (30 seconds at most) until the exporter is RUNNING, PAUSED or ERROR

#### `--json`

📗 Print the result as JSON, and nothing else

#### `--verbose, -v`

🐞 Show command being ran.

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`


