# playground connector create-or-update

🧑‍🎨  Create or update connector

The command every example uses to deploy its connector. The json config  
is read from stdin, usually as a heredoc, so it stays readable in the  
script. If the connector already exists it is updated in place, which  
makes the command safe to re-run while you iterate on a configuration.

The command then waits for the connector and all its tasks to be  
RUNNING, displays the connector status, and fails with the error if  
they are not, so a broken config stops the example immediately instead  
of failing silently later. A FAILED connector or task is reported with  
`playground connector diagnose` (trace, error digest, offsets, next  
steps and HTML report, opened in the browser unless 'playground config  
open-diagnose-report-on-failure false'). When the script that runs is a reproduction  
model, a connector that is not RUNNING is only reported as a warning,  
since a reproduction model often creates a failing connector on  
purpose. Use `--wait` to fail there too, `--no-wait` to skip the wait.

Fully managed connectors are only waited for with `--wait`.

🎓 Tip: add `--validate` to have the config checked by the plugin before  
it is deployed, which reports every invalid property at once.

An update shows the keys added, removed and changed compared to the  
running config (secrets masked). The config can also be given in the  
REST API format ({"name": ..., "config": {...}}, as returned by  
GET /connectors/`<name>`), or as the path of a json file.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-connector-create-or-update  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%94%8C-the-sink-fails-right-after-it-is-deployed  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%8F%97%EF%B8%8F-deploy-a-fully-managed-connector-with-terraform

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

json, or the path of a json file (@file.json works too); reads from stdin if empty

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

Package name (with `--level`: the log level of that package instead of the connector's)

#### `--wait-for-zero-lag`

😴 Wait until lag becomes 0

#### `--wait`

⏳ Wait until the connector and all its tasks are RUNNING (or in `--initial-state`), and fail otherwise

Self-managed connectors are waited for by default: `--wait` also makes the command fail when the script that runs is a reproduction model (by default, it is only a warning there).

Same as running `playground connector wait` right after the command. It fails right away if the connector or one of its tasks is FAILED. An update of a PAUSED or STOPPED connector waits for that state.

With fully managed connectors, it waits for the connector to be provisioned and restarts it if it fails while being provisioned (same as wait_for_ccloud_connector_up in example scripts).

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--no-wait`

#### `--no-wait`

🏃 Do not wait for the connector and its tasks to be RUNNING, only display the status

🎓 Tip: use it to create a connector that is expected to fail, then check it with `playground connector wait --state FAILED`

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--wait`, `--max-wait`

#### `--max-wait MAX_WAIT`

⏳ Max time in seconds to wait for the connector (default is 120, or 600 for fully managed connectors with `--wait`)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--no-wait`

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

If the connector already exists, its config is updated, then it is paused, stopped or resumed.

Only available if CP \> 7.7

⚠️ not available for ccloud connectors

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `RUNNING`, `PAUSED`, `STOPPED`

#### `--dry-run`

🌵 Print the final config (with the automatic configuration added for the environment, the CFK rewrites)  
and the request that would be sent, without deploying anything

With `--ccloud-service-account`, the service account and its ACLs are not created.

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--wait`, `--wait-for-zero-lag`, `--terraform`, `--level`

#### `--terraform`

🏗️ Deploy connector using Terraform instead of REST API

Dynamically converts JSON connector config to Terraform HCL and deploys using terraform apply

The values of config_sensitive are masked in the output. The Terraform folder of a connector  
(.terraform-playground/`<connector>`-\*) is reused: running the command again updates the connector, and a  
connector created with the REST API is imported first. playground connector delete runs terraform destroy.

⚠️ Only available for Confluent Cloud connectors

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


