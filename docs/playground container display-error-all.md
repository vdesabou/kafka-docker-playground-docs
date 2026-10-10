# playground container display-error-all

🔥 Display all ERROR/FATAL logs in all containers/pods. Useful for quick troubleshooting  
  
The first command to run when an example misbehaves and you do not yet  
know which component is at fault. It sweeps every container at once,  
so you do not have to guess where to look.  
  
Each container gets the same digest as 'playground container logs  
--errors': repeated records are de-duplicated with an occurrence count  
and stack traces are collapsed to their "Caused by:" chain. The last  
lines of connect are also shown raw, for failures that log no error.

## Usage

```bash
playground container display-error-all [OPTIONS]
```

## Options

#### *--since SINCE*

🕐 Only scan logs newer than a relative duration (10m, 1h) or a timestamp (2026-09-24T16:00:00)

#### *--include-warnings*

🟠 Also report WARN records

#### *--max-findings MAX_FINDINGS*

✂️ Maximum number of distinct records to show per container (default 15)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 15

## Examples

```bash
playground container display-error-all
```

```bash
playground container display-error-all --since 10m --include-warnings
```


