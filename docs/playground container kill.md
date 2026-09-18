# playground container kill

🔫 Kill a container  
  
Stops the container abruptly, without letting it shut down cleanly,  
which is how you simulate a crash. Bring it back with  
'playground container recreate'.

## Usage

```bash
playground container kill [OPTIONS]
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
playground container kill --container connect
```

```bash
playground container kill -c broker
```

```bash
playground container kill -c connect -c broker
```

```bash
playground container kill --container schema-registry --container ksqldb-server --container control-center
```


