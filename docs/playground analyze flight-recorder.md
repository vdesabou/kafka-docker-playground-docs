# playground analyze flight-recorder

🛩️ Analyze a Java Flight Recorder recording: where the time of the connector tasks goes

📊 For the Kafka Connect task threads (task-thread-\*, or `--threads` / `--connector`): the time of each thread by state (running, blocked on network I/O by remote host, Kafka client, locks, waiting, file I/O), the CPU by layer (connector, converters, SMTs, Kafka client, connect framework, libraries, logging, JDK), the hot methods, the allocation by class, locks and waits by site, the busiest threads of the JVM, GC pauses and exceptions, and findings with next steps. Without task thread in the recording, every thread is analyzed.

🐳 With `--container` (default: connect), it records the JVM for `--duration` over JMX (FlightRecorderMXBean: no jcmd, which the cp images do not have, and no restart) with the settings of tools/jfr-analyzer/playground.jfc, then analyzes the recording. playground connector benchmark records the measure the same way.

🔖 Reads .jfr files of JDK 11+ JVMs with the JDK flight recorder API, run in a eclipse-temurin:25-jdk container (pulled the first time). The settings of the recording matter: playground.jfc records socket, file, lock and park events from 1 ms and the CPU of each thread every second; a recording made with the default or profile settings of the JDK gives fewer details (throttled socket events, 10 ms thresholds).

🌐 Also writes a self-contained HTML report (inline SVG charts, works offline) in `--output-dir`, opened in the browser in an interactive terminal

🧪 With `--sample`, it analyzes the digests shipped in tools/jfr-analyzer/samples (no Docker needed): a quick way to see what it reports.

🔖 Exit code is 0 when the analysis completed, 2 when the file is not a flight recording or has no event

## Usage

```bash
playground analyze flight-recorder [OPTIONS]
```

## Options

#### `--file, -f FILE`

🗒️  .jfr file to analyze (repeat `--file` for the recordings of several connect workers over the same period)

❕ Provide only one of `--file`, `--container` and `--sample`

🎓 Tip: use `<tab>` completion to trigger fzf completion  
use `<option+enter>` to use the value you typed manually

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--sample, -s SAMPLE`

🧪 Sample of tools/jfr-analyzer/samples

- **jdbc_postgres_sink**: drain of 3M avro records by the JDBC sink to PostgreSQL, 1 task, CP 8.3.2 (JDK 25)

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `jdbc_postgres_sink`

#### `--container, -c CONTAINER`

🐳 Container to record over JMX for `--duration` (default: connect). Its JMX port (`KAFKA_JMX_PORT`, `SCHEMA_REGISTRY_JMX_PORT`...) must be set, as in the playground environments

#### `--duration DURATION`

⏱️ Duration of the recording with `--container`, in seconds or with a s/m/h suffix (default is 60s)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `60s`

#### `--connector CONNECTOR`

🔗 Analyze the task threads of this connector only (task-thread-`<connector>`-`<n>`), and classify its frames as connector code (its class is read from the connect REST API when connect is running)

#### `--connector-class CONNECTOR_CLASS`

🔌 Class of the connector, to classify its frames as connector code (default: read from `--connector`, or guessed from the package)

#### `--threads REGEX`

🧵 Regular expression of the thread names to analyze (default: ^task-thread-, or the task threads of `--connector`)

#### `--output-dir, -o OUTPUT_DIR`

📂 Output directory for the recording taken from a container, the digest and the HTML report (default: ./jfr-analysis-output)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `./jfr-analysis-output`

#### `--json`

🗂️  Output JSON (no text report, no HTML report)

#### `--top TOP`

📊 Number of rows per section (default: 10)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `10`

## Examples

```bash
playground analyze flight-recorder --sample jdbc_postgres_sink
```

```bash
playground analyze flight-recorder
```

```bash
playground analyze flight-recorder -c connect --duration 2m --connector my-jdbc-sink
```

```bash
playground analyze flight-recorder --file flight-recorder-connect-2026-10-16-09-12-00.jfr
```

```bash
playground analyze flight-recorder -f /tmp/playground-benchmark/my-sink-20261016-091200-connect.jfr -f /tmp/playground-benchmark/my-sink-20261016-091200-connect2.jfr
```

```bash
playground analyze flight-recorder -f recording.jfr --threads '^pool-.*' --json
```


