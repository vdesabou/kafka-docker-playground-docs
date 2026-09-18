# playground tcp-proxy delay

⏲️ Add milliseconds delay to service response.  
  
Slows down every response coming back from the service, without  
breaking anything. This is how you reproduce a slow database or a slow  
API: request timeouts, retries, rebalances caused by a task that takes  
too long to answer.  
  
Set it back to 0 to remove the delay.  
  
The new state is printed afterwards, so you can check it was applied.

## Usage

```bash
playground tcp-proxy delay [OPTIONS]
```

## Options

#### *--delay-service-response DELAY-SERVICE-RESPONSE*

⏲️ Add milliseconds delay to service response.

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--connection-id CONNECTION-ID*

🧲 Zazkia TCP connection id  
      


