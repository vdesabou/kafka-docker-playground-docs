# playground connector delete

🗑️  Delete connector  
  
Removes the connector and its configuration. Its offsets survive in the  
Kafka internal topics, so re-creating it under the same name resumes  
where it stopped rather than starting over.

## Usage

```bash
playground connector delete [OPTIONS]
```

## Options

#### *--verbose, -v*

🐞 Show command being ran.

#### *--connector, -c CONNECTOR*

🔗 Connector name  
  
🎓 Tip: If not specified, the command will apply to all connectors


