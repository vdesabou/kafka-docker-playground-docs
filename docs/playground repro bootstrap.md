# playground repro bootstrap

🛠  Bootstrap reproduction model, just run `<playground repro bootstrap>` !

🔥 HIGHLY RECOMMENDED: start in interactive mode by simple running `<playground repro bootstrap>` !

👉 Check documentation https://kafka-docker-playground.io/#/reusables?id=%f0%9f%9b%a0-bootstrap-reproduction-model

## Usage

```bash
playground repro bootstrap [OPTIONS]
```

## Options

#### `--file, -f FILE`

🔖 Example file to use as basis, if not set, currently running example is used

❕ It must be absolute full path

With `--config` and without `--file`, the example is picked from the  
connector.class of the config.

🎓 Tip: use `<tab>` completion to trigger fzf completion

#### `--description, -d DESCRIPTION`

💭 Description for the reproduction model

#### `--expected EXPECTED`

🎯 Expected behaviour, written in the '# 🎯 expected:' line of the header

Asked after the description in interactive mode. Update it later with  
`playground repro status --expected`.

#### `--actual ACTUAL`

💥 Actual behaviour (the problem), written in the '# 💥 actual:' line of the header

Asked after the description in interactive mode. Update it later with  
`playground repro status --actual`.

#### `--jira JIRA`

🎫 Jira of the problem, written in the '# 🎫 jira:' line of the header

A key (CC-1234) becomes its https://confluentinc.atlassian.net/browse/ link.

#### `--config CONFIG-FILE`

📄 Connector config the customer sent, put in the model in place of the one of the example

Any format of `playground connector convert`: a JSON config, a REST  
API dump, a CFK Connector or Strimzi KafkaConnector resource, a  
terraform confluent_connector, a connect-standalone .properties.

- without `--file`, the example to start from is the one that deploys

the same connector.class, ranked with the words of the class and  
of the config (the database of a jdbc url, the auth type…): the  
best one with `--no-run`, a list to pick from otherwise

- the connector heredoc of the example that deploys the same class

(else the first one) is replaced with the config, adapted to the  
playground like `playground connector create-or-update` does  
(bootstrap servers, schema registry, license, replication  
factors); the connector keeps the name of the example

- its secrets, masked values, config providers and terraform

references become variables, checked at the top of the model so  
that `playground run` loads them from `playground secrets`

🎓 Tip: then compare the running connector with the customer file:  
`playground connector diff --connector <c> --file <file>`

#### `--config-connector CONNECTOR`

🔗 With `--config`, the connector to pick when the file holds several (REST dump, several resources)

#### `--custom-smt`

🔧 Add a custom SMT (which is a no-op)

#### `--connector-plugin CONNECTOR-PLUGIN`

🔌 Add Connector plugin to `CONNECT_PLUGIN_PATH`

🎓 Tip: use `<tab>` completion to trigger fzf completion

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--pipeline SINK_FILE`

🔖 Sink example file to use for creating a pipeline. multiple `--pipeline` flags can be used to create a pipeline with multiple sinks.

❕ It must be absolute full path.

🎓 Tip: use `<tab>` completion to trigger fzf completion

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Conflicts With: | `--producer`

#### `--no-run`

🛑 Only generate the reproduction model files, then exit

Skips opening the generated file in the editor and running it, so  
the running environment is left untouched.

🎓 Tip: use it in scripts and from AI agents, together with `--file` and `--description`

## Examples

```bash
playground repro bootstrap (interactive mode)
```

```bash
playground repro bootstrap -f "$PWD/connect/connect-http-sink/http_no_auth.sh" -d "123456 dlq not working" --no-run
```

```bash
playground repro bootstrap --config ~/Downloads/customer-connector.yaml -d "123456 dlq not working" --no-run
```

```bash
playground repro bootstrap -f "$PWD/connect/connect-http-sink/http_no_auth.sh" -d "123456 dlq not working" --expected "bad records go to the DLQ" --actual "the task fails with Unknown magic byte" --jira CC-1234 --no-run
```


