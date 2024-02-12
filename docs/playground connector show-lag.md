# playground connector show-lag

🐢 Show lag of sink connector  
  
It will run until all lag becomes 0 (press ctrl-c to exit)  


## Usage

```bash
playground connector show-lag [OPTIONS]
```

## Options

#### *--verbose, -v*

🐞 Show command being ran.

#### *--connector, -c CONNECTOR*

🔗 Connector name  
  
🎓 Tip: If not specified, the command will apply to all connectors

#### *--interval INTERVAL*

Interval between lag checks (default is 20 seconds).

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 20


