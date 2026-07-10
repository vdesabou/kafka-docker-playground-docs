# playground container update

✍️ Edit and apply runtime container/pod definition  
  
Opens the current docker-compose (non-CFK) or Kubernetes resource YAML (CFK)  
for the target container/pod in your configured editor and applies changes  
when you save and close the file.

## Usage

```bash
playground container update [OPTIONS]
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
playground container update --container connect
```

```bash
playground container update -c splunk
```

```bash
playground container update --container connect --container broker
```


