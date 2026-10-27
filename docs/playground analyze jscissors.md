# playground analyze jscissors

✂️ Analyze a jscissors trace: what the traced methods did, call by call

Reads the folder copied by playground debug jscissors `--action` stop (it runs this command itself, unless `--no-analyze`), a pid-`<pid>` folder of it, or its events.jsonl.

📊 The methods by total time (calls, average, p95, max, self time and exceptions: exact, counted by the agent for every call), the exceptions thrown by the traced methods with their stack trace and the arguments of a failing call, the calls still running when the trace stopped (a hang), the slowest calls with their arguments and return values, the call trees of each thread, the thread and heap dumps taken (with the command to analyze them), and findings with next steps (no class matched the rules, limits reached, agent errors...).

🌐 Also writes a self-contained HTML report in `--output-dir`, opened in the browser in an interactive terminal

🧪 With `--sample`, it analyzes a trace shipped in tools/jscissors/samples: a quick way to see what it reports.

🔖 Exit code is 0 when the analysis completed, 2 when the folder holds no trace

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-jvm-diagnostics  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%E2%9C%82%EF%B8%8F-records-vanish-a-task-hangs-what-does-the-code-do

## Usage

```bash
playground analyze jscissors [OPTIONS]
```

## Options

#### `--file, -f FILE`

📂 Trace folder copied by playground debug jscissors `--action` stop (jscissors-`<container>`-`<date>`), a pid-`<pid>` folder of it, or its events.jsonl

❕ Provide only one of `--file` and `--sample`

#### `--sample, -s SAMPLE`

🧪 Sample of tools/jscissors/samples

- **filestream_sink_bad_json**: FileStream sink with errors.tolerance=all, records that are not JSON: the conversion of each record, the DataException of the bad ones (with their content), the batches written

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `filestream_sink_bad_json`

#### `--output-dir, -o OUTPUT_DIR`

📂 Output directory for the HTML report (default: ./jscissors-analysis-output)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `./jscissors-analysis-output`

#### `--json`

🗂️  Output JSON (no text report, no HTML report)

#### `--top TOP`

📊 Number of rows per section (default: 15)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `15`

## Examples

```bash
playground analyze jscissors --sample filestream_sink_bad_json
```

```bash
playground analyze jscissors -f jscissors-connect-2026-10-25-10-12-00
```

```bash
playground analyze jscissors -f jscissors-connect-2026-10-25-10-12-00 --json
```


