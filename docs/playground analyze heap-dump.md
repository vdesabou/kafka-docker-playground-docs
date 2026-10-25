# playground analyze heap-dump

🔬 Analyze a heap dump with Eclipse Memory Analyzer (MAT), run headless in Docker

🕵️ Prints a text digest: heap overview, MAT leak suspects (accumulation point and who holds it) and the top retained sizes by class (dominator tree), and saves the MAT HTML reports (Leak_Suspects, System_Overview, Top_Components) in `--output-dir`

📈 Use `--compare` with a second dump of the same JVM, taken later under the same load, to see which classes grow

🐳 MAT needs roughly as much memory as the used heap of the dump (1 to 1.5x the .hprof size): give Docker enough memory or use `--max-memory`

🧪 With `--sample`, it analyzes the samples shipped in tools/heap-analyzer/samples: a quick way to see what it reports.

🔖 Exit code is 0 when the analysis completed, non-zero when MAT could not parse the dump (truncated file, out of memory): never a "healthy" verdict on a failed parse

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-jvm-diagnostics

## Usage

```bash
playground analyze heap-dump [OPTIONS]
```

## Options

#### `--file, -f FILE`

🔖 Heap dump to analyze (.hprof, or .hprof.gz as written by jcmd GC.heap_dump -gz)

🎓 Tip: use `<tab>` completion to trigger fzf completion  
use `<option+enter>` to use the value you typed manually

#### `--sample, -s SAMPLE`

🧪 Sample of tools/heap-analyzer/samples

- **leak**: heap dump of a JVM with a session cache that is never evicted (MAT leak suspect)
- **leak_growth**: two dumps of that JVM a few seconds apart: the later one is compared with the earlier one

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `leak`, `leak_growth`

#### `--output-dir, -o OUTPUT_DIR`

📂 Output directory for the digest (summary.txt), the MAT HTML reports and mat.log (default: ./heap-analysis)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `./heap-analysis`

#### `--report-type, -r REPORT_TYPE`

📋 MAT HTML report(s) to generate (the text digest is always printed)

- all: the three reports below
- leaks: leak suspects (org.eclipse.mat.api:suspects)
- overview: system overview (org.eclipse.mat.api:overview)
- top-components: top components per class loader (org.eclipse.mat.api:top_components)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `all`
| Allowed Values: | `all`, `leaks`, `overview`, `top-components`

#### `--max-memory MAX_MEMORY`

🧠 Java heap given to MAT, e.g. 8g (default: 80% of the Docker memory)

#### `--compare FILE`

📈 Second heap dump of the same JVM, taken later: prints the classes whose instance count and shallow size grew

## Examples

```bash
playground analyze heap-dump --sample leak
```

```bash
playground analyze heap-dump --sample leak_growth
```

```bash
playground analyze heap-dump --file heap-dump-connect-2026-04-08.hprof
```

```bash
playground analyze heap-dump -f heap-dump-broker.hprof --output-dir ./analysis
```

```bash
playground analyze heap-dump -f heap-dump-connect.hprof --report-type leaks
```

```bash
playground analyze heap-dump -f heap-1.hprof --compare heap-2.hprof
```

```bash
playground analyze heap-dump -f big-heap-dump.hprof --max-memory 12g
```


