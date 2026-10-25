# playground debug tcp-dump

🕵️‍♂️ Take a tcp dump (sniffing network)

Captures the traffic in or out of one or more containers and brings the capture files back, with a summary and  
ready to open in Wireshark. Narrow it with `--port` and/or `--filter` (any tcpdump expression) when you know what you  
care about.

⏱️ Without `--action`, it captures for `--duration` (default 30s): reproduce the issue meanwhile, Ctrl+C stops it  
earlier and keeps the capture. With several `--container`, the captures run at the same time, so both sides of a  
connection can be compared. For a window of any length, in a script or by hand: `--action` start, reproduce,  
`--action` stop (`--action` status shows the running captures, kept in playground.ini as tcp_dump.`<container>`).

📂 For each container, `--output-dir` (default: current folder) gets:

- **tcp-dump-`<container>`-`<port>`-`<date>`.pcap**: the capture
- **tcp-dump-`<container>`-`<port>`-`<date>`.hosts**: ip address → container name
- **tcp-dump-`<container>`-`<port>`-`<date>`-tcp-dump-report.html**: the HTML report of the analysis

🔎 Each capture is then analyzed with playground analyze tcp-dump (`--no-analyze` to skip it): refused and reset  
connections, retransmissions, TLS alerts, DNS errors, Kafka and HTTP errors and response times (with the bodies of  
the HTTP error responses), with container names instead of ip addresses, as a text digest and an HTML report.

🐳 tcpdump runs from the nicolaka/netshoot image in the network namespace of the container (an ephemeral  
container of the pod with cfk): nothing is installed in the container, so it works with any image.

❕ On an encrypted listener you will see the handshake and the failures (TLS alerts), but not the records  
themselves.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-jvm-diagnostics

## Usage

```bash
playground debug tcp-dump [OPTIONS]
```

## Options

#### `--container, -c, --pod, -p CONTAINER`

🐳 container name (or pod name when cfk environment is used)

🎓 Tip: you can pass multiple containers by specifying `--container` multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | `connect`

#### `--port PORT`

🚪 Only the traffic to or from this port (default: every port)

#### `--filter FILTER`

🔍 tcpdump filter expression (pcap-filter syntax), combined with `--port` when both are set

Examples: 'host postgres', 'tcp[tcpflags] & tcp-rst != 0', 'not port 22'

#### `--duration DURATION`

⏱️ Duration of the capture without `--action`, in seconds or with a s/m/h suffix (default is 30 seconds)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `30`

#### `--snaplen SNAPLEN`

✂️ Bytes kept from each packet (default: the whole packet). 128 keeps the headers only, for long captures

#### `--action ACTION`

🟢 start, stop (copy and summarize the capture) or status, for a capture of any length (default: capture for `--duration`)

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `start`, `stop`, `status`

#### `--output-dir OUTPUT_DIR`

📂 Folder for the capture files (default: current folder)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `.`

#### `--no-analyze`

🙈 Only copy the captures, do not analyze them with playground analyze tcp-dump

#### `--no-open`

🦈 Do not open the captures in Wireshark (they are never opened in CI or outside a terminal)

## Examples

```bash
playground debug tcp-dump --container control-center --port 9021 --duration 60
```

```bash
playground debug tcp-dump -c connect -c broker --port 9092 --duration 2m
```

```bash
playground debug tcp-dump -c connect --filter "host postgres and tcp[tcpflags] & tcp-rst != 0"
```

```bash
playground debug tcp-dump -c connect --action start
```

```bash
playground debug tcp-dump -c connect --action stop --output-dir /tmp/captures
```


