# playground ksqldb wait

⏳ Wait until the persistent queries are RUNNING and have no lag

Waits until every query writing to `--source` (or every persistent  
query) is RUNNING and has committed all the records of its input  
topics, so that its result is complete: use it instead of a sleep  
after a CREATE ... AS SELECT and the records it reads.

A query that has not committed any offset yet is done when its input  
topics are empty, or when it is still without commit after 20 seconds  
RUNNING: it has nothing to process from where it started (a CREATE  
sent without SET 'auto.offset.reset' = 'earliest' reads from the end  
of its topics), and a warning says so.

Exits with code 1 when a query is in ERROR, or after `--max-wait` seconds.

## Usage

```bash
playground ksqldb wait [OPTIONS]
```

## Options

#### `--source, -s SOURCE`

🧮 Only wait for the queries writing to this stream or table (repeatable)

ℹ️ If not set, all persistent queries

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--max-wait, -w MAX_WAIT`

⏳ Maximum number of seconds to wait (default 120)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `120`

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground ksqldb wait
```

```bash
playground ksqldb wait --source currentLocation --source ridersNearMountainView
```

```bash
playground ksqldb wait --source ORDERS_ENRICHED --max-wait 3600
```


