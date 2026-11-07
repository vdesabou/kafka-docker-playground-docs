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

🧰 The logs of every Kafka client of Confluent are read, not only Java:  
the librdkafka lines of the C/C++, Python, Go, .NET and JavaScript  
clients ("%3|1793896102.923|FAIL|rdkafka#producer-1| …", by their  
syslog level, timestamp included, also the Node.js objects of the  
JavaScript client logger), the .NET console logger ("fail:", "crit:")  
and inner exceptions (" ---\> "), Python tracebacks (chained ones as one  
record, deepest cause last) and KafkaError{code=…}, Go and Rust panics,  
uncaught Node.js errors (KafkaJS, "[cause]:"), the tracing lines of the  
Rust client. The known causes include the client ones (records not  
delivered in time, producer buffer full, max.poll.interval.ms exceeded,  
wrong security.protocol, idle connection closed by the broker).

📂 Folders are scanned recursively. .zip, .tar, .tar.gz and .tgz files  
are extracted in a temporary folder, .gz files are decompressed on the  
fly, binary files are skipped, and so are the copies of a file or of a  
CFK support bundle already analyzed (an archive next to its extracted  
folder). A JSON export of log events (.json, .jsonl, .ndjson, also  
gzipped: AWS CloudWatch Logs Insights @timestamp/@message, CloudWatch  
events, Elasticsearch / OpenSearch hits, structured JSON logs with  
level/logger_name/message/stack_trace) and a CSV export of log events  
(.csv, also gzipped: Kibana / OpenSearch Dashboards Discover, Splunk,  
Datadog, Grafana: one event per row, a cell holding the JSON log line of  
the container is parsed) are converted back to log lines, oldest first,  
and analyzed as a log file. So are JSON lines whatever the extension (a  
fluentd / Kubernetes / logstash dump saved as .log: streamed, a dump of  
several GB is converted in seconds and the digest reads its messages,  
not the metadata). ⚠️ An input not fully read (a truncated or  
corrupt .gz, an archive that does not fully extract) is listed at the  
end, in the HTML report and in `--json` (.summary.incomplete_inputs):  
never a silent ✅, and exit code 1 when nothing could be read at all.  
Bytes that are not UTF-8 (a Latin-1 character) are read as they are.  
🧰 The files of the input that another analyzer reads better (GC logs,  
thread dumps, heap dumps, flight recordings, network captures, Oracle  
XStream diagnostics reports, found by their content or name) are listed  
with the playground analyze command to run on each, in the summary, the  
HTML report and `--json` (.other_files); the ones extracted from an  
archive are kept next to the report (`<input>`-other-files/).  
Only files with findings are  
shown. 🔭 When no file has findings, an overview says what the logs  
contain (period covered, records by level, top messages and loggers) and  
what to ask for next (a longer window, the logs of the component that  
fails, a new export of a log console). The HTML report also has  
the configuration: the configs logged at startup (KafkaConfig values:,  
DistributedConfig, connector and client configs…) and the .properties  
and connector JSON files of the input.

⏳ A large file (20 MB or more) shows a progress bar in the terminal  
(MB read, speed, ETA), and with 20 MB or more of input the report opens  
in the browser right away as a progress page (step, a bar for the file  
being read and one for the whole input, elapsed time, speed, ETA of the file and of the whole input) that becomes the report when the analysis ends. The last line  
gives the size read and the time it took. 📤 Share in the report: the  
.zip of the report and its file pages (written next to it when they are  
under 200 MB), the summary to paste, an email. An archive (.tar, .tar.gz,  
.tgz…) shows a bar while it is extracted.

🗂️ One report: the sections of each CFK support bundle of the input  
(pods, custom resources, events, versions, recent changes, issues by  
category) are in the log report, right after its verdict; the comparison  
of several bundles is linked from it. Several CFK bundles are analyzed in  
parallel, 4 at a time (`PLAYGROUND_CFK_PARALLELISM` to change it), their  
output printed in order.

☸️ A Confluent for Kubernetes (CFK) support bundle (kubectl confluent support-bundle or playground debug cfk generate-bundle: a folder with cluster-details.txt, or with cluster-resources/ and operator/; or a flat collection of kubectl outputs with a confluent-operator-\*.log or the YAML of a platform.confluent.io custom resource at its top), alone or inside a folder or an archive, is detected and analyzed as a whole by the CFK analyzer (a container image built on first use): Warning events, pods (phase, waiting reasons, restarts, OOMKilled), every platform.confluent.io custom resource (phase/state, ready replicas, False conditions, failed connector tasks), the environment checked against the CFK support matrix (Kubernetes, CFK operator, CP and init container versions), the recent changes (who edited which CR and when, StatefulSet rollouts, pod restarts), the configuration (kafka.properties, zookeeper.properties, schemaregistry.properties, connect.properties and controlcenter.properties rendered by CFK, configOverrides, config logged at startup, connector configs from the Connector CRs and the config dumps of the logs), a JVM default truststore set without its password, and the ERROR/FATAL records of its logs, sorted into ~30 categories (pod failures, TLS, auth, MDS/RBAC, license, KRaft, replication, storage, scheduling…) with remediation steps. 📕 The log messages and events of known CFK problems (CFK triage table of Confluent support: roll blocked by the pre-roll checks, expired certificate, `INCONSISTENT_CLUSTER_ID`, ZooKeeper to KRaft migration, authorizer timeout, license secret…) are listed first, with what they mean and the KB / docs to read; `PLAYGROUND_CFK_RUNBOOKS_FILE` adds the internal runbook links of Confluent support (🔒 in the terminal, the HTML report and `--json`). 🔄 A CR whose image is not what its StatefulSet or pods run (operator did not apply it, roll not complete) is one finding, the exceeded quota events become one finding per ResourceQuota, each Warning event is counted once (event.txt and event.yaml) and a copy of the bundle inside the bundle is analyzed once. 🕰️ The time range of each log is listed, with a finding when a log starts long after its pod or after the last change of the CRs, and CRs that keep the "Reconcile is blocked" condition after the annotation was removed are one finding. 🕒 The changes of the CRs in the hour before the first critical / high issue are marked and listed in one finding. 🧩 A Connect whose spec.build.onDemand plugins cannot be installed (config-init-container failing, install error, slow init) and a Connector CR whose class is not installed are findings with next steps. 🔁 With several CFK bundles (-f a.tgz -f b.tgz), they are compared, sorted by collection time: same cluster or not, versions, changes of the CRs between them, issues fixed / new / still there, known CFK issues, with a verdict (HTML report, "comparison" in `--json`). 🚚 A ZooKeeper to KRaft migration gets its own finding: phase / sub-phase of the KRaftMigrationJob, how long it has been there (events, operator requeues), its last error and the next steps of that sub-phase (DUAL-WRITE waiting for the finalize annotation is low). Probe failures and back-offs of a pod that is Running and Ready in the bundle are low and marked transient. Each issue is attributed to a component and an instance (CR name), and to its connector: `--component` keeps some of them, the HTML report has Component / Instance / Connector filters. 🔒 `--sanitize` replaces secrets, IPs, hostnames, emails and LDAP DNs by placeholders (best effort: review before sharing). 🔥 One report: its pod and operator logs go through the regular log digest, and the log report (root causes, timeline, connector cards and plugin versions, restarts, known bugs fixed later, which pod ran which task, data to request, summary for a ticket) has the ☸️ sections of the bundle right after its verdict (with `--json`: the bundle JSON, with .log_analysis); the issues of its log records come from the same records, and the ☸️ changes of the cluster (pods terminated or restarted, custom resources edited, rollouts) join its incident timeline, so that 🔗 and 💥 link the errors of the pod logs to them. One output for the case: `<input>`-ticket.md has a ☸️ section per bundle (environment, issues by severity, known CFK issues with their public links, critical and high issues), the 📥 data to request of the bundle joins the one of the logs, and `--compare` `<before bundle>` compares both the bundles (versions, CR changes, issues fixed / new / still there) and their pod logs. The ⚙️ configuration of the log report also has what only the bundle has: the properties rendered by CFK (ConfigMap `<cr>`-shared-config), the configOverrides of each CR and the Connector CRs (`--show-config` `<connector>` prints the CR with the config logged, config lint checks it), and 🔀 the keys of a Connector CR whose value differs from the config the worker logged when it started the connector (the operator did not apply a change). `--logs-only` gives only the log report, of every file of the bundle. 🎯 `--problem` "\<component, symptom, since when\>" matches the bundle against what the customer reports: the issues that explain it first, a verdict (explained, not explained, not covered by the logs), the changes before the date. 📥 A Data to request section says what to ask the customer for next, with why and the command: from the gaps of the bundle (logs that start too late, previous logs of restarted containers, no events, no operator log), from its findings (OOMKilled, Pending pods, TLS, failed connectors) and from the symptoms of `--problem`.

🔒 With `--sanitize`, passwords and other secrets (password=…, JAAS configs, tokens, keys, credentials in URLs), IPs, hostnames, emails and LDAP DNs are replaced by placeholders (`<REDACTED>`, `<IP-1>`, `<HOST-1>`…, the same in the digest, the report and the JSON). Off by default: use it before sharing the output outside Confluent, and review it anyway (best effort).

🧭 After the digest of each file, a short summary: time range, occurrences by connector, known causes with what to do (📚 and a Confluent knowledge-base article for many of them, 🔒 the internal runbooks of Confluent support when the private reproduction-models repository is there), root causes no known cause explains, and the configuration logged at startup (connectors, components, clients) with the keys changed between restarts. Also: 🏷️ the version of each connector plugin (with the playground connector-plugin changelog command since that version) and of Kafka, 📥 the data to request next from the customer, each with why and how (a complete copy of a file not fully read, a longer window, the logs since the last restart of a worker whose startup is missing, the broker or Schema Registry logs when the findings point there, a heap dump, GC logs, thread dumps or the TLS debug output for the known causes they explain, and the exact DEBUG logger to set for the errors no known cause explains), also in `<input>`-ticket.md, 🖥️ which worker ran which task and when (from the "Starting task" lines of each worker's logs), with 🎯 a connector whose errors all come from one worker while its tasks also ran on others (a DNS, truststore, plugin path or network difference of that host), 🩹 the known bugs of a plugin fixed in a later version whose error is in the logs, with a verdict from the version each connector runs (affected: upgrade to …; it has the fix: another cause; version unknown), 🔄 the restarts, stops, worker rebalances, consumer rejoins, active controller changes and GC pauses of 1 s or more counted from the INFO lines and the GC logs (🌀 a storm when the rebalances repeat), 💥 the bursts of errors right after a GC pause, a stop, a restart or a controller change, 🔗 the errors that came right after a change (config key, restart) of the same connector, and 🧪 a config lint of each connector (errors.tolerance=all without a DLQ, a DLQ with replication factor 1, max.poll.records too high for max.poll.interval.ms, acks not all…). `--connector` keeps one connector, `--show-config` prints a configuration, `--since` / `--until` keep a window of time. 📋 `<input>`-ticket.md, next to the report: the same summary in Markdown, always sanitized, to paste in a ticket (also in 📤 Share of the report). 📈 With `--compare` repeated (oldest first), a trend over every input.

🌐 Also writes a self-contained HTML report in `--output-dir`, opened in the browser in an interactive terminal: verdict, known causes (task killed, errors.tolerance exceeded, authentication, TLS, wrong security.protocol, unknown magic byte, OutOfMemoryError, fenced producer, rebalances, throttling, offsets not committed in time, task not stopped in time...), an incident timeline (all files merged: first occurrence of each error and known cause, restarts, connectors reconfigured, config changes, processes stopped, active controller changes and GC pauses of 1 s or more read from the GC logs of the input, 💥 with the burst of ERROR / WARN of every file in the 60 s after one of them when it is well above the usual rate ("39 Partition leadership changed right after broker 2 shut down"); a chart places them in time, one lane per component, long gaps cut, and a Δ column gives the time between them), a card per connector (errors, task killed, known causes, config changes), occurrences over time, root causes (deepest exception of each record), files with findings, and every distinct record. Everything below the filter bar is one view of the same records: the level chips, the component chips, the connector picker, the search box and the period selected by dragging over the occurrences chart (all kept in the URL: 🔗 Link to this view opens the report on the same view) all recount the two charts, the root causes, the files with findings and the record cards (double-click the chart, or ⤺ whole period, to go back). The findings keep the figures of the whole report, say how much of each of them is in the selection, and the ones with nothing in it are hidden (show them brings them back). With a connector picked, the 🔌 Connectors section keeps its card only.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-analyze-logs  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%95%B5%EF%B8%8F-a-connector-failed-read-the-logs-live-or-from-a-customer-bundle  
🎬 Bite size session (`--compare`): https://kafka-docker-playground.io/#/sessions?id=%F0%9F%94%81-did-the-fix-work-analyze-the-logs-before-and-after-it

## Usage

```bash
playground analyze logs [OPTIONS]
```

## Dependencies

#### *python3*

visit https://www.python.org/downloads/ to install

## Environment Variables

#### `PLAYGROUND_LOG_PARALLELISM`

⚡ Files digested at the same time, merged in the order of the input (default 4; 1: one at a time, with the progress bar of a large file)

#### `PLAYGROUND_CFK_PARALLELISM`

⚡ CFK support bundles analyzed at the same time, a container each (default 4)

#### `PLAYGROUND_LOG_RUNBOOKS_FILE`

🔒 JSON file with the internal runbooks of Confluent support (GTS Confluence pages, internal KB articles) by known cause, shown with a 🔒 next to the 📚 KB in the terminal summary, the HTML report and `--json` (known_causes[].internal_links), never in the summary for a ticket (default reproduction-models/_miscellaneous/log-analysis/runbooks-internal.json, format in tools/report-common/known_causes.py)

#### `PLAYGROUND_CFK_RUNBOOKS_FILE`

📕 CFK support bundle: JSON file with the internal runbook links of the known CFK issues, shown with a 🔒 in the terminal, the HTML report and `--json` (default reproduction-models/_miscellaneous/cfk-analysis/runbooks-internal.json, format in cfk-analysis/runbooks.py)

## Options

#### `--file, -f FILE`

🗒️  Log file, folder, .zip, .tar(.gz|.bz2|.xz), .7z or .gz file to analyze

🎓 Tip: can be set several times. TAB lists the log files, exports, archives and folders of Downloads, Desktop and the current folder, newest first

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--compare BEFORE`

🔁 Compare with another input: the logs before a fix, another worker, the day before. A log file, folder or archive  
(analyzed with the same `--connector`, `--with-worker`, `--errors-only` and `--sanitize`), or a JSON written by `--json`

The report says what is new, gone, growing or shrinking: root causes, known causes, connectors and the totals by level  
(per hour when the two inputs cover different periods), in a 🔁 Comparison section, the terminal summary and  
.comparison of `--json`

🎓 Tip: can be set several times, oldest first (-f day3 `--compare` day1 `--compare` day2): the comparison is with the last  
one, and a 📈 Trend gives the totals and the main root causes of every input in order (.trend of `--json`)

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--sample, -s SAMPLE`

🧪 Sample of tools/log-analyzer/samples and cfk-analysis/samples

- **connect_task_failure**: Connect worker log: Oracle XStream connector with a wrong password, an unknown outbound server, and a task failing after the outbound server was stopped
- **support_bundle**: .zip with that log and a gzipped broker log
- **kafka_streams**: logs of the 3 instances of other/kafka-streams (serde-errors.sh): an application in ERROR after a poison pill, its dead stream thread, deserialization and production handler errors, the 🌊 Kafka Streams section (state, rebalances, tasks, timeline)
- **compare_fix**: the log of a Connect worker the day after a fix, compared with the day before (`--compare`): errors gone, a new one, rebalances growing
- **kafka_clients**: logs of the non-Java clients (C/C++, Python, Go, .NET, JavaScript, KafkaJS, Rust) of other/client-\*: a broker that refuses connections or does not resolve, records timed out, an unknown property, and crashes (Python traceback, .NET unhandled exception, Go and Rust panics, uncaught Node.js error)
- **cfk_bundle**: CFK support bundle: kafka-2 crash-looping on an expired certificate, pending volume, OOMKilled Connect pod, failed connector task, Schema Registry authentication failure, operator reconcile errors
- **cfk_kraft_migration**: CFK support bundle: ZooKeeper to KRaft migration (KRaftMigrationJob) stuck for 3 days in SETUP, the KRaftController missing inter replication credentials
- **cfk_rollout**: CFK support bundle: CP upgrade half done (KRaftController still blocked, Kafka roll stuck at 2/3), operator pod refused by the ResourceQuota, stale "Reconcile is blocked" conditions, operator log that starts after the last change
- **cfk_rollout_after**: the same cluster the next day (quota raised, KRaftController unblocked, roll complete): `--sample` cfk_rollout `--sample` cfk_rollout_after compares the two

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Allowed Values: | `connect_task_failure`, `support_bundle`, `kafka_streams`, `kafka_clients`, `compare_fix`, `cfk_bundle`, `cfk_kraft_migration`, `cfk_rollout`, `cfk_rollout_after`

#### `--errors-only`

🔴 Only the ERROR/FATAL records: the WARN records are reported by default (the Kafka clients log some real problems at WARN: consumer poll timeout, records expiring in the producer, network errors), sorted after the errors

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--include-warnings`

#### `--include-warnings`

🟠 Kept for compatibility: the WARN records are reported by default (`--errors-only` to leave them out). With a CFK support bundle, also the WARN log records that match no known category

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--errors-only`

#### `--max-findings MAX_FINDINGS`

✂️ Maximum number of distinct records to show per file (default 40). The HTML report and `--json` have them all

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `40`

#### `--since SINCE`

⏱️ Only the lines logged at or after this time: "2026-11-06 10:00", "2026-11-06T10:00:00" or "2026-11-06". The times  
are compared as written in the logs; a line without its own time (a stack frame) follows the line before it. The  
line numbers of the digest and of the report stay those of the files

#### `--until UNTIL`

⏱️ Only the lines logged before this time (same formats as `--since`)

#### `--output-dir, -o OUTPUT_DIR`

📂 Output directory for the HTML report (default: ./log-analysis-output), with a `<report>`-files/ folder next to it: a page per file with findings, which the file names and line numbers of the report open (✏️ in the editor of playground config editor)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `./log-analysis-output`

#### `--json`

🗂️  Output JSON on stdout: summary, findings, root causes and every distinct record (text digest on stderr, no HTML report)

"type": "logs", with the analysis of each CFK support bundle found in "cfk_bundles"; "type": "cfk-bundle" (issues with their recommendation, environment, timeline) when the input is one CFK bundle

#### `--logs-only`

📜 Do not detect CFK support bundles: only the regular log report, of every file of the bundle (by default, the log report of its pod and operator logs has the ☸️ sections of the bundle: pods, custom resources, events, versions, recent changes)

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

🗂️ With `--json`, only these sections, comma separated: summary, findings, known_causes, root_causes, files, files_without_findings, coverage, configuration, timeline, connectors, comparison, trend, lifecycle, config_lint, other_files, fixed_bugs, task_workers, data_to_request, config_drift (default: all). For example `--json-sections` summary,findings,root_causes

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

#### `--problem, -p PROBLEM`

🎯 CFK support bundle: the problem the customer reports, in your own words: component, symptom and since when (example: "connect-0 keeps restarting since 14 Oct 08:30, orders-sink failed")

Matched against the bundle (keywords and dates, no AI): the components and CR / pod names (connect, kafka, kraft, schema registry, operator, connect-0…), the symptoms (roll / upgrade stuck, crash / restarts, pending, memory / OOM, TLS, auth / RBAC, KRaft migration, connector failed, slow / lag / hang, disk, network) and the dates it recognizes (2026-10-14 08:30, 14 Oct, Oct 14, yesterday, 3 hours ago). The issues that match come first, marked 🎯, with a verdict: explained, partly explained, not explained, or not covered (the logs of the bundle do not cover the date), the changes of the CRs before the date and the logs that start after it. Terminal, HTML report and "problem" in `--json`. It also adds what to request for these symptoms to the 📥 Data to request section

#### `--sanitize`

🔒 Replace passwords and other secrets, IPs, hostnames, emails and LDAP DNs by placeholders (`<REDACTED>`, `<IP-1>`, `<HOST-1>`…) in the digest, the HTML report, the JSON and the CFK bundle analysis

⚠️ Use it before sharing the output outside Confluent (best effort: review it anyway). Off by default: it can hide evidence (a dump of bytes taken for a secret, the IP of the broker) and doubles the time on large bundles

## Examples

```bash
playground analyze logs --sample connect_task_failure
```

```bash
playground analyze logs --sample support_bundle
```

```bash
playground analyze logs --file connect.log
```

```bash
playground analyze logs --file connect-logs.zip --errors-only
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
playground analyze logs --sample cfk_kraft_migration
```

```bash
playground analyze logs --sample cfk_rollout
```

```bash
playground analyze logs --sample cfk_rollout --sample cfk_rollout_after
```

```bash
playground analyze logs --sample cfk_bundle --problem "connect-0 keeps restarting since 14 Oct 08:30, orders-sink failed"
```

```bash
playground analyze logs -f ./support-bundle-ns-confluent.tar.gz -p "kafka roll stuck after the upgrade yesterday"
```

```bash
playground analyze logs -f bundle-monday.tar.gz -f bundle-tuesday.tar.gz
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
17:23:19 ℹ️ 🔓 Not sanitized: --sanitize replaces secrets, IPs and hostnames by placeholders before sharing the output outside Confluent
17:23:19 ℹ️ 🔥 ERROR/FATAL digest for connect.log
🔎 1 distinct record(s), 2 occurrence(s), in 12 lines

🔴 ERROR x2 (first seen line 2, last seen line 10)
[2026-10-13 10:00:05,123] ERROR [http-sink|task-0] WorkerSinkTask{id=http-sink-0} Task threw an uncaught and unrecoverable exception. Task is being killed and will not recover until manually restarted (org.apache.kafka.connect.runtime.WorkerTask:234)
    org.apache.kafka.connect.errors.ConnectException: Exiting WorkerSinkTask due to unrecoverable exception.
    Caused by: org.apache.kafka.connect.errors.ConnectException: Error while processing HTTP request with Url : http://httpserver:9006/api/messages, Status code : 500
        at io.confluent.connect.http.writer.HttpWriterImpl.handleErrors(HttpWriterImpl.java:405)

17:23:19 ℹ️ 📊 1 file(s) with findings out of 1 scanned (binary files skipped: 0)
17:23:19 ℹ️ ✅ HTML report saved: /home/me/log-analysis-output/connect-log-report.html
17:23:19 ℹ️ 🔗 Open in browser: file:///home/me/log-analysis-output/connect-log-report.html
```


