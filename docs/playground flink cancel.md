# playground flink cancel

🛑 Cancel a Flink job

Cancels `--job`, or every running job with `--all`, and waits until the  
job is CANCELED (30 seconds at most). Without `--job` and `--all`, the  
running job is cancelled when there is only one.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-flink

## Usage

```bash
playground flink cancel [OPTIONS]
```

## Options

#### `--job, -j JOB`

🆔 Id of the job to cancel (see playground flink list-jobs)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--all`

#### `--all`

💥 Cancel all running jobs

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--job`

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground flink cancel
```

```bash
playground flink cancel --job 972185f42739cba34766e6dea6d80a50
```

```bash
playground flink cancel --all
```


