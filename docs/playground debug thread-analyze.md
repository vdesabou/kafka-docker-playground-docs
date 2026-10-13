# playground debug thread-analyze

🧵 Analyze java thread dumps: deadlocks, lock contention, stuck and CPU-hungry threads

📊 Reads jstack / jcmd Thread.print / kill -3 output (JDK 8 to 25), several dumps per file and container logs included, and reports: thread states and pools, deadlocks, locks with their owner and waiters, the most common stacks, and with several dumps of the same JVM: threads stuck on the same frames, the CPU used by each thread between dumps, and growing thread pools. Kafka / Connect aware (task threads, herder, broker request handlers).

🐳 With `--container` (default: connect), it takes `--count` dumps `--interval` seconds apart with kill -3: the JVM prints them to the container logs, no JDK is needed in the image.

🔖 Use `--html` to generate a self-contained HTML report

🔖 Exit code is 0 when the analysis completed, 2 when no thread dump was found

## Usage

```bash
playground debug thread-analyze [OPTIONS]
```

## Options

#### `--file, -f FILE`

🗒️  Thread dump file or folder (repeat `--file` for several dumps of the same JVM)

❕ Provide either `--file` or `--container`, not both

🎓 Tip: use `<tab>` completion to trigger fzf completion  
use `<option+enter>` to use the value you typed manually

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--container, -c, --pod, -p CONTAINER`

🐳 Container name (or pod name when cfk environment is used) to take the thread dumps from (default: connect)

#### `--count COUNT`

🔢 Number of thread dumps to take with `--container` (default: 3)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `3`

#### `--interval INTERVAL`

⏱️  Seconds between two thread dumps with `--container` (default: 5)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `5`

#### `--output-dir, -o OUTPUT_DIR`

📂 Output directory for the thread dumps taken from a container and the HTML report (default: ./thread-analysis-output)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `./thread-analysis-output`

#### `--html`

🌐 Generate a self-contained HTML report (inline SVG charts, works offline)

#### `--json`

🗂️  Output JSON (skips the text report and the HTML)

#### `--top TOP`

📊 Number of rows per section (default: 10)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `10`

## Examples

```bash
playground debug thread-analyze
```

```bash
playground debug thread-analyze --container broker --count 5 --interval 2 --html
```

```bash
playground debug thread-analyze --file thread-dump-connect-2026-10-13.log
```

```bash
playground debug thread-analyze -f dump1.txt -f dump2.txt -f dump3.txt --html
```

```bash
playground debug thread-analyze -f ./customer-logs/connect-stdout.log
```

```bash
playground debug thread-analyze -c connect --json
```


