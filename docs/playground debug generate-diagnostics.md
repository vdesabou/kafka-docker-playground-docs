# playground debug generate-diagnostics

⛑️ Generate a diagnostic bundle with Diagnostics Bundle Tool  
  
⚠️ only connect and broker containers are supported for now  
  
see https://docs.confluent.io/platform/current/tools/diagnostics-tool.html#collect-diagnostics

## Usage

```bash
playground debug generate-diagnostics [OPTIONS]
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
playground debug generate-diagnostics
```

```bash
playground debug generate-diagnostics --container broker
```


