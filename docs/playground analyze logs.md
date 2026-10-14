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
fly, binary files are skipped. Only files with findings are shown.

## Usage

```bash
playground analyze logs [OPTIONS]
```

## Options

#### `--file, -f FILE`

🗒️  Log file, folder, .zip, .tar(.gz) or .gz file to analyze

🎓 Tip: can be set several times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--sample, -s SAMPLE`

🧪 Sample of tools/log-analyzer/samples

- **connect_task_failure**: Connect worker log: Oracle XStream connector with a wrong password, an unknown outbound server, and a task failing after the outbound server was stopped
- **support_bundle**: .zip with that log and a gzipped broker log

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Allowed Values: | `connect_task_failure`, `support_bundle`

#### `--include-warnings`

🟠 Also report WARN records

#### `--max-findings MAX_FINDINGS`

✂️ Maximum number of distinct records to show per file (default 40)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `40`

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
```


