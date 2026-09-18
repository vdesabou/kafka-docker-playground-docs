# playground tcp-proxy break

💔 Break sending the response to the client.  
  
Drops the response part way through, for the given percentage of  
responses. Unlike close-connection, which kills the connection once,  
this keeps failing intermittently, which is what you need to reproduce  
the flaky network a customer is seeing rather than a clean outage.  
  
Set it back to 0 to stop breaking responses.  
  
The new state is printed afterwards, so you can check it was applied.

## Usage

```bash
playground tcp-proxy break [OPTIONS]
```

## Options

#### *--break-service-response BREAK-SERVICE-RESPONSE*

💔 Percentage of broken connections.

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--connection-id CONNECTION-ID*

🧲 Zazkia TCP connection id  
      


