# playground debug gc-analyze

📈 Analyze JVM Garbage Collection logs

📊 Parses GC logs from local files / folders or a running container: pause statistics, Full GC and evacuation / concurrent mode failures, live set, heap floor trend (leak), allocation stalls, GC causes, and recommendations backed by a finding (Kafka-aware: compared with Kafka's own G1 settings).

🔖 Supports JDK 7–21+ and all major collectors: G1GC, CMS, ZGC, Generational ZGC, Shenandoah, ParallelGC, SerialGC, in legacy (`-XX:+PrintGCDetails`) and unified (`-Xlog:gc*`) formats, any decoration

🔄 Pass every rotated file (kafkaServer-gc.log, .log.0…, .gz) or their folder: files are ordered by timestamp and split by JVM restart, the latest run is analyzed (`--run` to pick another)

🔖 Exit code is 0 when the analysis completed, 2 when no GC event was found

🔖 Use `--html` to generate a self-contained HTML dashboard (inline SVG charts, no external resource)

## Usage

```bash
playground debug gc-analyze [OPTIONS]
```

## Options

#### `--file, -f FILE`

🗒️  GC log file or folder to analyze (repeat `--file` for the rotated files of the same JVM)

❕ Provide either `--file` or `--container`, not both

🎓 Tip: use `<tab>` completion to trigger fzf completion  
use `<option+enter>` to use the value you typed manually

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--container, -c, --pod, -p CONTAINER`

🐳 Container name (or pod name when cfk environment is used) to extract the GC log from

❕ Provide either `--file` or `--container`, not both

🔖 The GC log path is read from the java command line (`-Xlog:gc*:file=`… or `-Xloggc:`…), and its rotated files are copied too.  
Falls back to searching common log locations (/var/log, /tmp, /opt).  
The playground environments write a GC log for ZooKeeper, brokers, controllers, Schema Registry,  
Connect (-loggc, /var/log/kafka/`<name>`-gc.log) and ksqlDB.

#### `--output-dir, -o OUTPUT_DIR`

📂 Output directory for the HTML report and the GC logs copied from a container (default: ./gc-analysis-output)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `./gc-analysis-output`

#### `--html`

🌐 Generate a self-contained HTML report (inline SVG charts, works offline)

📊 Report includes: pause timeline, heap before / after GC, pause distribution,  
GC types, KPI cards, JVM runs, recommendations with the flag to set

#### `--json`

🗂️  Output JSON stats (skips text report and HTML)

#### `--run RUN`

🔄 JVM run to analyze when the log spans restarts (default: the latest, see the "JVM runs" table)

#### `--top-pauses TOP_PAUSES`

📊 Number of longest pauses to display in the report (default: 10)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `10`

## Examples

```bash
playground debug gc-analyze --file gc.log
```

```bash
playground debug gc-analyze --file /var/log/kafka/kafkaServer-gc.log --html
```

```bash
playground debug gc-analyze --file kafkaServer-gc.log --file kafkaServer-gc.log.0 --file kafkaServer-gc.log.1
```

```bash
playground debug gc-analyze --file ./customer-logs/broker-1/
```

```bash
playground debug gc-analyze --container broker
```

```bash
playground debug gc-analyze --container broker --html --output-dir ./gc-reports
```

```bash
playground debug gc-analyze -f kafkaServer-gc.log --json
```

```bash
playground debug gc-analyze -f kafkaServer-gc.log --run 1 --top-pauses 20
```


