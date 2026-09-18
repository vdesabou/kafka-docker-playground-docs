# playground tcp-proxy toggle-writes-service

✅ Change whether writing data to the service is enabled.  
  
The proxy keeps reading the client's request but never forwards it to  
the service. The client believes it sent its data, the service never  
receives it, so nothing ever answers.  
  
This is a toggle, run it again to restore the flow.  
  
  See diagram in https://github.com/emicklei/zazkia#how-does-it-work- (or locally http://localhost:9191/help.html)

## Usage

```bash
playground tcp-proxy toggle-writes-service [OPTIONS]
```

## Options

#### *--connection-id CONNECTION-ID*

🧲 Zazkia TCP connection id  
      


