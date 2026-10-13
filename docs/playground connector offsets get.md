# playground connector offsets get

🏹 Get current offsets for source and sink connectors  
  
Prints the offsets json returned by the Connect REST API, or the  
Confluent Cloud offsets API for a fully managed connector. For a sink  
on CP older than 7.5, it falls back to kafka-consumer-groups  
--describe on the connect-\<connector\> consumer group.  
  
Run it before and after alter or reset to check what really moved.  
  
See https://docs.confluent.io/cloud/current/connectors/offsets.html  


## Usage

```bash
playground connector offsets get [OPTIONS]
```

## Options

#### *--verbose, -v*

🐞 Show command being ran.

#### *--connector, -c CONNECTOR*

🔗 Connector name  
  
🎓 Tip: If not specified, the command will apply to all connectors


