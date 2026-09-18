# playground tcp-proxy start

💗 Start the TCP proxy and automatically replace connector config with zazkia hostname and port 49998  
  
Starts the proxy in front of --hostname and --port, then rewrites the  
running connector configuration so its traffic goes through it. Nothing  
else to change on your side.

## Usage

```bash
playground tcp-proxy start [OPTIONS]
```

## Options

#### *--hostname HOSTNAME*

Hostname used by the tcp proxy to forward request

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--port PORT*

Port used by the tcp proxy to forward request

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--throttle-service-response THROTTLE-SERVICE-RESPONSE*

🐌 Throttle service response. This is bytes per second.

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 0

#### *--delay-service-response DELAY-SERVICE-RESPONSE*

⏲️ Add milliseconds delay to service response. Default is 0 ms.

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 0

#### *--break-service-response BREAK-SERVICE-RESPONSE*

💔 Percentage of broken connections. Default is 0%.

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 0

#### *--service-response-corrupt*

🦹‍♂️ Corrupt service response with random mangled bytes. By default, there is no corruption.

#### *--skip-automatic-connector-config*

🤖 By default, script will attempt to modify automatically the running connector config to use Zazkia proxy.  
  
This flag allows to skip this automatic configuration (only useful if you want to manually update connector config with zazkia tcp proxy details)

## Examples

```bash
playground tcp-proxy start --hostname mysql --port 3306
```


