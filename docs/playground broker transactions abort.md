# playground broker transactions abort

🧹 Abort a hanging transaction

Writes an abort marker for the transaction started at `--start-offset`  
on a partition (requires administrative privileges). Its records are  
discarded, and read_committed consumers move on. The start offset is  
printed by find-hanging and describe-producers.

## Usage

```bash
playground broker transactions abort [OPTIONS]
```

## Options

#### `--topic, -t TOPIC`

🗳 Topic name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--partition, -p PARTITION`

🔢 Partition

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--start-offset OFFSET`

📍 Start offset of the transaction to abort

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground broker transactions abort --topic orders --partition 0 --start-offset 1234
```


