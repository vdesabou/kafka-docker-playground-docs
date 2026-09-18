# playground tcp-proxy toggle-reads-service

✅ Change whether reading data from the service is enabled.  
  
Stops the proxy from reading what the service replies. Nothing comes  
back to the client, so requests hang until they time out, without the  
connection ever being closed. This is the classic black hole that a  
TCP keepalive misconfiguration produces.  
  
This is a toggle, run it again to restore the flow.  
  
  See diagram in https://github.com/emicklei/zazkia#how-does-it-work- (or locally http://localhost:9191/help.html)

## Usage

```bash
playground tcp-proxy toggle-reads-service [OPTIONS]
```

## Options

#### *--connection-id CONNECTION-ID*

🧲 Zazkia TCP connection id  
      


