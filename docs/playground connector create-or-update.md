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

#### *--offsets OFFSETS*

📍 Create connector with offsets (https://docs.confluent.io/cloud/current/connectors/offsets.html#create-connectors-with-offsets)  
  
⚠️ Only available for ccloud connectors, the connector should not really exists

#### *--initial-state INITIAL-STATE*

🪵 Create connector with specific status (https://cwiki.apache.org/confluence/display/KAFKA/KIP-980%3A+Allow+creating+connectors+in+a+stopped+state)  
  
Only available if CP \> 7.7  
  
⚠️ not available for ccloud connectors

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | RUNNING, PAUSED, STOPPED

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

playground connector create-or-update -c filestream-sink --offsets '[{"partition":{"kafka_topic":"filestream","kafka_partition":0},"offset":{"kafka_offset":8}}]' << EOF
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


