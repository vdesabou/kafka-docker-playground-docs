# playground container restart

🔁 Restart a container  
  
Stops and starts the container, keeping its definition and its data.  
Use 'playground container recreate' instead if you changed the compose  
definition or an environment variable.

## Usage

```bash
playground container restart [OPTIONS]
```

## Options

#### *--container, -c, --pod, -p CONTAINER*

🐳 container name (or pod name when cfk environment is used)  
  
🎓 Tip: you can pass multiple containers by specifying --container multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | connect


