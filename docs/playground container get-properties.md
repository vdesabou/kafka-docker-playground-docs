# playground container get-properties

📝 Get properties file from a container  
  
👉 Check documentation https://kafka-docker-playground.io/#/how-to-use?id=%f0%9f%93%9d-see-properties-file

## Usage

```bash
playground container get-properties [OPTIONS]
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
playground get-properties
```

```bash
playground get-properties --container broker
```

```bash
playground get-properties -c broker
```


