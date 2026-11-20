# playground debug dns

🔤 Break the name resolution of a hostname inside a container: NXDOMAIN, a wrong ip, a slow resolver

'debug block-traffic' works on ip addresses: it cannot reproduce a  
broker ip that changed while a client kept the old one  
(networkaddress.cache.ttl, client.dns.lookup), an UnknownHostException  
storm, or a resolver so slow that the lookups time out. This fakes the  
DNS answers for one hostname, seen from one container (or several),  
the other names resolve as usual.

- `--nxdomain`: the name does not exist (UnknownHostException)
- `--servfail`: the resolver fails (temporary failure in name resolution)
- `--resolve-to <ip>`: the name resolves to this ip (an A record)
- `--delay <duration>`: the real answer, after a delay (500ms, 3s); from 10s on, the lookups of glibc fail (timeout:5, attempts:2)
- `--reset`: back to the real DNS (with `--host`: only this hostname)
- **(no flag)**: the faults applied, and how `--host` resolves now

A small DNS proxy runs in a sidecar container (python:3-alpine) in the  
network namespace of the container, and /etc/resolv.conf of the  
container points to it: no restart, nothing installed in the  
container. The other names are forwarded to the original nameservers.

❕ A JVM caches the lookups (networkaddress.cache.ttl, 30 seconds by  
default, 10 seconds for a failure: networkaddress.cache.negative.ttl),  
and a Kafka client only resolves a broker name when it opens a  
connection: an established connection keeps working. A restart of  
the container gives it back its original /etc/resolv.conf: the faults  
are gone (the next call of the command cleans up the proxy).

🧪 Docker only (not cfk).

## Usage

```bash
playground debug dns [OPTIONS]
```

## Options

#### `--container, -c, --pod, -p CONTAINER`

🐳 container name (or pod name when cfk environment is used)

🎓 Tip: you can pass multiple containers by specifying `--container` multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | `connect`

#### `--host HOST`

🏷️ Hostname whose resolution is faked (e.g. broker, schema-registry, a database or a cloud endpoint)

#### `--nxdomain`

🕳️ The hostname does not exist (NXDOMAIN: UnknownHostException)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--servfail`, `--resolve-to`, `--delay`, `--reset`

#### `--servfail`

💥 The resolver fails (SERVFAIL: temporary failure in name resolution)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--nxdomain`, `--resolve-to`, `--delay`, `--reset`

#### `--resolve-to IP`

🔀 The hostname resolves to this ip address

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--nxdomain`, `--servfail`, `--delay`, `--reset`

#### `--delay DELAY`

🐢 The real answer is sent after this delay: seconds, or a number with a unit ms or s (e.g. 500ms, 3s, 12s)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--nxdomain`, `--servfail`, `--resolve-to`, `--reset`

#### `--reset`

🧽 Back to the real DNS: every fault of the container, or only the one of `--host`

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--nxdomain`, `--servfail`, `--resolve-to`, `--delay`

## Examples

```bash
playground debug dns --container connect --host broker --nxdomain
```

```bash
playground debug dns --container connect --host schema-registry --resolve-to 10.1.2.3
```

```bash
playground debug dns -c connect -c ksqldb-server --host broker --delay 12s
```

```bash
playground debug dns --container connect --host broker
```

```bash
playground debug dns --container connect --host broker --reset
```

```bash
playground debug dns --container connect --reset
```

## Example output

```text
$ playground debug dns --container connect --host broker --nxdomain
11:25:44 ℹ️ 🚀 starting the DNS proxy of connect (playground-debug-dns-connect)
11:25:45 ℹ️ 🔤 from connect, broker does not exist (NXDOMAIN)
11:25:45 ℹ️ 🔎 from connect, broker does not resolve (after 42 ms)
11:25:45 ❗ 🗃️ a JVM caches its lookups: networkaddress.cache.ttl (30s by default) for a success, networkaddress.cache.negative.ttl (10s) for a failure
11:25:45 ℹ️ 🧽 back to the real DNS: playground debug dns --container connect --reset
```

```text
$ playground debug dns --container connect --host schema-registry --resolve-to 10.1.2.3
11:25:46 ℹ️ 🔤 from connect, schema-registry resolves to 10.1.2.3
11:25:46 ℹ️ 🔎 from connect, schema-registry resolves to 10.1.2.3 (in 42 ms)
11:25:46 ❗ 🔁 a Kafka client resolves schema-registry when it opens a connection: an established connection keeps the old ip (to force a reconnection: playground debug block-traffic --destination schema-registry --action start, then stop)
```

```text
$ playground debug dns --container connect --host broker
11:25:47 ℹ️ 🔤 DNS faults on connect:
   broker does not exist (NXDOMAIN)
   schema-registry resolves to 10.1.2.3
11:25:47 ℹ️ 📊 2 queries answered with a fault so far (docker logs playground-debug-dns-connect)
11:25:48 ℹ️ 🔎 from connect, broker does not resolve (after 40 ms)
```

```text
$ playground debug dns --container connect --host broker --delay 12s
11:25:48 ℹ️ 🔤 from connect, broker answers after 12s
11:25:58 ℹ️ 🔎 from connect, broker does not resolve (after 10061 ms)
11:25:58 ❗ ⏱️ a delay of 10s or more is longer than the glibc resolver waits (options timeout:5 attempts:2): every lookup fails after 10s (UnknownHostException), before the answer comes
```


