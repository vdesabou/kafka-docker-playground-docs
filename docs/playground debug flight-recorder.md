# playground debug flight-recorder

🛩️ Record a JVM with Java Flight Recorder, from `--action` start to `--action` stop

For a window of any length, in a script or by hand: start, reproduce the problem, stop. `--action` stop copies the  
.jfr to `--output-dir` and analyzes it with playground analyze flight-recorder (where the time of the connector tasks  
goes: states, CPU by layer, hot methods, allocation, locks, GC, findings), unless `--no-analyze`. Open it with JDK  
Mission Control (https://jdk.java.net/jmc/) for the details. To record for a fixed time and analyze in one  
command: playground analyze flight-recorder -c `<container>` `--duration` 2m.

🔌 The recording is driven over JMX (FlightRecorderMXBean) when the container has a JMX port (`KAFKA_JMX_PORT`, `SCHEMA_REGISTRY_JMX_PORT`...), as in the  
playground environments: the cp images ship a JRE without jcmd, and nothing is installed or restarted. Otherwise  
(cfk pods), jcmd is used when the image has it.

⚙️ `--settings` playground (default) records what the analysis needs with a low overhead  
(tools/jfr-analyzer/playground.jfc); profile and default are the settings of the JDK; all records every event  
with no threshold (scripts/cli/all.jfc), for a deep dive in JDK Mission Control, with a high overhead.

🔖 The recording of each container is kept in playground.ini (flight_recorder.`<container>`), `--action` status shows it.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-jvm-diagnostics  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%9B%A9%EF%B8%8F-a-slow-connector-where-does-the-task-time-go

## Usage

```bash
playground debug flight-recorder [OPTIONS]
```

## Options

#### `--container, -c, --pod, -p CONTAINER`

🐳 container name (or pod name when cfk environment is used)

🎓 Tip: you can pass multiple containers by specifying `--container` multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | `connect`

#### `--action ACTION`

🟢 start, stop (copy the recording and analyze it) or status

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes
| Allowed Values: | `start`, `stop`, `status`

#### `--settings SETTINGS`

⚙️ Settings of the recording, used by `--action` start (default: playground)

- `playground`: what playground analyze flight-recorder needs, low overhead (tools/jfr-analyzer/playground.jfc)
- **profile**: settings of the JDK for profiling, about 2% overhead
- **default**: settings of the JDK for continuous recording, about 1% overhead
- **all**: every event, no threshold (scripts/cli/all.jfc): high overhead, for JDK Mission Control

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `playground`
| Allowed Values: | `playground`, `profile`, `default`, `all`

#### `--output-dir, -o OUTPUT_DIR`

📂 Folder for the .jfr and the HTML report of the analysis, used by `--action` stop (default: current folder)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `.`

#### `--no-analyze`

🙈 With `--action` stop, only copy the recording, do not analyze it

## Examples

```bash
playground debug flight-recorder --action start
```

```bash
playground debug flight-recorder --action stop
```

```bash
playground debug flight-recorder --action status
```

```bash
playground debug flight-recorder -c connect -c connect2 --action start --settings profile
```

```bash
playground debug flight-recorder --action stop --output-dir /tmp/jfr --no-analyze
```


