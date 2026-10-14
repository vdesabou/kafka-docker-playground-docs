# playground analyze thread-dump

🧵 Analyze java thread dumps: deadlocks, lock contention, stuck and CPU-hungry threads

📊 Reads jstack / jcmd Thread.print / kill -3 output (JDK 8 to 25), several dumps per file and container logs included, and reports: thread states and pools, deadlocks, locks with their owner and waiters, the most common stacks, and with several dumps of the same JVM: threads stuck on the same frames, the CPU used by each thread between dumps, and growing thread pools. Kafka / Connect aware (task threads, herder, broker request handlers).

🐳 With `--container` (default: connect), it takes `--count` dumps `--interval` seconds apart with kill -3: the JVM prints them to the container logs, no JDK is needed in the image.

🌐 Also writes a self-contained HTML report (inline SVG charts, works offline) in `--output-dir`, opened in the browser in an interactive terminal

🧪 With `--sample`, it analyzes the samples shipped in tools/thread-analyzer/samples: a quick way to see what it reports.

🔖 Exit code is 0 when the analysis completed, 2 when no thread dump was found

## Usage

```bash
playground analyze thread-dump [OPTIONS]
```

## Options

#### `--file, -f FILE`

🗒️  Thread dump file or folder (repeat `--file` for several dumps of the same JVM)

❕ Provide only one of `--file`, `--container` and `--sample`

🎓 Tip: use `<tab>` completion to trigger fzf completion  
use `<option+enter>` to use the value you typed manually

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--sample, -s SAMPLE`

🧪 Sample of tools/thread-analyzer/samples

- **deadlock_jdk21**: 3 jstack -l dumps of one JDK 21 JVM, 3 s apart: deadlock, blocked threads, CPU-hot thread, stuck task, leaking pool
- **deadlock_jdk8**: the same scenario, one dump, JDK 8
- **healthy_connect**: 3 kill -3 dumps of a healthy CP 8.3.2 Connect worker, from its container logs

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Allowed Values: | `deadlock_jdk21`, `deadlock_jdk8`, `healthy_connect`

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

#### `--json`

🗂️  Output JSON (no text report, no HTML report)

#### `--top TOP`

📊 Number of rows per section (default: 10)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `10`

## Examples

```bash
playground analyze thread-dump --sample deadlock_jdk21
```

```bash
playground analyze thread-dump
```

```bash
playground analyze thread-dump -c broker --count 5 --interval 2
```

```bash
playground analyze thread-dump --file thread-dump-connect-2026-10-13.log
```

```bash
playground analyze thread-dump -f dump1.txt -f dump2.txt -f dump3.txt
```

```bash
playground analyze thread-dump -f ./customer-logs/connect-stdout.log
```

```bash
playground analyze thread-dump -c connect --json
```


