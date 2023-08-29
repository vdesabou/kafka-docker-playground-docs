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


