# playground analyze oracle-xstream-report

🅾️ Analyze Oracle XStream CDC diagnostics reports (orclcdc_diag.sql)

📊 Reads the HTML report of the Confluent diagnostics script (the file support asks for, orclcdc_diag_`<date>`.html) and reports: prerequisites (archivelog, supplemental logging, streams_pool_size, `MAX_SGA_SIZE`), the state of the capture process (its position as a date, and whether it waits for redo it cannot read), LogMiner, outbound server, apply reader, buffered queue and streams pool with thresholds, open and long running transactions, overlapping capture rules, alerts and errors of the last 7 days, the findings sorted by severity with the report section and the exact values, and the matched root-cause patterns.

📈 Give several reports of the same database (repeat `--file`) to see what moved between them: captured SCN, messages captured, LCRs sent, latency, restarts.

🎯 Describe the problem with `--problem` ("no records since 11th of OCT"): the report is matched against it, the date where the capture stopped is compared with yours, and the findings that explain it come first.

🐳 With `--container` (default: oracle), it runs `playground connector oracle-cdc-xstream generate-report` on the running example first, and analyzes the result.

🧪 With `--sample`, it analyzes the reports shipped in tools/xstream-analyzer/samples: a quick way to see what it reports without an Oracle database.

🌐 Also writes a self-contained HTML report (findings, prerequisites, components, streams pool advice chart, deltas between reports) in `--output-dir`, to share in a case; opened in the browser in an interactive terminal

🔖 Exit code is 0 when the analysis completed, 2 when the file is not an orclcdc_diag report

👉 Check documentation https://docs.confluent.io/kafka-connectors/oracle-xstream-cdc-source/current/troubleshooting.html#connector-diagnostics-script

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-oracle-cdc  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%85%BE%EF%B8%8F-oracle-xstream-cdc-lags-or-is-idle

## Usage

```bash
playground analyze oracle-xstream-report [OPTIONS]
```

## Options

#### `--file, -f FILE`

🗒️  orclcdc_diag HTML report (repeat `--file` for several reports of the same database)

❕ Provide only one of `--file`, `--container` and `--sample`

🎓 Tip: use `<tab>` completion to trigger fzf completion  
use `<option+enter>` to use the value you typed manually

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--container, -c CONTAINER`

🐳 Oracle container of a running XStream example to generate the report from (default: oracle)

#### `--sample, -s SAMPLE`

🧪 Sample report of tools/xstream-analyzer/samples (repeat `--sample` to compare several)

- **healthy**: connector running, idle database
- **large_transaction**: uncommitted 150,000-row insert
- **detached**: connector deleted: outbound server DETACHED
- **older_script_version**: report of an older orclcdc_diag.sql
- **synthetic_failures**: NOARCHIVELOG, capture ABORTED, flow control, LogMiner memory, spills, alerts
- **missing_archived_log**: capture WAITING FOR REDO on an archived log it cannot read: nothing captured

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Allowed Values: | `healthy`, `large_transaction`, `detached`, `older_script_version`, `synthetic_failures`, `missing_archived_log`

#### `--problem, -p PROBLEM`

🎯 Problem statement, in your own words: symptom and since when (example: "no records processed since 11th of OCT")

The symptoms (no data, lag, missing data, duplicates, errors, memory) and dates it recognizes are matched against the report: capture position as a date, messages captured and LCRs sent, and the findings that explain it, most relevant first

#### `--output-dir, -o OUTPUT_DIR`

📂 Output directory for the report generated with `--container` and the HTML report (default: ./xstream-analysis-output)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `./xstream-analysis-output`

#### `--json`

🗂️  Output JSON (findings, prerequisites, summary per component, deltas between reports)

#### `--top TOP`

📊 Maximum number of rows per list: transactions, alerts, errors, tables (default: 10)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `10`

## Examples

```bash
playground analyze oracle-xstream-report --sample synthetic_failures
```

```bash
playground analyze oracle-xstream-report -s large_transaction -s detached
```

```bash
playground analyze oracle-xstream-report --sample large_transaction --json
```

```bash
playground analyze oracle-xstream-report -f orclcdc_diag_20261013_0912.html
```

```bash
playground analyze oracle-xstream-report -f day1.html -f day2.html
```

```bash
playground analyze oracle-xstream-report -f orclcdc_diag_20261013_1826.html --problem "no records processed since 11th of OCT"
```

```bash
playground analyze oracle-xstream-report --container oracle
```


