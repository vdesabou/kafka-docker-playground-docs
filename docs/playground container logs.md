# playground container logs

🕵️  Tail and follow container logs

## Usage

```bash
playground container logs [OPTIONS]
```

## Options

#### *--container, -c CONTAINER*

🐳 Container name  
  
🎓 Tip: you can pass multiple containers by specifying --container multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | connect

#### *--open, -o*

🔖 Save output to a file and open with text editor set with playground config editor \<editor\> (default is code)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--wait-for-log*

#### *--wait-for-log, -w LOG*

😴 Wait until log appears

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--open*

#### *--max-wait, -m MAX_WAIT*

⏳ Max time in seconds to wait when using --wait-for-log (default 600s)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 600
| Conflicts With: | *--open*

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


