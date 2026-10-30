# playground analyze logs

🔥 Show a digest of ERROR/FATAL records found in log files, folders or zip bundles

The offline counterpart of `playground container logs --errors`, for  
logs that do not come from a running container: a customer support  
bundle, a CI artifact, a log file you were sent.

Repeated records are de-duplicated with an occurrence count, stack  
traces are collapsed to the exception chain ("Caused by:") plus a few  
frames of the deepest cause. Only records with an explicit level are  
reported (" ERROR ", "[ERROR]", level=error, "level":"error"), plus  
uncaught java exceptions: records logged at INFO/DEBUG/TRACE, and  
level-less lines that merely contain "error" or "failed", never are.

📂 Folders are scanned recursively. .zip, .tar, .tar.gz and .tgz files  
are extracted in a temporary folder, .gz files are decompressed on the  
fly, binary files are skipped, and so are the copies of a file or of a  
CFK support bundle already analyzed (an archive next to its extracted  
folder). Only files with findings are shown. The HTML report also has  
the configuration: the configs logged at startup (KafkaConfig values:,  
DistributedConfig, connector and client configs…) and the .properties  
and connector JSON files of the input.

☸️ A Confluent for Kubernetes (CFK) support bundle (kubectl confluent support-bundle or playground debug cfk generate-bundle: a folder with cluster-details.txt, or with cluster-resources/ and operator/), alone or inside a folder or an archive, is detected and analyzed as a whole, in a Docker image built on first use: Warning events, pods (phase, waiting reasons, restarts, OOMKilled), every platform.confluent.io custom resource (phase/state, ready replicas, False conditions, failed connector tasks), the environment checked against the CFK support matrix (Kubernetes, CFK operator, CP and init container versions), the recent changes (who edited which CR and when, StatefulSet rollouts, pod restarts), the configuration (kafka.properties, zookeeper.properties, schemaregistry.properties, connect.properties and controlcenter.properties rendered by CFK, configOverrides, config logged at startup, connector configs from the Connector CRs and the config dumps of the logs), a JVM default truststore set without its password, and the ERROR/FATAL records of its logs, sorted into ~30 categories (pod failures, TLS, auth, MDS/RBAC, license, KRaft, replication, storage, scheduling…) with remediation steps. 📕 The log messages and events of known CFK problems (CFK triage table of Confluent support: roll blocked by the pre-roll checks, expired certificate, `INCONSISTENT_CLUSTER_ID`, ZooKeeper to KRaft migration, authorizer timeout, license secret…) are listed first, with what they mean and the KB / docs to read; `PLAYGROUND_CFK_RUNBOOKS_FILE` adds the internal runbook links of Confluent support (terminal and `--json` only, never in the HTML report). Probe failures and back-offs of a pod that is Running and Ready in the bundle are low and marked transient. Each issue is attributed to a component and an instance (CR name), and to its connector: `--component` keeps some of them, the HTML report has Component / Instance / Connector filters. 🔒 Secrets, IPs, hostnames, emails and LDAP DNs are sanitized by default (best effort: review before sharing), `--no-sanitize` for internal bundles only. `--logs-only` gives the plain log digest instead.

🔒 Passwords and other secrets (password=…, JAAS configs, tokens, keys, credentials in URLs), IPs, hostnames, emails and LDAP DNs are replaced by placeholders (`<REDACTED>`, `<IP-1>`, `<HOST-1>`…, the same in the digest, the report and the JSON) by default. It is best effort: review the output before sharing it. `--no-sanitize` keeps them, for internal logs only.

🧭 After the digest of each file, a short summary: time range, occurrences by connector, known causes with what to do, root causes no known cause explains, and the configuration logged at startup (connectors, components, clients) with the keys changed between restarts. `--connector` keeps one connector, `--show-config` prints a configuration.

🌐 Also writes a self-contained HTML report in `--output-dir`, opened in the browser in an interactive terminal: verdict, known causes (task killed, authentication, TLS, unknown magic byte, OutOfMemoryError...), occurrences over time, root causes (deepest exception of each record), files with findings, and every distinct record.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-container-logs  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%95%B5%EF%B8%8F-a-connector-failed-read-the-logs-live-or-from-a-customer-bundle

## Usage

```bash
playground analyze logs [OPTIONS]
```

## Environment Variables

#### `PLAYGROUND_CFK_RUNBOOKS_FILE`

📕 CFK support bundle: JSON file with the internal runbook links of the known CFK issues, printed in the terminal and in `--json`, never in the HTML report (default reproduction-models/_miscellaneous/cfk-analysis/runbooks-internal.json, format in cfk-analysis/runbooks.py)

## Options

#### `--file, -f FILE`

🗒️  Log file, folder, .zip, .tar(.gz) or .gz file to analyze

🎓 Tip: can be set several times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--sample, -s SAMPLE`

🧪 Sample of tools/log-analyzer/samples and cfk-analysis/samples

- **connect_task_failure**: Connect worker log: Oracle XStream connector with a wrong password, an unknown outbound server, and a task failing after the outbound server was stopped
- **support_bundle**: .zip with that log and a gzipped broker log
- **cfk_bundle**: CFK support bundle: kafka-2 crash-looping on an expired certificate, pending volume, OOMKilled Connect pod, failed connector task, Schema Registry authentication failure, operator reconcile errors

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Allowed Values: | `connect_task_failure`, `support_bundle`, `cfk_bundle`

#### `--include-warnings`

🟠 Also report WARN records

#### `--max-findings MAX_FINDINGS`

✂️ Maximum number of distinct records to show per file (default 40). The HTML report and `--json` have them all

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `40`

#### `--output-dir, -o OUTPUT_DIR`

📂 Output directory for the HTML report (default: ./log-analysis-output)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `./log-analysis-output`

#### `--json`

🗂️  Output JSON on stdout: summary, findings, root causes and every distinct record (text digest on stderr, no HTML report)

"type": "logs", with the analysis of each CFK support bundle found in "cfk_bundles"; "type": "cfk-bundle" (issues with their recommendation, environment, timeline) when the input is one CFK bundle

#### `--logs-only`

📜 Do not detect CFK support bundles: plain ERROR/FATAL digest of every log file

#### `--connector, -c CONNECTOR`

🔌 Only keep the records and the configuration of this connector ([connector|task-0] / [connector|worker] context of the log lines, WorkerSourceTask{id=connector-0}), in the digest, the summary, the HTML report and the JSON

🎓 Tip: can be set several times. The 🔌 by connector line of the summary lists the names

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--with-worker`

🧱 With `--connector`, also keep the records and configs without connector context (worker, clients of the worker, Kafka)

#### `--show-config NAME`

⚙️ Print the configuration logged at startup (last dump, with the keys changed between restarts) as key = value: for a connector, its own configs (a config contained in a bigger one with the same values is only named, its producer / consumer / admin clients summed up in one line); for a config class (ProducerConfig, DistributedConfig…) or a client id, every match

#### `--json-sections SECTIONS`

🗂️ With `--json`, only these sections, comma separated: summary, findings, known_causes, root_causes, files, files_without_findings, configuration (default: all). For example `--json-sections` summary,findings,root_causes

#### `--component COMPONENT`

🧩 CFK support bundle: only keep the issues of this component (repeat `--component` for several). other = not a CFK component (nodes, volumes, unknown pods)

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Allowed Values: | `kafka`, `kraftcontroller`, `zookeeper`, `connect`, `schemaregistry`, `ksqldb`, `controlcenter`, `kafkarestproxy`, `operator`, `other`

#### `--severity LEVEL`

🎚️  CFK support bundle: only keep the issues of this severity or above (critical | high | medium | low)

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `critical`, `high`, `medium`, `low`

#### `--no-sanitize`

⚠️  Do not sanitize passwords and other secrets, IPs, hostnames, emails and LDAP DNs (digest, HTML report, JSON, CFK bundle analysis)

🚫 NEVER use this for customer logs. Internal/test logs only.

## Examples

```bash
playground analyze logs --sample connect_task_failure
```

```bash
playground analyze logs --sample support_bundle --include-warnings
```

```bash
playground analyze logs --file connect.log
```

```bash
playground analyze logs --file connect-logs.zip --include-warnings
```

```bash
playground analyze logs -f ./logs -f broker.log.gz --max-findings 10
```

```bash
playground analyze logs -f support-bundle.zip --output-dir /tmp/log-reports
```

```bash
playground analyze logs -f connect.log --json
```

```bash
playground analyze logs --sample cfk_bundle
```

```bash
playground analyze logs -f connect-logs.zip --connector my-jdbc-sink --show-config my-jdbc-sink
```

```bash
playground analyze logs -f connect.log --json --json-sections summary,findings,root_causes
```

```bash
playground analyze logs -f ./support-bundle-ns-confluent.tar.gz --component connect --severity high
```

```bash
playground analyze logs -f ./support-bundle-ns-confluent/ --logs-only
```

## Example output

```text
$ playground analyze logs -f connect.log
17:23:19 ℹ️ 🔥 ERROR/FATAL digest for connect.log
🔎 1 distinct record(s), 2 occurrence(s), in 12 lines

🔴 ERROR x2 (first seen line 2, last seen line 10)
[2026-10-13 10:00:05,123] ERROR [http-sink|task-0] WorkerSinkTask{id=http-sink-0} Task threw an uncaught and unrecoverable exception. Task is being killed and will not recover until manually restarted (org.apache.kafka.connect.runtime.WorkerTask:234)
    org.apache.kafka.connect.errors.ConnectException: Exiting WorkerSinkTask due to unrecoverable exception.
    Caused by: org.apache.kafka.connect.errors.ConnectException: Error while processing HTTP request with Url : http://httpserver:9006/api/messages, Status code : 500
        at io.confluent.connect.http.writer.HttpWriterImpl.handleErrors(HttpWriterImpl.java:405)

17:23:19 ℹ️ 📊 1 file(s) with findings out of 1 scanned (binary files skipped: 0)
17:23:19 ℹ️ 🔒 Sanitized (best effort, review before sharing): 0 secret(s), 0 IP(s), 0 hostname(s), 0 email(s), 0 LDAP DN(s), --no-sanitize to keep them
17:23:19 ℹ️ ✅ HTML report saved: /home/me/log-analysis-output/connect-log-report.html
17:23:19 ℹ️ 🔗 Open in browser: file:///home/me/log-analysis-output/connect-log-report.html
```


