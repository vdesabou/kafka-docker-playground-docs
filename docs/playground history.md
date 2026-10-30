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

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--list`, `--json`, `--run`, `--stats`, `--prune`

#### `--run`

🚀 Run the most recent command matching the query, without the picker  
nor the edit prompt

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--list`, `--json`, `--last`, `--stats`, `--prune`

#### `--stats`

📊 Print the most run examples, the most used `--tag`, `--connector-tag` and  
`--environment`, and the results

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--list`, `--json`, `--last`, `--run`, `--prune`

#### `--prune`

🧹 Rewrite playground-run-history with one line per command (its last  
run) and without the runs whose script no longer exists. The previous  
file is kept as playground-run-history.bak

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--list`, `--json`, `--last`, `--run`, `--stats`

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


