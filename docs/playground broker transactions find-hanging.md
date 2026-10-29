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

⏱️ transaction.max.timeout.ms of the brokers, in minutes: only the transactions open for longer are checked (default 15)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `15`

#### `--verbose, -v`

🐞 Show command being ran.

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


