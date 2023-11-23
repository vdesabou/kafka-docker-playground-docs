# playground ccloud-connector create-or-update

🧑‍🎨  Create or update connector

## Usage

```bash
playground ccloud-connector create-or-update [JSON] [OPTIONS]
```

## Examples

```bash
playground ccloud-connector create-or-update --connector HttpSink << EOF
{
    "connector.class": "HttpSink",
    "name": "HttpSink",
    "kafka.auth.mode": "KAFKA_API_KEY",
    "kafka.api.key": "$CLOUD_KEY",
    "kafka.api.secret": "$CLOUD_SECRET",
    "topics": "http-topic",
    "input.data.format": "AVRO",
    "http.api.url": "http://httpstat.us/200/",
    "behavior.on.error": "fail",
    "tasks.max" : "1"
}
EOF

```

## Arguments

#### *JSON*

json (reads from stdin if empty)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | -

## Options

#### *--connector, -c CONNECTOR*

🔗 Connector name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--validate*

✅ Validate config using PUT https://api.confluent.cloud/connect/v1/environments/{environment_id}/clusters/{kafka_cluster_id}/connector-plugins/{plugin_name}/config/validate (https://docs.confluent.io/cloud/current/api.html#tag/Managed-Connector-Plugins-(connectv1)/operation/validateConnectv1ConnectorPlugin)


