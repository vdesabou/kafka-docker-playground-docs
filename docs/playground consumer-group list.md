# playground consumer-group list

👥 List consumer groups

## Usage

```bash
playground consumer-group list [OPTIONS]
```

## Options

#### `--state`

🚦 Also display the state of each group (Stable, Empty, PreparingRebalance...)

#### `--verbose, -v`

🐞 Show command being ran.

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

## Examples

```bash
playground consumer-group list
```

```bash
playground consumer-group list --state
```

## Example output

```text
$ playground consumer-group list
17:22:17 ℹ️ 👥 Listing consumer groups
connect-filestream-sink
```


