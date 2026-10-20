# playground connector create-or-update

🧑‍🎨  Create or update connector

The command every example uses to deploy its connector. The json config  
is read from stdin, usually as a heredoc, so it stays readable in the  
script. If the connector already exists it is updated in place, which  
makes the command safe to re-run while you iterate on a configuration.

The command then displays the connector status. Add `--wait` to wait for  
the connector and all its tasks to be RUNNING and fail with the error  
if they are not, so a broken config stops the example immediately  
instead of failing silently later.

🎓 Tip: add `--validate` to have the config checked by the plugin before  
it is deployed, which reports every invalid property at once.

## Usage

```bash
playground connector create-or-update [JSON] [OPTIONS]
```

## Environment Variables

#### `PG_CCLOUD_SERVICE_ACCOUNT`

👤 true: create fully managed connectors with a service account and the ACLs of the documentation (set by playground run `--ccloud-service-account`)

#### `PG_CCLOUD_SERVICE_ACCOUNT_ACLS`

🚦 With `PG_CCLOUD_SERVICE_ACCOUNT`, ACLs of the service account: docs (default), full or none

#### `PG_CCLOUD_SERVICE_ACCOUNT_ID`

👤 With `PG_CCLOUD_SERVICE_ACCOUNT`, existing service account to use as is, instead of creating one

#### `PG_CCLOUD_SERVICE_ACCOUNT_ACL_EXCLUDE`

🙈 With `PG_CCLOUD_SERVICE_ACCOUNT`, regex of the ACLs not to create, matched on `<OPERATION>` `<ResourceType>:<name>` [prefix]

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

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--level, -l LEVEL`

❕Log level

⚠️ Not available for ccloud connectors

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `INFO`, `WARN`, `DEBUG`, `TRACE`

#### `--package, -p PACKAGE`

Package name

#### `--wait-for-zero-lag`

😴 Wait until lag becomes 0

#### `--wait`

⏳ Wait until the connector and all its tasks are RUNNING (or in `--initial-state`), and fail otherwise

Same as running `playground connector wait` right after the command. It fails right away if the connector or one of its tasks is FAILED.

With fully managed connectors, it waits for the connector to be provisioned and restarts it if it fails while being provisioned (same as wait_for_ccloud_connector_up in example scripts).

#### `--max-wait MAX_WAIT`

⏳ Max time in seconds to wait with `--wait` (default is 120, or 600 for fully managed connectors)

#### `--validate`

✅ Validate config using PUT /connector-plugins/(string:name)/config/validate (https://docs.confluent.io/platform/current/connect/references/restapi.html#put--connector-plugins-(string-name)-config-validate)

#### `--skip-automatic-connector-config`

🤖 If example is run (playground run) with `--environment` flag, automatic configuration to adapt to the environment is added.

This flag allows to skip this automatic configuration (only useful to reproduce issues)

#### `--offsets OFFSETS`

📍 Create connector with offsets (https://docs.confluent.io/cloud/current/connectors/offsets.html#create-connectors-with-offsets)

⚠️ Only available for ccloud connectors, the connector should not really exists

#### `--initial-state INITIAL-STATE`

🪵 Create connector with specific status (https://cwiki.apache.org/confluence/display/KAFKA/KIP-980%3A+Allow+creating+connectors+in+a+stopped+state)

Only available if CP \> 7.7

⚠️ not available for ccloud connectors

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `RUNNING`, `PAUSED`, `STOPPED`

#### `--terraform`

🏗️ Deploy connector using Terraform instead of REST API

Dynamically converts JSON connector config to Terraform HCL and deploys using terraform apply

⚠️ Only available for Confluent Cloud connectors

## Examples

```bash
playground connector create-or-update -c filestream-sink --wait << EOF
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


