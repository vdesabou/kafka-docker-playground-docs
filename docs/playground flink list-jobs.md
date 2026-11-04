# playground flink list-jobs

📋 List the jobs of the Flink cluster

Job id, state, name, start time and duration of every job, most  
recent first. For a FAILED job, the root exception is also printed.

☁️ Confluent Cloud (`--environment` ccloud): the statements of the compute  
pool (name, status, SQL, creation time and age), with the status detail  
of the 5 most recent FAILED or DEGRADED statements.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-flink

## Usage

```bash
playground flink list-jobs [OPTIONS]
```

## Options

#### `--environment ENVIRONMENT`

🌍 local: the Flink cluster of `--enable-flink`. ccloud: a Confluent Cloud Flink compute pool

ℹ️ Default: `PLAYGROUND_FLINK_ENVIRONMENT`, else ccloud when the last example ran on Confluent Cloud, else local

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `local`, `ccloud`

#### `--state STATE`

🚦 Only list the jobs in this state

ℹ️ Confluent Cloud statements: PENDING, RUNNING, COMPLETED, DEGRADED, FAILING, FAILED, STOPPING, STOPPED, DELETING

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `INITIALIZING`, `CREATED`, `RUNNING`, `FAILING`, `FAILED`, `CANCELLING`, `CANCELED`, `FINISHED`, `RESTARTING`, `SUSPENDED`, `RECONCILING`, `PENDING`, `COMPLETED`, `DEGRADED`, `STOPPING`, `STOPPED`, `DELETING`

#### `--json`

📗 Print the jobs as a JSON array (the /jobs/overview REST API response, or 'confluent flink statement list' on Confluent Cloud) and nothing else

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground flink list-jobs
```

```bash
playground flink list-jobs --state RUNNING
```

```bash
playground flink list-jobs --json | jq -r '.[].jid'
```

```bash
playground flink list-jobs --environment ccloud --state RUNNING
```

## Example output

```text
$ playground flink list-jobs
13:22:10 ℹ️ 📋 Jobs of the Flink cluster (Flink 2.3.0, http://localhost:18081)
JOB ID                            STATE     NAME                                              START                DURATION
972185f42739cba34766e6dea6d80a50  RUNNING   insert-into_default_catalog.default_database.snk  2026-10-29 14:20:48  1m22s
```


