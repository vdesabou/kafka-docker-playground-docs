# playground container set-environment-variables

📦  Set environment variable(s) for a container  
  
🎓 Tip: you can pass multiple environment variables by specifying --env multiple times  
  
Example: --env "KAFKA_OPTS: -verbose:class" --env "CONNECT_LOG4J_LOGGERS: org.apache.zookeeper=ERROR,org.I0Itec.zkclient=ERROR,org.reflections=ERROR,org.apache.kafka.connect.runtime.rest.RestServer=ERROR"

## Usage

```bash
playground container set-environment-variables [OPTIONS]
```

## Options

#### *--container, -c CONTAINER*

🐳 Container name

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | connect

#### *--env ENV*

📦 Environment variables to set  
  
🎓 Tip: you can pass multiple environment variables by specifying --env multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Conflicts With: | *--restore-original-values*

#### *--restore-original-values*

🧽 Restore back original values before any changes was made

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--env*


