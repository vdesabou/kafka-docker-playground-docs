# playground tcp-proxy close-connection

❌ Close the Zazkia active TCP connections  
  
Kills the connection abruptly, the way a firewall or a restarted  
database would. Use it to check that the connector reconnects on its  
own, and how long it takes.  
  
Without --connection-id, every active connection is closed.

## Usage

```bash
playground tcp-proxy close-connection [OPTIONS]
```

## Options

#### *--connection-id CONNECTION-ID*

🧲 Zazkia TCP connection id  
      


