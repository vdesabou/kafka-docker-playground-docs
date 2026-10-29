# playground connector restart

♻️  Restart connector

The usual way to recover a connector whose tasks are FAILED after you  
fixed the cause. Use `--task-id` to restart a single failed task and leave  
the healthy ones alone, or `--only-failed` to restart only what is FAILED,  
in every connector when `--connector` is not set.

## Usage

```bash
playground connector restart [OPTIONS]
```

## Options

#### `--verbose, -v`

🐞 Show command being ran.

#### `--connector, -c CONNECTOR`

🔗 Connector name

🎓 Tip: If not specified, the command will apply to all connectors

#### `--task-id, -t TASK_ID`

🔧 Restart specific task ID only (instead of restarting entire connector)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--only-failed`

#### `--only-failed`

🩹 Restart only the connector instances and tasks that are FAILED, and leave the RUNNING ones alone

A connector with nothing FAILED is skipped. Uses the KIP-745 REST call  
(restart?includeTasks=true&onlyFailed=true, CP 7.0+); with older CP  
versions and fully managed connectors, restarts each FAILED task one by one.

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--task-id`

## Examples

```bash
playground connector restart
```

```bash
playground connector restart --connector filestream-sink --task-id 0
```

```bash
playground connector restart --only-failed
```


