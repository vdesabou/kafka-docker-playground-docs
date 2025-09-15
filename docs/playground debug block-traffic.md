# playground debug block-traffic

🚫 Blocking traffic using iptables

## Usage

```bash
playground debug block-traffic [OPTIONS]
```

## Options

#### *--container, -c CONTAINER*

🐳 Container name  
  
🎓 Tip: you can pass multiple containers by specifying --container multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
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

```bash
playground debug block-traffic -c broker -c connect --destination zookeeper --action start
```

```bash
playground debug block-traffic --container schema-registry --destination broker --port 9092 --action start
```

```bash
playground debug block-traffic -c connect -c ksqldb-server --destination schema-registry --action stop
```


