# playground debug gc-analyze

📈 Analyze JVM Garbage Collection logs  
  
📊 Parses GC logs from a local file or running container and generates a detailed analysis with pause time statistics, heap trends, GC cause breakdown, and concrete tuning recommendations.  
  
🔖 Supports JDK 7–21+ and all major collectors: G1GC, CMS, ZGC, Generational ZGC, Shenandoah, ParallelGC, SerialGC  
  
🔖 Use --html to generate a self-contained HTML dashboard with interactive Chart.js charts

## Usage

```bash
playground debug gc-analyze [OPTIONS]
```

## Options

#### *--file, -f FILE*

🗒️  GC log file to analyze  
  
❕ Provide either --file or --container, not both  
  
🎓 Tip: use \<tab\> completion to trigger fzf completion  
        use \<option+enter\> to use the value you typed manually

#### *--container, -c CONTAINER*

🐳 Container name to extract GC log from  
  
❕ Provide either --file or --container, not both  
  
🔖 The GC log path is auto-detected from the container's Java process flags.  
     Falls back to searching common log locations (/tmp, /var/log, /opt).

#### *--output-dir, -o OUTPUT_DIR*

📂 Output directory for the HTML report (default: ./gc-analysis-output)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | ./gc-analysis-output

#### *--html*

🌐 Generate a self-contained HTML report with interactive charts  
  
📊 Report includes: pause timeline, heap evolution, pause distribution,  
   GC type breakdown, KPI cards, detected JVM parameters, tuning flags,  
   and color-coded recommendations

#### *--json*

🗂️  Output raw JSON stats (skips text report and HTML)

#### *--top-pauses TOP_PAUSES*

📊 Number of longest pauses to display in the report (default: 10)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 10

## Examples

```bash
playground debug gc-analyze --file gc.log
```

```bash
playground debug gc-analyze --file /var/log/kafka/kafkaServer-gc.log --html
```

```bash
playground debug gc-analyze --container broker
```

```bash
playground debug gc-analyze --container connect --html --output-dir ./gc-reports
```

```bash
playground debug gc-analyze -f kafkaServer-gc.log --json
```

```bash
playground debug gc-analyze -f kafkaServer-gc.log --html --top-pauses 20
```


