# playground tools http-server

🌐 Drive the http test server of the http examples

The httpserver container (connect/connect-http-sink/httpserver, port 9006)  
used by the http sink, http v2 sink / source, custom SMT and fully managed  
http examples answers every request with a configurable status code,  
delay and body, and records the requests it receives:

- **set-response**: status code, body, delay, or close the connections
- **reset**: back to 200, no delay, {} (and forget the requests)
- **requests**: what the connector sent: method, url, headers, body, status sent back; or wait for N requests

🎓 Tip: to reproduce a retry or a DLQ case, set-response `--status-code` 500,  
produce, check the requests the connector retried, then reset.

## Usage

```bash
playground tools http-server COMMAND
```

## Commands

- [set-response](playground%20tools%20http-server%20set-response) - 🎛️ Set how the http test server answers
- [reset](playground%20tools%20http-server%20reset) - 🔄 Reset the http test server
- [requests](playground%20tools%20http-server%20requests) - 📥 Show the requests received by the http test server


