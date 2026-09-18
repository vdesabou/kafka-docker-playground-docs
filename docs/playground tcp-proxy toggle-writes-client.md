# playground tcp-proxy toggle-writes-client

✅ Change whether writing data to the client is enabled.  
  
The proxy keeps reading the service's response but never forwards it to  
the client. Close to toggle-reads-service from the client's point of  
view, except the service sees its response as fully sent, so both sides  
disagree about what happened.  
  
This is a toggle, run it again to restore the flow.  
  
  See diagram in https://github.com/emicklei/zazkia#how-does-it-work- (or locally http://localhost:9191/help.html)

## Usage

```bash
playground tcp-proxy toggle-writes-client [OPTIONS]
```

## Options

#### *--connection-id CONNECTION-ID*

🧲 Zazkia TCP connection id  
      


