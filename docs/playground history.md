# playground history

🏰 Get an history of the examples which were run with run command and run it again

Opens a picker over every `playground run` command you have executed,  
most recent first and de-duplicated, with the result (✅ ❌ ⏭️ ⏹️) and  
the date of its last run, and a preview: duration, branch, number of runs,  
README title and, for a repro model, its expected / actual / status. The  
command you select is shown for editing before it runs, so you can change  
a `--tag` or add a flag on the way (tab completes the flags and their values).

The runs are kept in playground-run-history (repository root), one  
shell-quoted line each, followed by a comment eval ignores:  
date=… branch=… result=… duration=… (seconds). Runs whose script no  
longer exists are not shown (`--all` to show them, `--prune` to remove them).

`--cluster-creds` and `--cluster-schema-registry-creds` are written as  
'`<masked>`': they are taken from playground.ini when the run used the  
cluster saved there, otherwise replace '`<masked>`' when editing the line.

🎓 Tip: `--list`, `--json`, `--last` and `--run` need no terminal, for scripts and  
AI agents.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-run-and-versions  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%95%B9%EF%B8%8F-run-an-example-with-the-menu-or-with-flags

## Usage

```bash
playground history [QUERY] [OPTIONS] [--] [MORE QUERY WORDS...]
```

## Dependencies

#### *fzf*

visit https://github.com/junegunn/fzf#installation to install

## Arguments

#### `QUERY`

🔤 Words that the command must contain (script path, flags, versions),  
e.g. "s3 sink 8.2.0" or a case number. With the picker, its initial  
query.

#### *MORE QUERY WORDS...*

extra words are appended to the query, so quoting it is optional

## Options

#### `--list`

📜 Print the runs, most recent first, without the picker: the command,  
then its result, date, duration, branch and number of runs

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--last`, `--run`, `--stats`, `--prune`

#### `--json`

📗 Print the runs as a JSON array, most recent first, and nothing else

Each run has command, script, path (relative to the repository), exists,  
date, result (SUCCESS, FAILURE, SKIPPED, INTERRUPTED, null for runs  
recorded before the results were kept), duration_seconds, branch and runs.  
No run prints [] and exits with code 1.

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--last`, `--run`, `--stats`, `--prune`

#### `--limit LIMIT`

🔢 Maximum number of runs printed by `--list` / `--json` (default 20, 0 for all)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `20`

#### `--all`

🗑️ Also show the runs whose script no longer exists

#### `--last`

⏮️ Print the most recent command matching the query (the last run  
without query), and nothing else

The `--cluster-creds` and `--cluster-schema-registry-creds` values are  
printed as '`<masked>`': use `--run` to replay the command with them

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--list`, `--json`, `--run`, `--stats`, `--prune`, `--session`

#### `--run`

🚀 Run the most recent command matching the query, without the picker  
nor the edit prompt

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--list`, `--json`, `--last`, `--stats`, `--prune`, `--session`

#### `--stats`

📊 Print the most run examples, the most used `--tag`, `--connector-tag` and  
`--environment`, and the results, over every run of the history (the query is  
ignored)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--list`, `--json`, `--last`, `--run`, `--prune`, `--session`

#### `--session`

🛠️ Print what was done to the running environment since it started: the  
playground commands that change it (containers killed or restarted,  
faults injected with debug, connectors created, updated or deleted,  
offsets changed, records produced, topics, brokers, quotas, schemas...),  
with their time, duration and exit code, oldest first. Read-only  
commands are not recorded.

They are kept in playground-session.log (repository root, secrets  
masked), reset by `playground run` and `playground start-environment`,  
kept by `playground stop` until the next start. With `--json`: an object  
with started, started_by and the actions (time, epoch, duration_seconds,  
exit_code, command). `playground connector history --with-logs` shows  
them next to the states of a connector and the errors of the logs.

ℹ️ `PLAYGROUND_SESSION_LOG_DISABLED`=1 turns the recording off

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--last`, `--run`, `--stats`, `--prune`

#### `--prune`

🧹 Rewrite playground-run-history with one line per command (its last  
run) and without the runs whose script no longer exists. The previous  
file is kept as playground-run-history.bak

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--list`, `--json`, `--last`, `--run`, `--stats`, `--session`

## Examples

```bash
playground history
```

```bash
playground history s3 sink
```

```bash
playground history --list --limit 5
```

```bash
playground history 369368 --last
```

```bash
playground history redshift --run
```

```bash
playground history --json --limit 3 | jq -r '.[] | select(.result == "FAILURE") | .command'
```

```bash
playground history --stats
```

```bash
playground history --prune
```

```bash
playground history --session
```

```bash
playground history --session --json | jq -r '.actions[] | select(.exit_code != 0) | .command'
```

## Example output

```text
$ playground history --session
🛠️  2 action(s) recorded
13:51:03 UTC  ❌    1s  playground container pause --container pg-session-log-test-nonexistent   (exit code 1)
13:51:04 UTC  ❌    0s  playground container resume --container pg-session-log-test-nonexistent   (exit code 1)
```


