# playground tcp-proxy start

💗 Start the TCP proxy

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

💔 Percentage of broken connections. Default is none.

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 0

#### *--service-response-corrupt*

🦹‍♂️ Corrupt service response with random mangled bytes. By default, there is no corruption.

## Examples

```bash
playground tcp-proxy start --hostname mysql --port 3306
```


