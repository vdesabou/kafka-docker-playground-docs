# playground ksqldb describe

🔎 Describe a stream or a table

Topic, formats, fields, the queries that write to it and read from it  
with their state and lag, the statistics (total-messages,  
messages-per-sec...) and the errors of the queries (DESCRIBE ...  
EXTENDED).

With `--json`, the REST API sourceDescription object, plus "stats" and  
"errors" (the statistics summed over the servers, by name) and "lag"  
(the lag of each query writing to it, by query id).

## Usage

```bash
playground ksqldb describe [OPTIONS]
```

## Options

#### `--source, -s SOURCE`

🧮 Name of the stream or table

ℹ️ Required when not in a terminal, otherwise picked with fzf

#### `--json`

📗 Print the description as JSON and nothing else

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground ksqldb describe --source ridersNearMountainView
```

```bash
playground ksqldb describe --source ORDERS_ENRICHED --json | jq '.stats."total-messages"'
```


