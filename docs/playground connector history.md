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

📜 `--with-logs` merges into the same time-ordered list, with the time  
since the previous event (Δ):

- **📋 topics**: the events above (states, configs)
- **📜 logs**: the incident timeline of `playground analyze logs --from-containers`: the errors, known causes, restarts and config changes of this connector, and the events of the workers, brokers and controllers without connector (rebalances, members removed by the coordinator, controller changes, ISR shrinks, long GC pauses, processes started or stopped)
- **🛠️ playground**: the playground commands that changed the environment since it started (containers killed or restarted, faults injected with debug, connector updates, offsets changed, records produced...), from playground-session.log (`playground history --session`); the ones aimed at another connector are left out

It answers "what happened first?": the cut of block-traffic, then the  
rebalance in the broker log, then the task FAILED in connect-status.  
The container logs are saved and analyzed first (about 10 seconds;  
the folder is kept, see `playground analyze logs --from-containers`).  
With `--json`, each connector gets a "timeline" list (ts, time, source,  
what, text, details, delta_ms) next to its events and summary.

⚠️ These topics are compacted: on a long-running cluster, old states  
are gone, only the last one of each connector and task is kept for  
sure. Self-managed connectors only (the topic names are read from the  
worker properties, `--config-topic` and `--status-topic` to override them).

☁️ Fully managed: not supported

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

#### `--with-logs`

📜 Also show the incident timeline of the container logs and the playground actions of the session, merged with the events of the topics

#### `--json`

🤖 Print the result as JSON on stdout, and nothing else (the log lines go to stderr)

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

```bash
playground connector history --connector http-sink --with-logs --since 30m
```

## Example output

```text
$ playground connector history --connector http-source --with-logs
14:51:19 ℹ️ 🕰️ Reading the internal topics connect-configs and connect-status
14:51:27 ℹ️ 📜 Analyzing the logs of the containers (playground analyze logs --from-containers)
14:51:34 ℹ️ 🕰️ History of 🌎onprem connector http-source
   19 event(s): 📋 5 from the internal topics, 📜 11 from the logs, 🛠️  3 playground action(s)
2026-11-26 12:30:29 UTC          📜 broker 1    ⚙️ broker config changed live, no restart on 2 files: min.insync.replicas → 1 · 🧬 min.insync.replicas changed
2026-11-26 12:30:29 UTC     +0s  📜 controller  👑 a new active controller (epoch 1)
2026-11-26 12:30:39 UTC     +8s  📜 connect     🔄 Connect worker started (DistributedConfig logged)
2026-11-26 12:30:39 UTC     +0s  📜 connect     🔄 rebalance of the worker group connect-cluster
2026-11-26 12:31:21 UTC    +42s  📋 config      🆕 created (HttpSourceConnector, tasks.max=1)
2026-11-26 12:31:21 UTC     +0s  📜 connect     🔌 connector http-source (re)configured
2026-11-26 12:31:24 UTC     +3s  📋 connector   🟢 RUNNING on connect:8083 (generation 2)
2026-11-26 12:31:24 UTC     +0s  📋 tasks       🧵 1 task config(s) committed
2026-11-26 12:31:24 UTC     +0s  📋 task 0      🟢 RUNNING on connect:8083 (generation 3)
2026-11-26 12:31:24 UTC     +0s  📜 connect     🔄 rebalance of the worker group connect-cluster
2026-11-26 12:31:29 UTC     +5s  📋 topic       📚 first use of topic http-topic-spaces (task 0)
2026-11-26 13:51:03 UTC  +79min  🛠️  playground  playground container pause --container pg-session-log-test-nonexistent ❌ exit code 1
2026-11-26 13:51:04 UTC     +1s  🛠️  playground  playground container resume --container pg-session-log-test-nonexistent ❌ exit code 1
🧾 0 failure(s), 0 recovery(ies) after a failure, 0 config change(s)
   connector: RUNNING on connect:8083 for 80min
   task 0: RUNNING on connect:8083 for 80min
```


