# playground repro diff

🔀 Show what a reproduction model changes compared with its base example

Compares the scenario of the model (without its header, the cheat  
sheet and the snippets after it) with the script of the example it  
was bootstrapped from, and its docker compose override with the one of  
the example. The compose override renamed by bootstrap  
(docker-compose.plaintext.repro-`<description>`.yml) is compared under  
the name of the example's, so that line is not reported.

Starts with a summary per connector: the config keys changed, added  
and removed (from the `playground connector create-or-update`  
heredocs), then the diffs (in color in a terminal).

The hand-off report of `playground repro export` has the same diffs.

Without `--file`, the current reproduction model is used.

## Usage

```bash
playground repro diff [OPTIONS]
```

## Options

#### `--file, -f FILE`

🔖 Reproduction model (default: current one)

#### `--summary`

🧩 Only the summary: config keys changed / added / removed per connector, whether the compose override changed

#### `--compose`

🐳 Only the diff of the docker compose override

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--summary`

#### `--json`

🤖 Print the summary and the diffs as JSON

## Examples

```bash
playground repro diff
```

```bash
playground repro diff -f ~/kafka-docker-playground/reproduction-models/connect-connect-http-sink/http-repro-123456-dlq.sh --summary
```

```bash
playground repro diff --json | jq '.connectors'
```


