# playground connector log-level

🧬 Set connect log level  
  
🎓 Tip: it will also set io.confluent.kafka.schemaregistry.client.rest.RestService (to see schema registry rest requests) and org.apache.kafka.connect.runtime.TransformationChain (to see records before and after SMTs)

## Usage

```bash
playground connector log-level [OPTIONS]
```

## Options

#### *--connector, -c CONNECTOR*

🔗 Connector name  
  
🎓 Tip: If not specified, the command will apply to all connectors

#### *--level, -l LEVEL*

❕Log level

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes
| Allowed Values: | INFO, WARN, DEBUG, TRACE


