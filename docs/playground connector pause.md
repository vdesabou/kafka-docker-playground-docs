# playground connector pause

⏸️  Pause connector  
  
Tasks stop processing but stay assigned, and the configuration is kept.  
Handy to let a backlog build up, or to freeze a connector while you  
change the system it talks to. Resume with 'playground connector resume'.

## Usage

```bash
playground connector pause [OPTIONS]
```

## Options

#### *--verbose, -v*

🐞 Show command being ran.

#### *--connector, -c CONNECTOR*

🔗 Connector name  
  
🎓 Tip: If not specified, the command will apply to all connectors


