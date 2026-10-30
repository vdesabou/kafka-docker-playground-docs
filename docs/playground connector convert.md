# playground connector convert

🔄 Convert a connector config from the format a customer sent to another one

Reads the config in any of these formats (detected, `--from` to force  
one), and writes it in the format of `--to`:

- **json**: a plain config, the REST API format {"name": ..., "config": {...}}, a dump of GET /connectors?expand=info
- **heredoc**: a `playground connector create-or-update` heredoc, as printed by show-config
- **cfk**: a CFK Connector custom resource (spec.class, spec.taskMax, spec.configs)
- **strimzi**: a Strimzi KafkaConnector custom resource
- **terraform**: a confluent_connector resource (config_nonsensitive + config_sensitive)
- **properties**: a connect-standalone .properties file

The default, `--to` heredoc, is ready to paste in an example or a  
reproduction model. For heredoc and json, the config is adapted to the  
playground like `playground connector create-or-update` does  
(`--no-adapt` to keep it as is). Masked secrets, config providers  
(${file:...}) and terraform references are listed; in a heredoc they  
become variables to export.

The converted config is printed on stdout, the findings on stderr: the  
output can be redirected to a file.

🎓 Tip: answer a customer in their own format, `--to` cfk or `--to`  
terraform, or compare their config with the running one with  
`playground connector diff --connector <c> --file <their file>` (any  
of these formats).

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-connector-create-or-update

## Usage

```bash
playground connector convert [FILE] [OPTIONS]
```

## Arguments

#### `FILE`

path of the file with the config (@file works too); reads from stdin if empty

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `-`

## Options

#### `--verbose, -v`

🐞 Show command being ran.

#### `--connector, -c CONNECTOR`

🔗 Connector to pick when the file holds several (a dump of GET /connectors?expand=info, several custom resources or terraform resources)

#### `--to, -t FORMAT`

🎯 Output format (default: heredoc)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `heredoc`
| Allowed Values: | `heredoc`, `json`, `cfk`, `strimzi`, `terraform`, `properties`

#### `--from FORMAT`

🔍 Input format (default: auto, detected from the content)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `auto`
| Allowed Values: | `auto`, `json`, `heredoc`, `cfk`, `strimzi`, `terraform`, `properties`

#### `--name, -n NAME`

🏷️ Name of the connector in the output (default: the name in the config)

#### `--no-adapt`

🧷 With `--to` heredoc or json, keep the config as it is (no rewrite of the bootstrap servers, schema registry, license, replication factors, client security)

#### `--secrets-as-variables`

🔐 Also turn the secret values written as they are (passwords, keys, tokens, JAAS configs) into variables to export, like the masked ones

For `--to` heredoc (and the values to fill in of `--json`): the heredoc can then go in a script that is committed,  
like a reproduction model (`playground repro bootstrap --config` uses it).

#### `--json`

🤖 Print the detected format, the name, the config and the values to fill in as JSON

## Examples

```bash
playground connector convert customer-connector.yaml
```

```bash
playground connector convert customer-connector.yaml --secrets-as-variables
```

```bash
playground connector convert connectors.json --connector s3-sink --to json
```

```bash
playground connector convert connector.properties --to cfk
```

```bash
playground connector convert main.tf --to heredoc --no-adapt
```


