# playground broker transactions describe

🔎 Describe a transactional id

State, producer id and epoch, timeout, start time and duration of the  
current transaction, and the partitions it writes to.

## Usage

```bash
playground broker transactions describe [OPTIONS]
```

## Options

#### `--transactional-id, -i TRANSACTIONAL-ID`

🆔 Transactional id (playground broker transactions list)

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground broker transactions describe --transactional-id my-txn-producer
```


