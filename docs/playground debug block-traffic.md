# playground debug block-traffic

🚫 Blocking traffic using iptables

Cuts the route from a container to a destination, so you can see how the  
system behaves during a network outage: a broker that loses the  
controller, a connector that can no longer reach its database, a client  
that cannot resolve the schema registry.

Blocking with `--action` start and restoring with `--action` stop, so the  
failure is reversible without restarting anything.

By default only the packets the container sends to the destination are  
dropped (OUTPUT): a TCP connection dies anyway, since the container can  
neither send nor acknowledge.

- `--both-ways`: also drop what the destination sends to the container (INPUT): a full partition, nothing gets through in either direction (UDP and data already in flight included)
- `--isolate <c>`: cut container c from every other container of its network(s), both ways, without `--destination`: loopback, the docker DNS, the gateway (the host, published ports) and the internet keep working. `--container` is ignored. Docker and podman only
- `--duration <d>`: with `--action` start: the traffic heals by itself after d (30s, 2m, 1h), through a detached timer. `--action` stop with the same flags ends it earlier, `playground stop` ends the timer with the environment

`--action` stop removes the `--both-ways` rules too, without the flag (with  
cfk, pass `--both-ways` to the stop as well).

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-network-traffic  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%90%8C-a-slow-or-broken-network-on-purpose

## Usage

```bash
playground debug block-traffic [OPTIONS]
```

## Options

#### `--container, -c, --pod, -p CONTAINER`

🐳 container name (or pod name when cfk environment is used)

🎓 Tip: you can pass multiple containers by specifying `--container` multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | `connect`

#### `--destination DESTINATION`

Destination: it could be an ip address, a container name or a hostname

ℹ️ Required, unless `--isolate` is set

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--isolate`

#### `--isolate CONTAINER`

🏝️ Cut this container from every other container of its network(s), both ways (loopback, docker DNS, host and internet still work)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--destination`, `--port`, `--both-ways`

#### `--both-ways`

↔️ Also drop the packets the destination sends to the container (a full partition)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--isolate`

#### `--duration DURATION`

⏳ With `--action` start: heal by itself after this time (30s, 2m, 1h)

#### `--port PORT`

Port on which tcp traffic should be blocked

#### `--action ACTION`

🟢 start or stop

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes
| Allowed Values: | `start`, `stop`

## Examples

```bash
playground debug block-traffic --destination google.com --action start
```

```bash
playground debug block-traffic --container connect --destination broker --both-ways --duration 30s --action start
```

```bash
playground debug block-traffic --isolate broker2 --duration 2m --action start
```

```bash
playground debug block-traffic --isolate broker2 --action stop
```

## Example output

```text
$ playground debug block-traffic --isolate pg-bt-test-a --duration 2m --action start
15:24:04 ℹ️ 🏝️ Isolating container pg-bt-test-a from the other containers of its network(s): 192.168.144.2/20 (gateway 192.168.144.1)
15:24:04 ℹ️    still working: loopback, the docker DNS, the gateway (the host, published ports) and the internet
15:24:04 ℹ️ Applying iptables rule to container: pg-bt-test-a
15:24:05 ℹ️ Output of command iptables-save for container pg-bt-test-a
15:24:05 ℹ️ ⏳ the traffic heals by itself in 2m, at 15:26:05 (timer pid 47698, log /tmp/playground-block-traffic/1031383968.log)
15:24:05 ℹ️    --action stop with the same flags ends it now, playground stop ends it with the environment
```

```text
$ playground debug block-traffic --isolate pg-bt-test-a --action stop
15:24:06 ℹ️ ⏹️ timer of --duration cancelled (--action stop, pid 47698)
15:24:06 ℹ️ 🟢 Ending the isolation of container pg-bt-test-a: 192.168.144.2/20 (gateway 192.168.144.1)
15:24:06 ℹ️ Applying iptables rule to container: pg-bt-test-a
15:24:07 ℹ️ Output of command iptables-save for container pg-bt-test-a
```


