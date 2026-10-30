# playground repro assert

🧪 End a reproduction model with its verdict: 🐞 REPRODUCED or ✅ NOT REPRODUCED

Put it at the end of the scenario, with the check that says the  
problem is there (the 💥 actual of the header). It prints the verdict  
with the CP and connector versions, and records it in  
playground-repro-verdicts (a local file of the repository root, not  
committed), so that it can be compared between runs and versions:

- `playground repro status`: shows the last verdict of the model
- `playground repro export`: writes it in repro-manifest.json

One check per call (combine several with `--reproduced-if-command`):

- `--reproduced-if-log <pattern>`: a line of the logs of `--container` (default connect) matches (grep)
- `--reproduced-if-connector-state <state>`: the connector or one of its tasks is in this state
- `--reproduced-if-records-less-than <n>`: `--topic` has less records
- `--reproduced-if-records-more-than <n>`: `--topic` has more records
- `--reproduced-if-command "<command>"`: the shell command succeeds

Both verdicts exit with 0: a model that does not reproduce is a result,  
not an error. The exit code is 1 only when the check cannot run.

Without `--file`, the verdict is recorded for the current model (the one  
`playground run` runs).

## Usage

```bash
playground repro assert [OPTIONS]
```

## Options

#### `--reproduced-if-log PATTERN`

🔍 Reproduced when a line of the logs of `--container` matches this grep pattern

#### `--container, -c CONTAINER`

🐳 Container whose logs `--reproduced-if-log` reads (default: connect)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `connect`

#### `--reproduced-if-connector-state STATE`

🧩 Reproduced when the connector or one of its tasks is in this state

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `FAILED`, `RUNNING`, `PAUSED`, `STOPPED`, `UNASSIGNED`, `RESTARTING`

#### `--connector CONNECTOR`

🔗 Connector of `--reproduced-if-connector-state` (default: the only one running)

#### `--reproduced-if-records-less-than NUMBER`

📉 Reproduced when `--topic` has less records than this (records lost, not delivered)

#### `--reproduced-if-records-more-than NUMBER`

📈 Reproduced when `--topic` has more records than this (duplicates, records sent to a DLQ)

#### `--topic, -t TOPIC`

🗳 Topic of `--reproduced-if-records-less-than` / `--reproduced-if-records-more-than`

#### `--reproduced-if-command COMMAND`

💻 Reproduced when this shell command succeeds (exit code 0)

#### `--message, -m MESSAGE`

💬 Text printed with the verdict, before what the check found

#### `--file, -f FILE`

🔖 Reproduction model the verdict is recorded for (default: current one)

#### `--json`

🤖 Print the verdict as JSON

## Examples

```bash
playground repro assert --reproduced-if-log "Unknown magic byte"
```

```bash
playground repro assert --reproduced-if-connector-state FAILED --connector http-sink
```

```bash
playground repro assert --reproduced-if-records-less-than 10 --topic orders --message "records lost"
```

```bash
playground repro assert --reproduced-if-command "playground topic get-number-records --topic dlq | tail -1 | grep -qv '^0$'"
```


