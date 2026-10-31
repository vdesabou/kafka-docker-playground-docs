# playground schema exporter list

📋 List the exporters of the registry, with their state

## Usage

```bash
playground schema exporter list [OPTIONS]
```

## Options

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


