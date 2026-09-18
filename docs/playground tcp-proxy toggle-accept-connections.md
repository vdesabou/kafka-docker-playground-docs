# playground tcp-proxy toggle-accept-connections

🙅‍♂️ Change whether new connections can be accepted  
  
Turn it off and the service looks down to anything trying to connect,  
while the connections already open keep working. That is the way to  
reproduce a connector that cannot reconnect after a failure, or an  
exhausted connection pool.  
  
This is a toggle, run it again to accept connections once more.

## Usage

```bash
playground tcp-proxy toggle-accept-connections
```


