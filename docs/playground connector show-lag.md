# playground connector show-lag

🐢 Show lag of sink connector

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

#### *--wait-for-zero-lag*

😴 Wait until lag becomes 0

#### *--wait-for-zero-lag-interval WAITFORZEROLAGINTERVAL*

Interval between lag checks when --wait-for-zero-lag is used (default is 10 seconds).

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 10


