# playground flink cancel

🛑 Cancel a Flink job

Cancels `--job`, or every running job with `--all`, and waits until the  
job is CANCELED (30 seconds at most). Without `--job` and `--all`, the  
running job is cancelled when there is only one.

☁️ Confluent Cloud (`--environment` ccloud): stops the statement (it can be  
resumed with 'confluent flink statement resume'), or deletes it with  
`--delete`. `--all` and the default only pick the running statements created  
by `playground flink sql` of this user (name pg-`<user>`-…), as the  
compute pool can be shared: other statements need `--job`.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-flink

## Usage

```bash
playground flink cancel [OPTIONS]
```

## Options

#### `--environment ENVIRONMENT`

🌍 local: the Flink cluster of `--enable-flink`. ccloud: a Confluent Cloud Flink compute pool

ℹ️ Default: `PLAYGROUND_FLINK_ENVIRONMENT`, else ccloud when the last example ran on Confluent Cloud, else local

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `local`, `ccloud`

#### `--job, -j JOB`

🆔 Id of the job to cancel, or name of the Confluent Cloud statement (see playground flink list-jobs)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--all`

#### `--all`

💥 Cancel all running jobs

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--job`

#### `--delete`

🗑️ Confluent Cloud only: delete the statements instead of stopping them. With `--all`: every statement  
created by playground flink sql of this user, whatever its status (STOPPED, COMPLETED, FAILED…)

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

```bash
playground flink cancel --environment ccloud --all --delete
```


