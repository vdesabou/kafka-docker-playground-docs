# playground analyze watch

👀 Watch a folder (default: ~/Downloads) and analyze every new log file, bundle, dump, capture or report, report opened in the browser

Leave it running in a terminal: when a log file, a support bundle or a  
folder of logs lands in the folder (a download from Zendesk, Slack, a  
browser, Finder), it is analyzed as soon as it is complete, and its  
HTML report opens in the browser, with a macOS notification.

⏳ A download is complete once its size stops changing and the browser  
has renamed it: .crdownload, .download, .part, .partial and .tmp  
entries are waited for, never analyzed.

🔎 "Holds logs" is checked without extracting anything: a .log / .out  
file (also rotated, .log.1, and gzipped), a .txt, .json, .csv or  
extension-less file whose first lines look like log records (a  
timestamp and a level, librdkafka lines, JSON records with a level),  
an archive (.zip, .tar, .tar.gz, .tgz, .tar.bz2, .tar.xz, .7z) or a  
folder that contains such files. Pictures, PDFs, installers and other  
files are ignored (logged once).

🧰 The other files support asks for get their own analyzer (unless  
`--logs-only`), recognized as in the 🧰 Other files of 'analyze logs':  
a heap dump (analyze heap-dump), a flight recording (analyze  
flight-recorder), a network capture (analyze tcp-dump), an Oracle  
XStream diagnostics report (analyze oracle-xstream-report), a GC log  
(analyze gc-logs), a thread dump (analyze thread-dump; a log file  
holding a kill -3 thread dump stays a log file: analyze logs analyzes  
the dump in its report). In an archive or a folder, 'analyze logs'  
runs first when it holds logs (thread dumps analyzed in its report),  
then the analyzer of each other kind of file, one report each; one  
holding only dumps or captures gets their reports only.

⏭️ What Safari or Archive Utility extracts next to an archive or a  
compressed file already analyzed (x.zip → x/, x.hprof.gz → x.hprof  
or x.hprof/) is not analyzed again.

Only the entries that appear after the start are analyzed, at the  
top of the folder (a file moved into a sub-folder never is): `--since`  
also picks the ones created in the last minutes (creation time, so  
that a folder you move files into, ~/Downloads/Archives, is not  
picked), `--once` analyzes those and exits instead of watching.  
🚫 `--exclude` never analyzes an entry, even renamed or re-created. Each report is written in its  
own folder of `--output-dir`, named after the entry (outside the  
watched folder, so that a report never triggers an analysis).

🔁 macOS: `--install-launch-agent` starts the watch at every login (a  
LaunchAgent, restarted if it stops) with the flags given, so that you  
never have to start it; `--uninstall-launch-agent` removes it.

🔒 Downloads are untrusted data: they are only read, never run.  
Stop with Ctrl-C.

## Usage

```bash
playground analyze watch [OPTIONS]
```

## Dependencies

#### *python3*

visit https://www.python.org/downloads/ to install

## Options

#### `--folder FOLDER`

📂 Folder to watch (default: ~/Downloads)

#### `--output-dir, -o OUTPUT_DIR`

📂 Folder of the reports, one sub-folder per analyzed entry (default: ~/playground-log-reports)

#### `--since MINUTES`

🕐 Also analyze the entries created in the last `<minutes>` minutes when the watch starts (default: 0, only new entries)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `0`

#### `--exclude NAME`

🚫 Name of an entry of the folder never analyzed, wildcards allowed (for example Archives, or "\*.dmg")

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--once`

1️⃣ Analyze the entries of `--since` and exit, without watching

#### `--interval SECONDS`

⏱️ Seconds between two checks of the folder (default: 3)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `3`

#### `--no-open`

🙈 Do not open the reports in the browser (their path is still logged)

#### `--analyze-logs-args ANALYZE_LOGS_ARGS`

➕ Extra flags passed to every `playground analyze logs` call, as one string (for example "`--errors-only` `--sanitize`")

#### `--logs-only`

🔥 Only run `playground analyze logs` (on files holding logs), never the analyzers of heap dumps, flight recordings, captures, XStream reports, GC logs and thread dumps

#### `--install-launch-agent`

🔁 macOS: install a LaunchAgent that starts this watch (with `--folder`, `--output-dir`, `--exclude`, `--interval`, `--no-open`, `--logs-only`, `--analyze-logs-args`) at every login, output in ~/Library/Logs/playground-analyze-watch.log

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--uninstall-launch-agent`, `--once`

#### `--uninstall-launch-agent`

🗑️ macOS: remove the LaunchAgent of `--install-launch-agent`

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--install-launch-agent`

## Examples

```bash
playground analyze watch
```

```bash
playground analyze watch --exclude Archives --install-launch-agent
```

```bash
playground analyze watch --uninstall-launch-agent
```

```bash
playground analyze watch --since 30 --exclude Archives
```

```bash
playground analyze watch --since 120 --once
```

```bash
playground analyze watch --folder ~/Desktop/cases --output-dir /tmp/log-reports
```

```bash
playground analyze watch --analyze-logs-args "--errors-only --max-findings 20"
```


