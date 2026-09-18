# playground connector stop

🛑 Stop connector (only available if CP \> 7.5)  
  
Stronger than pause: the tasks are shut down and unassigned, so the  
connector consumes no resources at all. This is the state in which  
offsets can be altered or reset.

## Usage

```bash
playground connector stop [OPTIONS]
```

## Options

#### *--verbose, -v*

🐞 Show command being ran.

#### *--connector, -c CONNECTOR*

🔗 Connector name  
  
🎓 Tip: If not specified, the command will apply to all connectors


