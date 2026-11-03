# playground broker transactions find-hanging

🧟 Find hanging transactions

A transaction is hanging when it is open on a partition for longer  
than `--max-transaction-timeout` minutes, and its coordinator does not  
know it anymore: it will never end on its own. Searches every broker,  
or `--broker`, or the partitions of `--topic`.

Exits with 1 when hanging transactions are found, and prints the  
abort command of each.

## Usage

```bash
playground broker transactions find-hanging [OPTIONS]
```

## Options

#### `--broker, -b BROKER`

🖥️ Only the partitions of this broker (default: all brokers)

#### `--topic, -t TOPIC`

🗳 Only the partitions of this topic

#### `--partition, -p PARTITION`

🔢 Only this partition (needs `--topic`)

#### `--max-transaction-timeout MINUTES`

⏱️ Only the transactions open for longer than this, in minutes (default: transaction.max.timeout.ms of the brokers, 15 minutes unless changed)

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
playground broker transactions find-hanging
```

```bash
playground broker transactions find-hanging --topic orders
```

```bash
playground broker transactions find-hanging --broker 1 --max-transaction-timeout 5
```


