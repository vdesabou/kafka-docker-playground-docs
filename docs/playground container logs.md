# playground container logs

🕵️  Tail and follow container logs

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

## Examples

```bash
playground container logs --container connect
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


