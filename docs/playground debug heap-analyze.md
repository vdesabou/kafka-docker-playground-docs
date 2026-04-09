# playground debug heap-analyze

🔬 Analyze a heap dump file using Eclipse MAT (Memory Analyzer Tool)  
  
📊 Generates automated leak suspects report, top components, and memory usage analysis  
  
🔖 Analyzes .hprof files and generates HTML/ZIP reports with insights

## Usage

```bash
playground debug heap-analyze [OPTIONS]
```

## Options

#### *--file, -f FILE*

📁 Path to the .hprof heap dump file to analyze

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--output-dir, -o OUTPUT_DIR*

📂 Output directory for analysis reports (default: ./heap-analysis)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | ./heap-analysis

#### *--report-type, -r REPORT_TYPE*

📋 Type of report to generate  
  
- all: Generate all available reports  
- leaks: Leak suspects report only  
- overview: System overview report  
- top-components: Top memory consumers

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | all
| Allowed Values: | all, leaks, overview, top-components

## Examples

```bash
playground debug heap-analyze --file heap-dump-connect-2026-04-08.hprof
```

```bash
playground debug heap-analyze -f heap-dump-broker.hprof --output-dir ./analysis
```

```bash
playground debug heap-analyze -f heap-dump-connect.hprof --report-type leaks
```


