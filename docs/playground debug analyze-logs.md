# playground debug analyze-logs

🔥 Show a digest of ERROR/FATAL records found in log files, folders or zip bundles  
  
The offline counterpart of 'playground container logs --errors', for  
logs that do not come from a running container: a customer support  
bundle, a CI artifact, a log file you were sent.  
  
Repeated records are de-duplicated with an occurrence count, stack  
traces are collapsed to the exception chain ("Caused by:") plus a few  
frames of the deepest cause. Records logged at INFO/DEBUG/TRACE are  
never reported.  
  
📂 Folders are scanned recursively. .zip, .tar, .tar.gz and .tgz files  
are extracted in a temporary folder, .gz files are decompressed on the  
fly, binary files are skipped. Only files with findings are shown.

## Usage

```bash
playground debug analyze-logs [OPTIONS]
```

## Options

#### *--file, -f FILE*

🗒️  Log file, folder, .zip, .tar(.gz) or .gz file to analyze  
  
🎓 Tip: can be set several times

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes
| Repeatable:     |  ✓ Yes

#### *--include-warnings*

🟠 Also report WARN records

#### *--max-findings MAX_FINDINGS*

✂️ Maximum number of distinct records to show per file (default 40)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 40

## Examples

```bash
playground debug analyze-logs --file connect.log
```

```bash
playground debug analyze-logs --file kafka-connect-logs-10-09-1200.zip --include-warnings
```

```bash
playground debug analyze-logs -f ./logs -f broker.log.gz --max-findings 10
```


