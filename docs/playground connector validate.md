# playground connector validate

✅ Validate a connector config without creating the connector

Sends the config to the validate endpoint of the plugin  
(PUT /connector-plugins/`<class>`/config/validate) and prints every  
invalid property with its error message. Nothing is created or  
changed, so it is the dry run of 'create-or-update' for a customer  
config. Exits with 1 if the config is invalid.

The config is read from stdin: json, or a format customers send (CFK /  
Strimzi custom resource, terraform, .properties, a dump of GET  
/connectors?expand=info with `--connector` to pick one, see 'playground  
connector convert'). Without stdin, `--connector` validates the config  
of that running connector, for example after switching to another  
connector version.

The same automatic config as 'create-or-update' is added for the  
environment of the example (security settings on sasl-ssl...),  
unless `--skip-automatic-connector-config` is set.

🎓 Tip: works for fully managed connectors too, with the validate  
endpoint of Confluent Cloud.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-connector-create-or-update  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%94%8C-the-sink-fails-right-after-it-is-deployed

## Usage

```bash
playground connector validate [JSON] [OPTIONS]
```

## Arguments

#### `JSON`

json (reads from stdin if empty)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `-`

## Options

#### `--verbose, -v`

🐞 Show command being ran.

#### `--connector, -c CONNECTOR`

🔗 Connector name

Name given to the validate endpoint with a config on stdin. Without  
stdin, the running connector whose config is validated.

#### `--skip-automatic-connector-config`

🤖 Do not add the automatic configuration of the environment (security settings on sasl-ssl...) before validating

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

## Examples

```bash
playground connector validate << EOF
{
  "connector.class": "FileStreamSink",
  "topics": "filestream",
  "file": "/tmp/output.json",
  "tasks.max": "abc"
}
EOF
```

```bash
playground connector validate --connector filestream-sink
```

## Example output

```text
$ playground connector validate (tasks.max is abc)
17:22:05 ℹ️ 🔎 Validating 🌎onprem connector config (nothing is created)
17:22:05 ❗ ❌ Validation errors found in connector config
tasks.max ->> Invalid value abc for configuration tasks.max: Not a number of type INT
```


