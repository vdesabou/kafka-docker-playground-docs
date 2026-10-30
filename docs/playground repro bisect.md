# playground repro bisect

🔀 Run a reproduction model on several versions: which one introduced or fixed the problem

Runs the model once per version ('playground run -f `<model>`  
`--connector-tag` `<version>`', or `--tag` for CP versions) and reads the  
verdict that `playground repro assert` records at the end of each run.  
The model must end with `playground repro assert`.

- `--connector-tag A --connector-tag B …`: these connector versions
- `--from A --to B`: the Confluent Hub versions of the connector of the model between A and B: a binary search (first, last, then the middle until the verdict changes), `--all` for every one
- `--tag A --tag B …`: these CP versions

Prints the verdict of each version (🐞 reproduced, ✅ not reproduced,  
❓ no verdict when the run stopped before 'repro assert'), the versions  
where it changes and, for a Confluent connector, the changelog between  
them (`playground connector-plugin changelog`). The log of each run is  
in /tmp/playground-repro-bisect/`<model>`-`<version>`.log, the summary in  
/tmp/playground-repro-bisect/`<model>`-`<date>`.json.

⚠️ Each run stops the running environment, like `playground run`, and a  
run takes the time of the model: a binary search over 30 versions is  
about 6 runs.

## Usage

```bash
playground repro bisect [OPTIONS]
```

## Options

#### `--file, -f FILE`

🔖 Reproduction model to run (default: current one)

#### `--connector-tag CONNECTOR-TAG`

🔗 Connector version to run, repeat it for each version

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Conflicts With: | `--from`, `--to`

#### `--from VERSION`

⏮️ First Confluent Hub version of the connector of the model (default: the oldest one)

#### `--to VERSION`

⏭️ Last Confluent Hub version of the connector of the model (default: the latest one)

#### `--all`

📚 With `--from` / `--to`, run every version of the range instead of a binary search

#### `--tag TAG`

🎯 CP version: repeat it to compare CP versions, or give one to run every connector version on it

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--run-flags FLAGS`

⛳ Other flags of `playground run` for every run, for example "`--environment` sasl-ssl"

#### `--json`

🤖 Print the summary as JSON

## Examples

```bash
playground repro bisect --connector-tag 2.14.0 --connector-tag 2.14.5 --connector-tag 3.0.0
```

```bash
playground repro bisect --from 2.10.0 --to 3.0.0
```

```bash
playground repro bisect -f ~/kafka-docker-playground/reproduction-models/connect-connect-http-sink/http-repro-123456-dlq.sh --tag 7.9.0 --tag 8.2.0 --tag 8.4.0
```


