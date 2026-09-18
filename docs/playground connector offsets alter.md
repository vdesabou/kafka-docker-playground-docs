# playground connector offsets alter

⛏️ Alter offsets for source and sink connectors  
  
Fetches the current offsets, opens them in your editor, and applies  
what you saved once you close the file. That is how you rewind a sink  
to a given offset, or move a source back to an earlier position,  
without replaying everything.  
  
The connector is stopped before the change and resumed after it. On  
Confluent Cloud the change is asynchronous, so the command then polls  
get-offsets-request-status and prints the resulting offsets.  
  
See https://docs.confluent.io/cloud/current/connectors/offsets.html  


## Usage

```bash
playground connector offsets alter [OPTIONS]
```

## Options

#### *--verbose, -v*

🐞 Show command being ran.

#### *--connector, -c CONNECTOR*

🔗 Connector name  
  
🎓 Tip: If not specified, the command will apply to all connectors


