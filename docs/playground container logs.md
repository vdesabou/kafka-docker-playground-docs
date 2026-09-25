# playground container logs

🕵️  Tail and follow container logs  
  
Three ways to use it:  
  
  --grep "ERROR"                    keep only the lines that matter  
  --open                            read the whole log in your editor  
  --wait-for-log "Started" -m 120   block until the line shows up  
  
The last one is what example scripts use to synchronise on a component  
being ready, instead of sleeping and hoping.

## Usage

```bash
playground container logs [OPTIONS]
```

## Options

#### *--container, -c, --pod, -p CONTAINER*

🐳 container name (or pod name when cfk environment is used)  
  
🎓 Tip: you can pass multiple containers by specifying --container multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | connect

#### *--open, -o*

🔖 Save output to a file and open with text editor set with playground config editor \<editor\> (default is code)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--wait-for-log, --grep*

#### *--wait-for-log, -w LOG*

😴 Wait until log appears

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--open, --grep*

#### *--max-wait, -m MAX_WAIT*

⏳ Max time in seconds to wait when using --wait-for-log (default 600s)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 600
| Conflicts With: | *--open, --grep*

#### *--grep GREP*

🎯 Grep pattern to filter logs

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 
| Conflicts With: | *--open, --wait-for-log*

#### *--previous*

🕰️ Show logs from the previous pod instance (only relevant when --environment=cfk is used)

#### *--since SINCE*

🕐 Only show logs newer than a relative duration (10m, 1h) or a timestamp (2026-09-24T16:00:00)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--open, --wait-for-log*

#### *--tail LINES*

🔢 Number of lines to show from the end of the logs, or "all"  
  
Default is 200, or all when --since, --errors, or --grep with --no-follow is used

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--open, --wait-for-log*

#### *--no-follow*

🛑 Print the logs and exit instead of following them  
  
🎓 Tip: use it in scripts and from AI agents, which otherwise never get the command back

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--open, --wait-for-log*

#### *--errors*

🔥 Only show a digest of ERROR/FATAL records, then exit  
  
Repeated records are de-duplicated with an occurrence count, stack  
traces are collapsed to the exception chain ("Caused by:") plus a few  
frames of the deepest cause. Records logged at INFO/DEBUG/TRACE are  
never reported, even when their message contains "Error" or "Exception".  
  
Scans the whole log unless --since or --tail narrow it.

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--open, --wait-for-log, --grep*

#### *--include-warnings*

🟠 With --errors, also report WARN records

#### *--max-findings MAX_FINDINGS*

✂️ With --errors, maximum number of distinct records to show (default 40)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 40

## Examples

```bash
playground container logs --container connect
```

```bash
playground container logs -c connect --errors
```

```bash
playground container logs -c connect --errors --since 10m --include-warnings
```

```bash
playground container logs -c connect --grep "Caused by" --no-follow
```

```bash
playground container logs -c connect --no-follow --tail 500
```

```bash
playground container logs -c connect --open
```

```bash
playground container logs -c connect --wait-for-log "StackOverflowError"
```

```bash
playground container logs -c connect -c broker
```

```bash
playground container logs --container schema-registry --container ksqldb-server --open
```

```bash
playground container logs -c broker -c connect -c schema-registry
```

```bash
playground container logs -c connect -c broker --wait-for-log "ERROR" --max-wait 120
```

```bash
playground container logs --container connect --grep "ERROR"
```

```bash
playground pod logs --previous
```


