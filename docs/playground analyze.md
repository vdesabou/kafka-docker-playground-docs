# playground analyze

🔎 Analyze commands

Turn what you collected into findings: each command reads a file (a  
dump, a log, a bundle, a report, yours or one a customer sent) or takes  
it from a running container, and prints a digest with what is wrong and  
what to do, plus an HTML report to share (opened in your browser). They  
all work offline, and `--sample` runs them on the samples shipped with the  
playground, to see what they report.

- **thread-dump**: deadlocks, lock contention, stuck threads
- **gc-logs**: GC pauses, failures, live set, leak trend
- **heap-dump**: Eclipse MAT leak suspects, retained sizes
- **logs**: ERROR/FATAL digest of logs, folders, zips
- **oracle-xstream-report**: Oracle XStream diagnostics (orclcdc_diag)
- **cfk-bundle**: CFK support bundle: pods, events, CRs, logs
- **flight-recorder**: JFR: where the time of the connector tasks goes
- **tcp-dump**: network capture: resets, TLS alerts, Kafka errors
- **jscissors**: traced method calls: arguments, durations, exceptions

To collect them: playground debug thread-dump, heap-dump, flight-recorder, tcp-dump, jscissors,  
playground connector oracle-cdc-xstream generate-report,  
playground debug cfk generate-bundle.

| Attributes       | &nbsp;
|------------------|-------------
| Alias:           | analyse

## Usage

```bash
playground analyze COMMAND
```

## Commands

- [thread-dump](playground%20analyze%20thread-dump) - 🧵 Analyze java thread dumps: deadlocks, lock contention, stuck and CPU-hungry threads
- [heap-dump](playground%20analyze%20heap-dump) - 🔬 Analyze a heap dump with Eclipse Memory Analyzer (MAT), run headless in Docker
- [logs](playground%20analyze%20logs) - 🔥 Show a digest of ERROR/FATAL records found in log files, folders or zip bundles
- [gc-logs](playground%20analyze%20gc-logs) - 📈 Analyze JVM Garbage Collection logs
- [oracle-xstream-report](playground%20analyze%20oracle-xstream-report) - 🅾️ Analyze Oracle XStream CDC diagnostics reports (orclcdc_diag.sql)
- [cfk-bundle](playground%20analyze%20cfk-bundle) - 📦 Analyze a Confluent for Kubernetes (CFK) support bundle
- [flight-recorder](playground%20analyze%20flight-recorder) - 🛩️ Analyze a Java Flight Recorder recording: where the time of the connector tasks goes
- [jscissors](playground%20analyze%20jscissors) - ✂️ Analyze a jscissors trace: what the traced methods did, call by call
- [tcp-dump](playground%20analyze%20tcp-dump) - 🦈 Analyze a network capture (.pcap, .pcapng): refused and reset connections, retransmissions, TLS alerts, DNS errors, Kafka and HTTP errors and response times


