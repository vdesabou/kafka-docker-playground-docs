# playground debug thread-dump

🎯 Take a java thread dump  
  
🔖 It will save output to a file and open with text editor set with playground config editor \<editor\> (default is code)

## Usage

```bash
playground debug thread-dump [OPTIONS]
```

## Options

#### *--container, -c, --pod, -p CONTAINER*

🐳 container name (or pod name when cfk environment is used)  
  
🎓 Tip: you can pass multiple containers by specifying --container multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | connect

## Examples

```bash
playground debug thread-dump
```

```bash
playground debug thread-dump --container broker
```

```bash
playground debug thread-dump -c connect -c broker
```

```bash
playground debug thread-dump --container schema-registry --container ksqldb-server
```


