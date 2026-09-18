# playground tcp-proxy

🏚 Zazkia TCP Proxy commands  
  
Simulate TCP connection issues (reset,delay,throttle,corrupt) using emicklei/zazkia (https://github.com/emicklei/zazkia) TCP proxy  
  
Slips a controllable proxy between a connector and the system it talks to,  
so you can break the connection on purpose and watch what the connector  
does: does it retry, does it lose records, does it fail the task.  
  
  start        put the proxy in the path, rewriting the connector config  
  delay        add latency to the responses  
  break        drop a percentage of the responses  
  close-connection, close-all-connection-with-error  
  toggle-*     cut reads or writes in one direction only  
  get-connections   the live connections and their statistics  
  open-ui      drive all of the above from the Zazkia web UI  
  
🎓 Tip: start with 'playground tcp-proxy open-ui' to see what is  
happening, then reproduce the same actions from the CLI in a script.

## Usage

```bash
playground tcp-proxy COMMAND
```

## == Commands ==

- [start](playground%20tcp-proxy%20start) - 💗 Start the TCP proxy and automatically replace connector config with zazkia hostname and port 49998
- [get-connections](playground%20tcp-proxy%20get-connections) - 🧲 Get Zazkia active TCP connections config and stats
- [delay](playground%20tcp-proxy%20delay) - ⏲️ Add milliseconds delay to service response.
- [break](playground%20tcp-proxy%20break) - 💔 Break sending the response to the client.
- [close-connection](playground%20tcp-proxy%20close-connection) - ❌ Close the Zazkia active TCP connections
- [close-all-connection-with-error](playground%20tcp-proxy%20close-all-connection-with-error) - 🧹 Close all Zazkia TCP connections which are in error state
- [toggle-accept-connections](playground%20tcp-proxy%20toggle-accept-connections) - 🙅‍♂️ Change whether new connections can be accepted
- [toggle-reads-client](playground%20tcp-proxy%20toggle-reads-client) - ✅ Change whether reading data from the client is enabled.
- [toggle-reads-service](playground%20tcp-proxy%20toggle-reads-service) - ✅ Change whether reading data from the service is enabled.
- [toggle-writes-client](playground%20tcp-proxy%20toggle-writes-client) - ✅ Change whether writing data to the client is enabled.
- [toggle-writes-service](playground%20tcp-proxy%20toggle-writes-service) - ✅ Change whether writing data to the service is enabled.
- [open-ui](playground%20tcp-proxy%20open-ui) - 🌐 Just open Zazkia UI (http://localhost:9191) in your browser


