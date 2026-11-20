# playground flink ui

🌐 Open the Flink UI of the local Flink cluster in the browser

The web UI of the jobmanager, on the same port as its REST API (http://localhost:18081): running and finished jobs, the job graph, records in and out per operator, back pressure, checkpoints, exceptions, and the logs and metrics of the taskmanagers. `--job` opens the page of one job.

ℹ️ Control Center does not show this cluster: it handles Flink through Confluent Manager for Apache Flink (CMF) only, and the playground runs open source Flink.

☁️ Confluent Cloud: not supported, the statements are in the Confluent Cloud console.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-flink

## Usage

```bash
playground flink ui [OPTIONS]
```

## Options

#### `--job, -j JOB`

🆔 Id of the job whose page to open (see playground flink list-jobs)

#### `--no-open`

🙈 Do not open the HTML report in the browser (it is still written, and its path printed)

## Examples

```bash
playground flink ui
```

```bash
playground flink ui --job 6241bc76b798a992d369055943d70621
```

```bash
playground flink ui --no-open
```


