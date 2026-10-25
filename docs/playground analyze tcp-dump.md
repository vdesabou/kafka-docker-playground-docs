# playground analyze tcp-dump

🦈 Analyze a network capture (.pcap, .pcapng): refused and reset connections, retransmissions, TLS alerts, DNS errors, Kafka and HTTP errors and response times

📊 Reads a capture taken by playground debug tcp-dump, or sent by a customer (tcpdump, Wireshark), and reports: the TCP conversations with their handshake time, the connections refused (SYN answered with a reset) or unanswered, the resets of established connections, retransmissions and zero windows, the TLS handshakes (SNI) and alerts with their likely cause, DNS errors, the Kafka requests by API with their response times and error codes (port 9092, the KRaft controller and the host listeners of the playground, plus `--kafka-port`), and the HTTP requests by endpoint with their status codes and response times, the error responses with an excerpt of the request and response bodies (plain HTTP on the usual ports of the playground: 8081 to 8083, 8088, 9006, 9021, plus `--http-port`).

🏷️ Container names instead of ip addresses: with `--hosts` (`<ip>` `<name>` per line), or the .hosts file that playground debug tcp-dump writes next to the capture (found automatically).

🐳 With `--container`, it captures for `--duration` with playground debug tcp-dump, then analyzes the captures.

🔧 tshark runs in the nicolaka/netshoot image (pulled the first time): nothing to install but python3.

🌐 Also writes a self-contained HTML report (inline SVG charts, works offline) in `--output-dir`, opened in the browser in an interactive terminal

🧪 With `--sample`, it analyzes the captures shipped in tools/tcp-dump/samples: a quick way to see what it reports.

🔖 Exit code is 0 when the analysis completed, 2 when the capture has no packet

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-jvm-diagnostics

## Usage

```bash
playground analyze tcp-dump [OPTIONS]
```

## Options

#### `--file, -f FILE`

🦈 Capture file (.pcap or .pcapng), repeat `--file` for several captures (one report each)

❕ Provide only one of `--file`, `--container` and `--sample`

🎓 Tip: use `<tab>` completion to trigger fzf completion  
use `<option+enter>` to use the value you typed manually

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--sample, -s SAMPLE`

🧪 Sample of tools/tcp-dump/samples

- **kafka_and_network_errors**: a Kafka client producing and consuming, a refused connection, a connection without answer, a TLS handshake rejected (certificate_unknown) and a DNS NXDOMAIN
- **http_errors**: an HTTP client posting JSON records (like the HTTP sink): 200, 429, 500, 401 and 404 responses with their bodies, a slow endpoint and a request without response

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Allowed Values: | `kafka_and_network_errors`, `http_errors`

#### `--container, -c, --pod, -p CONTAINER`

🐳 Container name (or pod name when cfk environment is used) to capture for `--duration`, then analyze (default: connect)

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--duration DURATION`

⏱️ Duration of the capture with `--container`, in seconds or with a s/m/h suffix (default is 30 seconds)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `30`

#### `--port PORT`

🚪 With `--container`, only the traffic to or from this port

#### `--filter FILTER`

🔍 With `--container`, a tcpdump filter expression (pcap-filter syntax)

#### `--hosts HOSTS`

🏷️ Hosts file (`<ip>` `<name>` per line) to show names instead of ip addresses (default: the .hosts file next to the capture, when there is one)

#### `--kafka-port KAFKA_PORT`

📨 Other port to decode as Kafka (9092, 9093, 29092, 29292 and 29392 are always decoded)

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--http-port HTTP_PORT`

🌍 Other port to decode as HTTP (80, 8080, 8081, 8082, 8083, 8088, 9006 and 9021 are always decoded)

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--output-dir, -o OUTPUT_DIR`

📂 Output directory for the HTML report (default: ./tcp-dump-analysis-output)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `./tcp-dump-analysis-output`

#### `--json`

🗂️  Output JSON (no text report, no HTML report)

#### `--top TOP`

📊 Number of rows per section (default: 10)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `10`

## Examples

```bash
playground analyze tcp-dump --sample kafka_and_network_errors
```

```bash
playground analyze tcp-dump --sample http_errors
```

```bash
playground analyze tcp-dump -f tcp-dump-connect-9092-2026-10-25-09-25-35.pcap
```

```bash
playground analyze tcp-dump -f customer.pcapng --kafka-port 9094 --json
```

```bash
playground analyze tcp-dump -f http-sink.pcap --http-port 8443
```

```bash
playground analyze tcp-dump -c connect -c broker --port 9092 --duration 1m
```


