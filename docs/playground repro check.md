# playground repro check

🕵️ Scan reproduction models for secrets and customer data before they are committed

Runs the scan of `playground repro export` on the files of the  
reproduction models, without packing anything. It stops (exit code 1)  
when a file contains the value of a credential known to this machine  
(`playground secrets` store, exported credential variables,  
`CLUSTER_CREDS` / `SCHEMA_REGISTRY_CREDS` of playground.ini,  
~/.aws/credentials) or a well-known token format (AWS access key id,  
private key, GitHub / Slack token, Google API key, JWT, Azure storage  
account key), and when a credential file (keyfile.json, \*.pem, \*.key,  
\*.p12, \*.jks, secrets.properties, playground.ini) is about to be  
committed. Email addresses, public IP addresses, hard-coded passwords  
that do not come from the base example, and dumps, logs or archives  
are reported as possible customer data, without failing. Values are  
never printed.

Without flag, the new and modified files of reproduction-models are  
checked. Symlinks to the public examples are not.

🪝 `playground repro bootstrap` and `playground repro import` set up a  
pre-commit hook in reproduction-models (git config core.hooksPath  
`<playground>`/scripts/repro-git-hooks) that runs  
`playground repro check --staged --skip-secrets-store` on every commit.  
An existing pre-commit hook or core.hooksPath is never replaced. To skip  
the scan of one commit: git commit `--no-verify`, or  
`PLAYGROUND_REPRO_SCAN`=skip git commit. `PLAYGROUND_REPRO_SCAN`=full also  
reads the `playground secrets` store.

## Usage

```bash
playground repro check [OPTIONS]
```

## Dependencies

#### *git*

visit https://git-scm.com/downloads to install

## Options

#### `--file, -f FILE`

🔖 Reproduction model script to check (the files export would pack), can be repeated

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Conflicts With: | `--staged`, `--all`

#### `--staged`

🪝 Check the staged content of the files about to be committed (what the pre-commit hook uses)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--file`, `--all`

#### `--all`

📚 Check every file of reproduction-models, committed or not (one-time audit)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--file`, `--staged`

#### `--skip-secrets-store`

⚡ Do not read the `playground secrets` store, which can prompt (1Password): only the exported variables, playground.ini and ~/.aws/credentials values, and the token formats

#### `--json`

🤖 Print the findings as JSON (exit code 1 still means a secret was found)

## Examples

```bash
playground repro check
```

```bash
playground repro check --staged
```

```bash
playground repro check -f ~/kafka-docker-playground/reproduction-models/connect-connect-http-sink/http-repro-123456-dlq.sh
```

```bash
playground repro check --all --json
```


