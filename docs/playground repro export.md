# playground repro export

📤 Export reproduction models as a self-contained tgz bundle

Produces a single tgz that a colleague can feed to  
`playground repro import` to run your scenario as is.

The bundle holds what the model needs, committed or not: the script,  
the files of its folder it mentions (docker compose override, producer,  
SQL files…) and the support files linked by bootstrap (README.md,  
stop.sh, benchmark-load.bash, config-\*). Symlinks are stored as their  
content, so the bundle does not depend on the version of the base  
example. Git-ignored files, build output (target/), dumps, flight  
recordings, logs and credential files (keyfile.json, \*.pem, \*.key) are  
left out.

A repro-manifest.json describes the bundle: the last `playground run`  
line of each model (from playground-run-history), its case number,  
author, base example, the playground commit, the names (never the  
values) of the credentials it needs, and the sha256 of every file.

Before anything is written, the bundle is scanned. The export stops  
(unless `--force`) when a file contains the value of a credential known  
to this machine (`playground secrets` store, exported credential  
variables, `CLUSTER_CREDS` / `SCHEMA_REGISTRY_CREDS` of playground.ini,  
~/.aws/credentials) or a well-known token format (AWS access key id,  
private key, GitHub / Slack token, Google API key, JWT, Azure storage  
account key). Email addresses, public IP addresses and hard-coded  
passwords that do not come from the base example are reported as  
possible customer data. Values are never printed.

Files outside the repository that a model needs (`--connector-zip` /  
`--connector-jar` of its run line, files whose absolute path appears in  
the script or its compose files, like ~/Downloads/config.json) are  
only listed, unless `--include-artifacts` packs them under  
`<model folder>`/artifacts/. Import then points the run line, the script  
and the compose files to the imported copies. Import also rewrites the  
paths of the exporter's checkout (like the jar path written by  
'repro bootstrap `--custom-smt`') to the local ones.

`--cluster-creds` / `--cluster-schema-registry-creds` are removed from the  
run line: whoever imports runs with their own cluster.

Without `--file`, the current reproduction model is exported.

📖 Each model gets a hand-off report, `<model>`.REPRO.md next to its  
script in the bundle: case, jira, status, last verdict, 🎯 expected,  
💥 actual, the commands to import and run it, the credentials it  
needs, and what it changes compared with the script of its base  
example (diff). `playground repro import` prints where it is.  
`--report-only` prints it (Markdown, for a Jira or a Slack message)  
without writing the bundle, `--no-report` leaves it out.

📋 On macOS, the bundle is copied to the clipboard as a file: paste it  
(Cmd+V) in a Slack conversation to attach it (`--no-clipboard` to skip).

🎓 Tip: start with `--dry-run` to see what would be packed, and what the scan finds.  
The same scan runs on commits with `playground repro check`.

## Usage

```bash
playground repro export [OPTIONS]
```

## Dependencies

#### *git*

visit https://git-scm.com/downloads to install

## Options

#### `--file, -f FILE`

🔖 Reproduction model script to export (default: current one)

Can be repeated to put several models in one bundle.

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Conflicts With: | `--all-uncommitted`, `--all`

#### `--all-uncommitted`

📦 Export every reproduction model with uncommitted changes (new or modified)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--file`

#### `--output, -o OUTPUT`

📁 Folder where to write the bundle (default: current folder, or the repository root when run from reproduction-models)

#### `--dry-run`

🔍 Only list the models and files that would be packed, and run the scan

#### `--force`

🔓 Export even if the scan finds secrets (when they are not real ones)

#### `--include-artifacts`

📎 Also pack the files outside the repository the models need (connector zip / jar, files referenced by absolute path)

#### `--no-clipboard`

📋 Do not copy the bundle to the clipboard (macOS)

#### `--report-only`

📖 Print the hand-off report of the models (Markdown) on stdout, without writing the bundle (the scan still runs)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--no-report`, `--dry-run`

#### `--no-report`

📖 Do not put the hand-off report (`<model>`.REPRO.md) in the bundle

## Examples

```bash
playground repro export
```

```bash
playground repro export -f ~/kafka-docker-playground/reproduction-models/connect-connect-http-sink/http-repro-123456-dlq.sh --dry-run
```

```bash
playground repro export --all-uncommitted --output ~/Desktop
```

```bash
playground repro export --include-artifacts
```

```bash
playground repro export --report-only | pbcopy
```


