# playground connector tasks

🧵 Show the tasks of a connector: state, worker, config and partitions

Answers "why does task 0 get all the tables, partitions or files?" and  
"which worker runs which task after a rebalance?":

- **state and worker**: of each task (/status), with a per-worker summary when there are several connect workers
- **task config**: the keys whose value differs between the tasks, or from the connector config: this is how a connector splits its work (tables of a JDBC source, task.id, files...). `--all-keys` for the whole config of each task
- **partitions**: for a sink, the topic partitions assigned to each task, from its consumer group connect-`<connector>`

🎓 Tip: 'tasks.max' is a maximum, a source connector can create fewer  
tasks (one JDBC task per table at most).

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-connector-troubleshooting

## Usage

```bash
playground connector tasks [OPTIONS]
```

## Options

#### `--verbose, -v`

🐞 Show command being ran.

#### `--connector, -c CONNECTOR`

🔗 Connector name

🎓 Tip: If not specified, the command will apply to all connectors

#### `--all-keys`

📜 Show the whole config of each task, not only the keys that differ

#### `--json`

🤖 Print the result as JSON

## Examples

```bash
playground connector tasks
```

```bash
playground connector tasks --connector jdbc-source --all-keys
```

```bash
playground connector tasks --connector filestream-sink --json
```


