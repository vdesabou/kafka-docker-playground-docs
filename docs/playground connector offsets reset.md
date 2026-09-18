# playground connector offsets reset

🆕 Reset offsets for source and sink connectors  
  
Wipes the recorded offsets so the connector starts over: a source  
re-reads its origin from the beginning, a sink re-consumes its topics  
from the earliest offset. The connector is stopped and resumed around  
the reset.  
  
⚠️ Everything is reprocessed, so expect duplicates downstream unless  
the target is idempotent. Use alter when you only want to move back  
to a specific point.  
  
See https://docs.confluent.io/cloud/current/connectors/offsets.html  


## Usage

```bash
playground connector offsets reset [OPTIONS]
```

## Options

#### *--verbose, -v*

🐞 Show command being ran.

#### *--connector, -c CONNECTOR*

🔗 Connector name  
  
🎓 Tip: If not specified, the command will apply to all connectors


