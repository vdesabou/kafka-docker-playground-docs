# playground flink list-jobs

📋 List the jobs of the Flink cluster

Job id, state, name, start time and duration of every job, most  
recent first. For a FAILED job, the root exception is also printed.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-flink

## Usage

```bash
playground flink list-jobs [OPTIONS]
```

## Options

#### `--state STATE`

🚦 Only list the jobs in this state

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `INITIALIZING`, `CREATED`, `RUNNING`, `FAILING`, `FAILED`, `CANCELLING`, `CANCELED`, `FINISHED`, `RESTARTING`, `SUSPENDED`, `RECONCILING`

#### `--json`

📗 Print the jobs as a JSON array (the /jobs/overview REST API response) and nothing else

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

## Example output

```text
$ playground flink list-jobs
13:22:10 ℹ️ 📋 Jobs of the Flink cluster (Flink 2.3.0, http://localhost:18081)
JOB ID                            STATE     NAME                                              START                DURATION
972185f42739cba34766e6dea6d80a50  RUNNING   insert-into_default_catalog.default_database.snk  2026-10-29 14:20:48  1m22s
```


