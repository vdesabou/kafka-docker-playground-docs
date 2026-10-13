# playground connector diagnose

🩺 Diagnose a connector in one call: status, errors and progress  
  
Chains the commands you would run one after the other when a connector  
misbehaves, and returns:  
  
  🗺️  status       connector and task states, with the trace of a failed task  
  🔥 errors       digest of the connect ERROR/FATAL records (self-managed),  
                  or Confluent Cloud error recommendations (fully managed)  
  🐢 progress     consumer lag of a sink, or offsets of a source  
  👉 next steps   the commands to dig further  
  
It never follows logs and never waits for the lag to reach 0, so it is  
safe to use from scripts and AI agents.

## Usage

```bash
playground connector diagnose [OPTIONS]
```

## Options

#### *--verbose, -v*

🐞 Show command being ran.

#### *--connector, -c CONNECTOR*

🔗 Connector name  
  
🎓 Tip: If not specified, the command will apply to all connectors

#### *--since SINCE*

🕐 Only look at connect logs newer than this (default 1h). Docker durations: 10m, 2h... (self-managed only)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 1h

#### *--max-findings MAX_FINDINGS*

✂️ Maximum number of distinct error records to show (default 15)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 15

## Examples

```bash
playground connector diagnose
```

```bash
playground connector diagnose --connector http-sink
```

```bash
playground connector diagnose --connector http-sink --since 10m --max-findings 5
```


