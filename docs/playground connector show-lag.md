# playground connector show-lag

🐢 Show lag of sink connector  
  
The consumer lag of the sink, refreshed every --interval seconds, so you  
see whether it is catching up, standing still or falling behind. A lag  
that does not move while the connector reports RUNNING means the tasks  
are stuck rather than slow.  
  
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

#### *--max-wait MAX_WAIT*

⏳ Max time in seconds to wait for lag to become 0. If set to 0 (default), it will run until all lag becomes 0.

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 0


