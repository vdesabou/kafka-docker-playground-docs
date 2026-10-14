# playground analyze gc-logs

📈 Analyze JVM Garbage Collection logs

📊 Parses GC logs from local files / folders or a running container: pause statistics, Full GC and evacuation / concurrent mode failures, live set, heap floor trend (leak), allocation stalls, GC causes, and recommendations backed by a finding (Kafka-aware: compared with Kafka's own G1 settings).

🔖 Supports JDK 7–21+ and all major collectors: G1GC, CMS, ZGC, Generational ZGC, Shenandoah, ParallelGC, SerialGC, in legacy (`-XX:+PrintGCDetails`) and unified (`-Xlog:gc*`) formats, any decoration

🔄 Pass every rotated file (kafkaServer-gc.log, .log.0…, .gz) or their folder: files are ordered by timestamp and split by JVM restart, the latest run is analyzed (`--run` to pick another)

🧪 With `--sample`, it analyzes the samples shipped in gc-analysis/samples: a quick way to see what it reports.

🔖 Exit code is 0 when the analysis completed, 2 when no GC event was found

🌐 Also writes a self-contained HTML dashboard (pause timeline, heap before / after GC, pause distribution, KPI cards, recommendations; no external resource) in `--output-dir`, opened in the browser in an interactive terminal

## Usage

```bash
playground analyze gc-logs [OPTIONS]
```

## Options

#### `--file, -f FILE`

🗒️  GC log file or folder to analyze (repeat `--file` for the rotated files of the same JVM)

❕ Provide only one of `--file`, `--container` and `--sample`

🎓 Tip: use `<tab>` completion to trigger fzf completion  
use `<option+enter>` to use the value you typed manually

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--sample, -s SAMPLE`

🧪 Sample of gc-analysis/samples (repeat `--sample` to analyze several)

GC logs of JDK 7 to 21 and every collector, named `<jdk>`_`<collector>`[_real]  
(_real: taken from a real Kafka / Connect JVM)

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Allowed Values: | `jdk7_parallel`, `jdk8_cms`, `jdk8_cms_cmf_real`, `jdk8_g1gc`, `jdk8_g1gc_details_real`, `jdk11_zgc`, `jdk17_g1gc`, `jdk17_shenandoah`, `jdk21_g1_kafka_real`, `jdk21_genzgc`, `jdk21_genzgc_real`

#### `--container, -c, --pod, -p CONTAINER`

🐳 Container name (or pod name when cfk environment is used) to extract the GC log from

❕ Provide only one of `--file`, `--container` and `--sample`

🔖 The GC log path is read from the java command line (`-Xlog:gc*:file=`… or `-Xloggc:`…), and its rotated files are copied too.  
Falls back to searching common log locations (/var/log, /tmp, /opt).  
The playground environments write a GC log for ZooKeeper, brokers, controllers, Schema Registry,  
Connect (-loggc, /var/log/kafka/`<name>`-gc.log) and ksqlDB.

#### `--output-dir, -o OUTPUT_DIR`

📂 Output directory for the HTML report and the GC logs copied from a container (default: ./gc-analysis-output)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `./gc-analysis-output`

#### `--json`

🗂️  Output JSON stats (no text report, no HTML report)

#### `--run RUN`

🔄 JVM run to analyze when the log spans restarts (default: the latest, see the "JVM runs" table)

#### `--top-pauses TOP_PAUSES`

📊 Number of longest pauses to display in the report (default: 10)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `10`

## Examples

```bash
playground analyze gc-logs --sample jdk21_g1_kafka_real
```

```bash
playground analyze gc-logs --sample jdk8_cms_cmf_real
```

```bash
playground analyze gc-logs --file gc.log
```

```bash
playground analyze gc-logs --file /var/log/kafka/kafkaServer-gc.log
```

```bash
playground analyze gc-logs -f gc.log -f gc.log.0 -f gc.log.1
```

```bash
playground analyze gc-logs --file ./customer-logs/broker-1/
```

```bash
playground analyze gc-logs --container broker
```

```bash
playground analyze gc-logs --container broker --output-dir ./gc-reports
```

```bash
playground analyze gc-logs -f kafkaServer-gc.log --json
```

```bash
playground analyze gc-logs -f kafkaServer-gc.log --run 1 --top-pauses 20
```


