# playground container pause

⏸️  Pause a container  
  
Freezes the processes without stopping the container: it keeps its  
connections but stops responding. A good way to simulate a hung  
broker, an unresponsive database or a GC pause, and to see how the  
rest of the system reacts.

## Usage

```bash
playground container pause [OPTIONS]
```

## Options

#### *--container, -c, --pod, -p CONTAINER*

🐳 container name (or pod name when cfk environment is used)  
  
🎓 Tip: you can pass multiple containers by specifying --container multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | connect


