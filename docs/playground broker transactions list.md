# playground broker transactions list

📋 List the transactional ids

## Usage

```bash
playground broker transactions list [OPTIONS]
```

## Options

#### `--state STATE`

🔎 Only the transactional ids in this state

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `Empty`, `Ongoing`, `PrepareCommit`, `PrepareAbort`, `CompleteCommit`, `CompleteAbort`, `Dead`, `PrepareEpochFence`

#### `--pattern REGEX`

🔎 Only the transactional ids matching this regular expression

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
playground broker transactions list
```

```bash
playground broker transactions list --state Ongoing
```

```bash
playground broker transactions list --pattern "connect-cluster-.*"
```


