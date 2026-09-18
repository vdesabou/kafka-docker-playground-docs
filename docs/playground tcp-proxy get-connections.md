# playground tcp-proxy get-connections

🧲 Get Zazkia active TCP connections config and stats  
  
Lists every TCP connection currently going through the proxy, with its  
id, its state (the toggles and the delay or break currently applied) and  
its stats (bytes sent and received each way).  
  
Start here: the id printed by this command is what the other tcp-proxy  
commands take as --connection-id. Connections in EOF state are hidden.  
  
🎓 Tip: every other tcp-proxy command applies to all active connections  
when you do not pass --connection-id, which is normally what you want.

## Usage

```bash
playground tcp-proxy get-connections [OPTIONS]
```

## Options

#### *--connection-id CONNECTION-ID*

🧲 Zazkia TCP connection id  
      


