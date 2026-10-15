# playground connector wait

⏳ Wait for connectors to reach a state

Polls the connector status every `--interval` seconds until the connector  
and all its tasks are in `--state` (RUNNING by default), and fails after  
`--max-wait` seconds, displaying the status with the stack trace.

RUNNING is only reached when the connector and its tasks are still  
RUNNING one `--interval` later, since a task is RUNNING before it  
processes its first record and can fail right after.

When waiting for RUNNING, it fails right away if the connector or one of  
its tasks is FAILED, since a failed task does not recover on its own.  
For the same reason, `--state` FAILED is reached as soon as the connector  
or one of its tasks is FAILED (the connector itself usually stays  
RUNNING when only a task fails).

🎓 Tip: in an example script, use it right after 'connector  
create-or-update' instead of a fixed sleep.

## Usage

```bash
playground connector wait [OPTIONS]
```

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


