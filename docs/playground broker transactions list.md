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


