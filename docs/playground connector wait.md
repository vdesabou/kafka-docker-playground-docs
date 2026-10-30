# playground connector wait

⏳ Wait for connectors to reach a state

Polls the connector status every `--interval` seconds until the connector  
and all its tasks are in `--state` (RUNNING by default), and fails after  
`--max-wait` seconds, displaying the status with the stack trace.

RUNNING is only reached when the connector and its tasks are still  
RUNNING one `--interval` later, since a task is RUNNING before it  
processes its first record and can fail right after.

When waiting for RUNNING, it fails right away if the connector or one of  
its tasks is FAILED, since a failed task does not recover on its own,  
and runs `playground connector diagnose` on it: status with the trace,  
digest of the connect errors since the wait started, offsets, next  
steps and HTML report, opened in the browser from an interactive  
terminal (`playground config open-diagnose-report-on-failure false` to  
only print its path, `PG_SKIP_AUTO_DIAGNOSE`=1 for the status only).  
A connector RUNNING without any task for 30 seconds (Replicator without  
matching topic yet, JDBC source without table) is accepted with a  
warning. A Datagen task that failed with "Stopping connector: generated  
the configured N number of messages" ("iterations" reached) is  
completed, not FAILED, and counts as RUNNING.  
For the same reason, `--state` FAILED is reached as soon as the connector  
or one of its tasks is FAILED (the connector itself usually stays  
RUNNING when only a task fails).

🎓 Tip: 'connector create-or-update' already waits for RUNNING. Use  
it for another state, or after 'connector create-or-update `--no-wait`'.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-connector-create-or-update  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%94%8C-the-sink-fails-right-after-it-is-deployed

## Usage

```bash
playground connector wait [OPTIONS]
```

## Environment Variables

#### `PG_SKIP_AUTO_DIAGNOSE`

🩺 Set to 1 to display only the status of a FAILED connector, instead of running 'connector diagnose' on it (also for create-or-update)

## Options

#### `--verbose, -v`

🐞 Show command being ran.

#### `--connector, -c CONNECTOR`

🔗 Connector name

🎓 Tip: If not specified, the command will apply to all connectors

#### `--state STATE`

🎯 State to wait for (default is RUNNING)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `RUNNING`
| Allowed Values: | `RUNNING`, `PAUSED`, `STOPPED`, `FAILED`

#### `--max-wait MAX_WAIT`

⏳ Max time in seconds to wait (default is 120)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `120`

#### `--interval INTERVAL`

🔁 Interval in seconds between status checks (default is 5)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `5`

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

## Examples

```bash
playground connector wait --connector filestream-sink
```

```bash
playground connector wait --connector filestream-sink --state PAUSED --max-wait 60
```

## Example output

```text
$ playground connector wait --connector filestream-sink
17:22:05 ℹ️ ⏳ Waiting up to 120 seconds for 🌎onprem connector filestream-sink to be RUNNING
17:22:10 ℹ️ ✅ 🌎onprem connector filestream-sink is RUNNING (1 task(s)) after 5 seconds
```


