# playground broker config get

🔎 Display dynamic broker configs

Without `--key`, displays the dynamic configs set cluster-wide and on  
each broker (or on `--broker` only). With `--key`, displays the value used  
by each broker and where it comes from (`DYNAMIC_BROKER_CONFIG`,  
`DYNAMIC_DEFAULT_BROKER_CONFIG`, `STATIC_BROKER_CONFIG` or `DEFAULT_CONFIG`).  
With `--all`, displays every config of the broker.

## Usage

```bash
playground broker config get [OPTIONS]
```

## Options

#### `--broker, -b BROKER`

🖥️ Broker id (default: all brokers, plus the cluster-wide default for set and delete)

#### `--key, -k KEY`

🔑 Config key (e.g. log.retention.ms)

#### `--all`

📜 Display every config of the broker (static and default ones too), not only the dynamic ones

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--key`

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground broker config get
```

```bash
playground broker config get --key num.io.threads
```

```bash
playground broker config get --broker 1 --all
```

## Example output

```text
$ playground broker config get --key log.retention.ms
15:02:10 ℹ️ 🔎 Value of log.retention.ms on each broker
BROKER   VALUE                SOURCE
1        60000                DYNAMIC_DEFAULT_BROKER_CONFIG
```


