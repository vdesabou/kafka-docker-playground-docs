# playground ksqldb sql

🧮 Run ksqlDB statements with the ksql cli

The statements are read from stdin (heredoc) or `--file`, and run in one  
ksql cli session (ksql `--file`) in the ksqldb-cli container: so SET  
'auto.offset.reset' = 'earliest' applies to the statements that follow  
it in the same call. DDL, INSERT INTO, pull and push queries, PRINT,  
SHOW, DESCRIBE... are all supported, and their results are printed as  
tables.

Every statement is run, even after a failing one. The errors are  
printed with ❌, and the command then exits with code 1, unless  
`--ignore-errors` is set (a statement that is expected to fail, to  
show the error).

🎓 Tip: a push query (EMIT CHANGES) never ends without a LIMIT: add  
LIMIT `<n>`, or `--query-timeout`. Otherwise the cli is stopped after  
`--max-wait` seconds. To wait for a CREATE ... AS SELECT to process its  
input before querying it, use `playground ksqldb wait` instead of a sleep.

## Usage

```bash
playground ksqldb sql [OPTIONS]
```

## Options

#### `--file, -f FILE`

📄 File with the ksqlDB statements, separated by ;

ℹ️ If not set, the statements are read from stdin

#### `--max-wait, -w MAX_WAIT`

⏳ Stop the ksql cli after this number of seconds (default 120)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `120`

#### `--query-timeout QUERY_TIMEOUT`

⏱️ Stop each push query (EMIT CHANGES) after this number of seconds, like a LIMIT in time

ℹ️ ksql `--query-timeout`

#### `--ignore-errors`

🙈 Do not exit with code 1 when a statement fails (its error is still printed)

#### `--width WIDTH`

📏 Width of the result tables, split between their columns

ℹ️ Default: the width of the terminal, 200 when the output is not a terminal

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground ksqldb sql << 'EOF'
SET 'auto.offset.reset' = 'earliest';
CREATE STREAM orders (id INT, product VARCHAR) WITH (kafka_topic='orders', value_format='json', partitions=1);
INSERT INTO orders (id, product) VALUES (1, 'foo');
SELECT * FROM orders EMIT CHANGES LIMIT 1;
EOF
```

```bash
playground ksqldb sql --file ./queries.sql
```

```bash
echo "SELECT * FROM orders EMIT CHANGES;" | playground ksqldb sql --query-timeout 10
```

```bash
echo "CREATE STREAM orders (id INT) WITH (kafka_topic='orders', value_format='json');" | playground ksqldb sql --ignore-errors
```

## Example output

```text
$ playground ksqldb sql --file ./queries.sql
11:02:31 ℹ️ 🧮 Running ksqlDB statements in ksqldb-cli container (ksqlDB 8.4.0, http://localhost:8088)
Successfully changed local property 'auto.offset.reset' to 'earliest'. Use the UNSET command to revert your change.

 Message
----------------
 Stream created
----------------
❌ Exception while preparing statement: NOPE does not exist.
+----------------------+----------------------+
|ID                    |PRODUCT               |
+----------------------+----------------------+
|1                     |foo                   |
Limit Reached
Query terminated
11:02:36 ❗ ❌ 1 ksqlDB statement(s) failed (the other statements were run):
   Exception while preparing statement: NOPE does not exist.
11:02:36 ❗    🎓 add --ignore-errors when the failure is expected
```


