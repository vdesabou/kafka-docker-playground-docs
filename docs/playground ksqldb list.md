# playground ksqldb list

📋 List the streams, tables and persistent queries

Name, topic, key and value formats of every stream and table, then the  
persistent queries with their state and sinks (SHOW STREAMS, SHOW  
TABLES and SHOW QUERIES).

## Usage

```bash
playground ksqldb list [OPTIONS]
```

## Options

#### `--json`

📗 Print {"streams": [...], "tables": [...], "queries": [...]} (the REST API objects) and nothing else

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground ksqldb list
```

```bash
playground ksqldb list --json | jq -r '.queries[] | select(.state != "RUNNING") | .id'
```


