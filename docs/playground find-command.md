# playground find-command

🧭 Find the playground command that answers a question, without reading the docs

Describe what you want to know or the symptom, in your own words ("why is  
my connector not working", "customer support bundle cfk", "which version  
fixes this CVE", "kafka-consumer-groups reset offsets"). It searches, best  
weighted first:

- the question to command catalog: https://kafka-docker-playground.io/#/which-command
- the "Recipes for support repros" table of every deep dive
- the help of every command

and prints one entry per command, best first, with the question or symptom  
it matched, how to call it and the deep dive to read next. Common words  
(why, is, my, the...) are ignored, plurals and -ing / -ed forms match.

Use `playground find-example` to find an example to run instead.

🍪 Deep dives: https://kafka-docker-playground.io/#/deep-dives

## Usage

```bash
playground find-command QUERY [OPTIONS] [--] [MORE QUERY WORDS...]
```

## Arguments

#### `QUERY`

🔤 Question or symptom, e.g. "connector stuck high cpu", "who deleted the schema" or "docker logs"

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *MORE QUERY WORDS...*

extra words are appended to the query, so quoting it is optional

## Options

#### `--limit LIMIT`

🔢 Maximum number of commands (default 5)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `5`

#### `--json`

📗 Print the hits as a JSON array, best first, and nothing else

Each hit has command, matched (the question, symptom or help summary  
that matched), usage (how to call it, from the catalog or the deep  
dive), deep_dive, source (catalog, deep dive or help), score and  
help_command. No hit prints [] and exits with code 1.

🎓 Tip: use it from scripts and AI agents, for example with  
jq -r '.[0].command'

## Examples

```bash
playground find-command "why is my connector not working"
```

```bash
playground find-command customer support bundle cfk
```

```bash
playground find-command "which version fixes this CVE" --limit 3
```

```bash
playground find-command "kafka-consumer-groups reset offsets" --json | jq -r '.[0].command'
```

## Example output

```text
$ playground find-command "why is my connector not working" --limit 2
11:12:18 ℹ️ 🧭 commands matching "why is my connector not working", best first

playground connector diagnose
    ❓ why is this connector not working?
    👉 playground connector diagnose [--connector <c>] (status + error digest + lag/offsets + next steps, HTML report in /tmp/playground-diagnose, --no-open)
    🍪 https://kafka-docker-playground.io/#/deep-dive-connector-troubleshooting

playground connector tasks
    ❓ why does one task do all the work? which worker / partitions / tables does each task get? which topics does it use?
    👉 playground connector tasks [--connector <c>] (state, worker, the config keys that differ per task, partitions of each sink task, --all-keys, --json) / playground connector topics (active topics, --reset); playground connector restart --only-failed restarts only what is FAILED
    🍪 https://kafka-docker-playground.io/#/deep-dive-connector-troubleshooting

11:12:18 ℹ️ 🎓 playground <command> --help shows every flag and an example output
```


