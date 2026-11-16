# playground ansible add-host

🖥️ Add hosts to the running cluster

Starts the containers of the hosts (empty hosts: systemd and a JDK) and  
adds them to their group of the inventory, with the JMX port they have in  
the other environments. Then deploy them with 'playground ansible  
playbook `--limit` `<hosts>`': the running hosts are not touched.

Hosts: broker2, broker3, controller2, controller3 (dynamic KRaft quorum  
only), connect2, connect3, ksqldb-server, rest-proxy, control-center.

## Usage

```bash
playground ansible add-host HOST...
```

## Arguments

#### `HOST`

🖥️ Host to add

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes
| Repeatable:     |  ✓ Yes
| Allowed Values: | `broker2`, `broker3`, `controller2`, `controller3`, `connect2`, `connect3`, `ksqldb-server`, `rest-proxy`, `control-center`, `zookeeper2`, `zookeeper3`

## Examples

```bash
playground ansible add-host broker2 broker3
```

```bash
playground ansible add-host ksqldb-server
```


