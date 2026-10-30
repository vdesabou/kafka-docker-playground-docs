# playground connector history

🕰️ Show the history of a connector: state changes, failures, restarts and config changes

Answers "when did it fail? how many times was it restarted? on which  
worker? what changed in the config just before?", hours after the  
fact, when `playground connector status` only shows the current state.

Reads the internal topics of the connect cluster, one timeline per  
connector:

- **connect-status**: every state of the connector and of each task (RUNNING, FAILED with the first line of the trace, PAUSED, UNASSIGNED...), the worker and generation, and the first time each topic was used
- **connect-configs**: creation, each config change (keys added, removed, changed), task configs committed, pause / stop / resume, deletion

Ends with a summary: failures per task, restarts, config changes and  
the current state with its age. Secrets in the configs are masked.

🎓 Tip: works for deleted connectors too (`--connector` `<name>`), and  
`--since` 1h keeps the recent events.

⚠️ These topics are compacted: on a long-running cluster, old states  
are gone, only the last one of each connector and task is kept for  
sure. Self-managed connectors only (the topic names are read from the  
worker properties, `--config-topic` and `--status-topic` to override them).

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-connector-troubleshooting

## Usage

```bash
playground connector history [OPTIONS]
```

## Options

#### `--verbose, -v`

🐞 Show command being ran.

#### `--connector, -c CONNECTOR`

🔗 Connector name, running or deleted

🎓 Tip: If not specified, the command will apply to all connectors found in the internal topics

#### `--since SINCE`

⏱️ Only show the events of the last `<since>` (30s, 10m, 2h)

#### `--config-topic CONFIG_TOPIC`

🗂️ Config topic of the connect cluster (default: config.storage.topic of the worker, connect-configs)

#### `--status-topic STATUS_TOPIC`

🗂️ Status topic of the connect cluster (default: status.storage.topic of the worker, connect-status)

#### `--json`

🤖 Print the events and the summary as JSON

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

## Examples

```bash
playground connector history
```

```bash
playground connector history --connector jdbc-sink --since 1h
```

```bash
playground connector history --connector jdbc-sink --json
```


