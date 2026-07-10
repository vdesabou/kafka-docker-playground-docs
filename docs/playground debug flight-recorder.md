# playground debug flight-recorder

🛩️ Record flight recorder  
  
Read more about it at https://www.baeldung.com/java-flight-recorder-monitoring  
  
Open the jfr file with JDK Mission Control JMC(https://jdk.java.net/jmc/)

## Usage

```bash
playground debug flight-recorder [OPTIONS]
```

## Options

#### *--container, -c, --pod, -p CONTAINER*

🐳 container name (or pod name when cfk environment is used)  
  
🎓 Tip: you can pass multiple containers by specifying --container multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | connect

#### *--action ACTION*

🟢 start or stop

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes
| Allowed Values: | start, stop

## Examples

```bash
playground debug flight-recorder --action start
```

```bash
playground debug flight-recorder --action stop
```


