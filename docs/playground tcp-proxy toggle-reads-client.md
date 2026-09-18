# playground tcp-proxy toggle-reads-client

✅ Change whether reading data from the client is enabled.  
  
Stops the proxy from reading what the client sends. The client's writes  
pile up in its socket buffer and it eventually blocks, which is how you  
reproduce backpressure and produce timeouts.  
  
This is a toggle, run it again to restore the flow.  
  
  See diagram in https://github.com/emicklei/zazkia#how-does-it-work- (or locally http://localhost:9191/help.html)

## Usage

```bash
playground tcp-proxy toggle-reads-client [OPTIONS]
```

## Options

#### *--connection-id CONNECTION-ID*

🧲 Zazkia TCP connection id  
      


