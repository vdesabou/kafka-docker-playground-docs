# playground debug degrade-traffic

🐌 Add latency, packet loss, corruption or a bandwidth limit using tc

Some issues only happen on a slow or unreliable network: request  
timeouts, retries, rebalances, producer or consumer errors. This makes  
the traffic from a container slow or lossy, to a destination (and  
port) or to everything, and `--action` stop puts it back to normal  
without restarting anything.

Several effects can be combined in one call, e.g. `--latency` 100ms  
`--loss` 1%. A new `--action` start replaces what was applied before on  
the container. `--action` status shows what is applied and the measured  
round trip to the destination.

tc runs from the nicolaka/netshoot image in the network namespace of  
the container (an ephemeral container of the pod with cfk): nothing is  
installed in the container, so it works with any image.

❕ tc only shapes the packets a container sends: with `--latency` 100ms  
the round trip to the destination grows by 100ms. A container restart  
removes the degradation.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-network-traffic  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%90%8C-a-slow-or-broken-network-on-purpose

## Usage

```bash
playground debug degrade-traffic [OPTIONS]
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

🎯 Destination: an ip address, a container name or a hostname (default: all the traffic of the container)

#### `--port PORT`

🚪 Only the tcp traffic to this port of the destination

#### `--latency LATENCY`

⏱️ Added latency, e.g. 100ms, 1s

#### `--jitter JITTER`

〰️ Random variation of the latency, e.g. 20ms (needs `--latency`)

#### `--loss LOSS`

🕳️ Percentage of packets dropped, e.g. 1%

#### `--corruption CORRUPTION`

🧨 Percentage of packets corrupted, e.g. 1%

#### `--duplicate DUPLICATE`

👯 Percentage of packets duplicated, e.g. 1%

#### `--rate RATE`

🚰 Bandwidth limit, e.g. 1mbit, 500kbit

#### `--action ACTION`

🟢 start, stop or status

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes
| Allowed Values: | `start`, `stop`, `status`

## Examples

```bash
playground debug degrade-traffic --container connect --destination broker --latency 100ms --action start
```

```bash
playground debug degrade-traffic -c connect --destination broker --latency 100ms --jitter 20ms --loss 1% --action start
```

```bash
playground debug degrade-traffic -c connect -c ksqldb-server --destination broker --port 9092 --loss 5% --action start
```

```bash
playground debug degrade-traffic -c connect --rate 1mbit --action start
```

```bash
playground debug degrade-traffic -c connect --destination broker --action status
```

```bash
playground debug degrade-traffic -c connect -c ksqldb-server --action stop
```


