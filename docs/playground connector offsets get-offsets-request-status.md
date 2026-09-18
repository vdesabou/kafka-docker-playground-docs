# playground connector offsets get-offsets-request-status

👁️‍🗨️ Get the status of the previous offset request  
  
On Confluent Cloud, alter and reset only queue a request. This shows  
whether it was APPLIED or FAILED, and the error when it failed, which  
is the only place the reason shows up.  
  
Only for fully managed and custom connectors, self managed connectors  
apply the change synchronously.  
  
See https://docs.confluent.io/cloud/current/connectors/offsets.html  


## Usage

```bash
playground connector offsets get-offsets-request-status [OPTIONS]
```

## Options

#### *--verbose, -v*

🐞 Show command being ran.

#### *--connector, -c CONNECTOR*

🔗 Connector name  
  
🎓 Tip: If not specified, the command will apply to all connectors


