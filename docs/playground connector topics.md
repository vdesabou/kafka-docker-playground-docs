# playground connector topics

📚 Show the topics a connector is using, or reset that list

The active topics of each connector, as tracked by the worker (KIP-558):  
the topics a source connector has written to, and the topics a sink  
connector has consumed from (useful with topics.regex). The list only  
grows while the connector runs: `--reset` empties it, and it fills again  
with the topics used from then on.

🎓 Tip: feed the result to `playground topic consume --topic <t>` or  
`playground topic dlq inspect`.

⚠️ Self-managed connectors only (CP 5.5+, topic.tracking.enable=true on  
the worker, the default). `--reset` also needs  
topic.tracking.allow.reset=true on the worker (the default).

## Usage

```bash
playground connector topics [OPTIONS]
```

## Options

#### `--verbose, -v`

🐞 Show command being ran.

#### `--connector, -c CONNECTOR`

🔗 Connector name

🎓 Tip: If not specified, the command will apply to all connectors

#### `--reset`

🧹 Empty the list of active topics of the connector (PUT /connectors/`<connector>`/topics/reset)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--json`

#### `--json`

🤖 Print the result as JSON

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--reset`

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

## Examples

```bash
playground connector topics
```

```bash
playground connector topics --connector s3-sink --json
```

```bash
playground connector topics --connector s3-sink --reset
```


