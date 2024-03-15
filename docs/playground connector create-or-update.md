# playground connector create-or-update

🧑‍🎨  Create or update connector

## Usage

```bash
playground connector create-or-update [JSON] [OPTIONS]
```

## Arguments

#### *JSON*

json (reads from stdin if empty)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | -

## Options

#### *--verbose, -v*

🐞 Show command being ran.

#### *--connector, -c CONNECTOR*

🔗 Connector name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--level, -l LEVEL*

❕Log level  
  
⚠️ Not available for ccloud connectors

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | INFO, WARN, DEBUG, TRACE

#### *--package, -p PACKAGE*

Package name

#### *--wait-for-zero-lag*

😴 Wait until lag becomes 0

#### *--validate*

✅ Validate config using PUT /connector-plugins/(string:name)/config/validate (https://docs.confluent.io/platform/current/connect/references/restapi.html#put--connector-plugins-(string-name)-config-validate)

#### *--skip-automatic-connector-config*

🤖 If example is run (playground run) with --environment flag, automatic configuration to adapt to the environment is added.   
  
This flag allows to skip this automatic configuration (only useful to reproduce issues)

## Examples

```bash
playground connector create-or-update -c filestream-sink << EOF
{
    "tasks.max": "1",
    "connector.class": "org.apache.kafka.connect.file.FileStreamSinkConnector",
    "topics": "filestream",
    "file": "/tmp/output.json",
    "key.converter": "org.apache.kafka.connect.storage.StringConverter",
    "value.converter": "org.apache.kafka.connect.json.JsonConverter",
    "value.converter.schemas.enable": "false"
}
EOF

```


