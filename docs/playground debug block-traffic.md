# playground debug block-traffic

🚫 Blocking traffic using iptables

## Usage

```bash
playground debug block-traffic [OPTIONS]
```

## Options

#### *--container, -c CONTAINER*

🐳 Container name

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | connect

#### *--destination DESTINATION*

Destination: it could be an ip address, a container name or a hostname

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--port PORT*

Port on which tcp traffic should be blocked

#### *--action ACTION*

🟢 start or stop

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes
| Allowed Values: | start, stop

## Examples

```bash
playground debug block-traffic --destination google.com --action start
```

```bash
playground debug block-traffic --container broker --destination zookeeper --action start
```


