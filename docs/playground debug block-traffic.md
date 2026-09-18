# playground debug block-traffic

🚫 Blocking traffic using iptables  
  
Cuts the route from a container to a destination, so you can see how the  
system behaves during a network outage: a broker that loses the  
controller, a connector that can no longer reach its database, a client  
that cannot resolve the schema registry.  
  
Blocking with --action start and restoring with --action stop, so the  
failure is reversible without restarting anything.

## Usage

```bash
playground debug block-traffic [OPTIONS]
```

## Options

#### *--container, -c, --pod, -p CONTAINER*

🐳 container name (or pod name when cfk environment is used)  
  
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


