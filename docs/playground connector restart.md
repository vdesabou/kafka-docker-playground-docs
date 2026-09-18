# playground connector restart

♻️  Restart connector  
  
The usual way to recover a connector whose tasks are FAILED after you  
fixed the cause. Use --task-id to restart a single failed task and leave  
the healthy ones alone.

## Usage

```bash
playground connector restart [OPTIONS]
```

## Options

#### *--verbose, -v*

🐞 Show command being ran.

#### *--connector, -c CONNECTOR*

🔗 Connector name  
  
🎓 Tip: If not specified, the command will apply to all connectors

#### *--task-id, -t TASK_ID*

🔧 Restart specific task ID only (instead of restarting entire connector)


