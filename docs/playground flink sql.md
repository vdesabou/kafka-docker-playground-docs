# playground flink sql

🐿️ Run Flink SQL statements with the SQL client

The statements are read from stdin (heredoc) or `--file`, and run in  
one SQL client session (bin/sql-client.sh -f) in the sql-client  
container, or in the jobmanager container when sql-client is stopped. So  
CREATE TABLE and the INSERT INTO that uses it must be sent in the  
same call.

Results are printed as tables (tableau result mode). An INSERT INTO  
submits a job to the cluster and returns right away: its job id is  
printed, follow it with `playground flink list-jobs`.

The client stops at the first failing statement, and the command  
then exits with code 1.

🎓 Tip: a SELECT on an unbounded table (Kafka, datagen) never ends in  
streaming mode: add a LIMIT, or SET 'execution.runtime-mode' = 'batch'  
on a bounded source. Otherwise the client is stopped after  
`--max-wait` seconds.

☁️ Confluent Cloud (`--environment` ccloud): each statement is a  
statement of the compute pool, created with 'confluent flink statement  
create' in the environment (catalog) and Kafka cluster (database) of the  
last ccloud example. The topics with a schema are tables already. SET  
and USE are sent as properties of the next statements. The rows of a  
query (SELECT, SHOW, DESCRIBE…) are read with the statement results REST  
API (a Flink API key is created once, see `FLINK_API_KEY`) and printed  
with the changelog applied, so an aggregation prints its final value; the  
query statement is then deleted. An INSERT INTO keeps RUNNING: follow it  
with `playground flink list-jobs`. `--max-wait` applies to each query.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-flink

## Usage

```bash
playground flink sql [OPTIONS]
```

## Options

#### `--environment ENVIRONMENT`

🌍 local: the Flink cluster of `--enable-flink`. ccloud: a Confluent Cloud Flink compute pool

ℹ️ Default: `PLAYGROUND_FLINK_ENVIRONMENT`, else ccloud when the last example ran on Confluent Cloud, else local

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `local`, `ccloud`

#### `--file, -f FILE`

📄 File with the SQL statements, separated by ;

ℹ️ If not set, the statements are read from stdin

#### `--max-wait, -w MAX_WAIT`

⏳ Stop the SQL client after this number of seconds (default 120)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `120`

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground flink sql << 'EOF'
CREATE TABLE orders (id INT, product STRING) WITH (
  'connector' = 'datagen', 'rows-per-second' = '1'
);
CREATE TABLE sink (id INT, product STRING) WITH ('connector' = 'print');
INSERT INTO sink SELECT * FROM orders;
EOF
```

```bash
playground flink sql --file ./queries.sql
```

```bash
playground flink sql --environment ccloud << 'EOF'
SELECT COUNT(*) AS nb_orders FROM flink_orders /*+ OPTIONS('scan.bounded.mode'='latest-offset') */;
EOF
```

## Example output

```text
$ playground flink sql --file ./queries.sql
13:20:47 ℹ️ 🐿️ Running Flink SQL statements in sql-client container (Flink 2.3.0, http://localhost:18081)
Flink SQL> CREATE TABLE src (id INT) WITH ('connector'='datagen','rows-per-second'='1')[INFO] Execute statement succeeded.
Flink SQL> CREATE TABLE snk (id INT) WITH ('connector'='blackhole')[INFO] Execute statement succeeded.
Flink SQL> [INFO] Submitting SQL update statement to the cluster...
[INFO] SQL update statement has been successfully submitted to the cluster:
Job ID: 972185f42739cba34766e6dea6d80a50
13:20:49 ℹ️ 🚀 Job 972185f42739cba34766e6dea6d80a50 submitted, follow it with: playground flink list-jobs
```


