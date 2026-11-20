# playground repro pipeline-builder

🔗 Open the pipeline builder: pick a source and sink examples, see the flow, copy the bootstrap command

A self-contained HTML page with every connector example of connect/ and ccloud/fm-\*: pick the source (or a sink for a fan-out) and the sinks, and it shows the flow (source → topic → optional ksqlDB step → sinks), the topic the sinks will read, the converters, the credentials needed, and the same compatibility checks as 'repro bootstrap `--pipeline`' (Debezium envelope into a flat sink, a schemaless source into a sink that needs a schema, the same docker compose service or host port in two examples...). Then copy the ready-to-paste `playground repro bootstrap ... --pipeline ... --no-run` command. The selection is kept in the URL, to share it.

It only writes a command: nothing runs from the page.

🌐 Also on the website: https://kafka-docker-playground.io/pipeline-builder.html (commands with \$PWD)

## Usage

```bash
playground repro pipeline-builder [OPTIONS]
```

## Options

#### `--output-dir, -o OUTPUT_DIR`

📂 Output directory for the HTML report (default: /tmp/playground-`<command>`, printed at the end)

#### `--no-open`

🙈 Do not open the HTML report in the browser (it is still written, and its path printed)

## Examples

```bash
playground repro pipeline-builder
```

```bash
playground repro pipeline-builder --output-dir /tmp/pipeline --no-open
```


