# playground debug jscissors

✂️ Trace the calls of any method of a running JVM: arguments, return values, durations, exceptions, call tree

A java agent (tools/jscissors/agent, byte-buddy) loaded in the JVM of the container instruments the methods matching `--class` and `--method`, and records every call with what the `--operation` flags ask for. For a window of any length: `--action` start, reproduce the problem, `--action` stop, which copies the trace to `--output-dir` and analyzes it with playground analyze jscissors (methods by total time, exceptions, calls still running, slowest calls, call trees, HTML report), unless `--no-analyze`. With `--duration`, start, wait and stop in one command.

💉 No restart: the agent is loaded in the running JVM with the attach protocol (what jcmd does, without jcmd, which the cp images do not have), or over JMX for a JDK older than 16. `--action` stop restores the original classes. Starting again replaces the rules. With `--restart`, the container is recreated with the agent in `JAVA_TOOL_OPTIONS`, to trace the startup of the JVM too (or when the JVM refuses the attach).

🎯 `--class` and `--method` are exact names, or java regular expressions as soon as they hold other characters than letters, digits, '.', '$' and '_' (io.confluent.connect.jdbc.\*, .\*[Ww]rite.\*). Only concrete methods are traced (trace the implementation class, not the interface), constructors and JDK classes (java.\*, javax.\*) are not. A class loaded after the start is instrumented when it loads.

🛡️ Safe by default: values are cut to `--max-value-length` and the secrets found in them are masked (passwords of maps, JAAS, connection strings), at most `--max-calls` calls (`--max-calls-per-method` per method) are recorded with their details (every call is counted in the statistics), or only the ones that throw (`--only-failed`) or are slow (`--slower-than`), at most 10 thread dumps and 1 heap dump, the agent can never throw in the traced code, and a toString() of an argument is never traced. Trace what you need: a regex matching thousands of hot methods slows the JVM down.

📂 In the trace folder (jscissors-`<container>`-`<date>`/pid-`<pid>`/): events.jsonl (one event per call enter / exit / dump), summary.json (statistics), agent.log, instrumented.txt, dumps/, and the HTML report.

🔖 The session of each container is kept in playground.ini (jscissors.`<container>`), `--action` status shows it with the calls so far. The agent jar is built from tools/jscissors/agent with maven in a container the first time (and after a change of its sources).

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-jvm-diagnostics  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%E2%9C%82%EF%B8%8F-records-vanish-a-task-hangs-what-does-the-code-do

## Usage

```bash
playground debug jscissors [OPTIONS]
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

🟢 start (default), stop (copy the trace and analyze it) or status

enable and disable are the former names of start and stop

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `start`
| Allowed Values: | `start`, `stop`, `status`, `enable`, `disable`

#### `--class CLASS`

🎯 Class to trace: exact name (io.confluent.connect.jdbc.sink.JdbcDbWriter, a nested class with $), or a regex (io.confluent.connect.jdbc.sink.\*)

🎓 Tip: you can pass multiple classes by specifying `--class` multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--method METHOD`

🎯 Method to trace, in each `--class`: exact name (write) or regex (.\*[Ww]rite.\*), default: every method

🎓 Tip: you can pass multiple methods by specifying `--method` multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | `.*`

#### `--operation OPERATION`

🥼 What to record on top of each call (its duration, its exception and its place in the call tree are always recorded):

- VALUES: arguments
- `RETURN_VALUE`: return value
- STACK: stack trace of the caller
- THREADS / `RETURN_THREADS` / `EXCEPTION_THREADS`: thread dump when the method is called / returns / throws
- HEAP / `RETURN_HEAP` / `EXCEPTION_HEAP`: heap dump when the method is called / returns / throws
- DELAY: duration (always recorded, kept for compatibility)

Default values: VALUES and `RETURN_VALUE`

🎓 Tip: you can pass multiple operations by specifying `--operation` multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | `VALUES`, `RETURN_VALUE`
| Allowed Values: | `VALUES`, `RETURN_VALUE`, `STACK`, `THREADS`, `RETURN_THREADS`, `EXCEPTION_THREADS`, `HEAP`, `RETURN_HEAP`, `EXCEPTION_HEAP`, `DELAY`

#### `--config-file CONFIG_FILE`

📜 Rules file, for different operations per class: one class{method}=OP+OP rule per line (io.confluent.connect.jdbc.sink.JdbcDbWriter{write}=VALUES+STACK), added to the rules of `--class`

#### `--duration DURATION`

⏱️ With `--action` start: trace for this long (in seconds, or with a s/m/h suffix), then stop and analyze

#### `--restart`

🔁 Load the agent at the start of the JVM: the container is recreated (and recreated again without the agent by `--action` stop). To trace the startup, or when the JVM refuses the attach

#### `--pid PID`

🔢 Process to attach to in the container (default: auto, the oldest java process)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `auto`

#### `--max-calls MAX_CALLS`

✂️ Calls recorded with their details in events.jsonl (default: 50000), the next ones are only counted in the statistics

#### `--max-calls-per-method MAX_CALLS_PER_METHOD`

✂️ Calls of one method recorded with their details (default: 2000), so that a hot method does not use the whole budget

#### `--max-value-length MAX_VALUE_LENGTH`

✂️ Characters kept of each argument, return value and exception message (default: 300)

#### `--only-failed`

🎯 Record with their details (arguments, return value, stack) only the calls that throw an exception: the others are only counted in the statistics. With `--slower-than`, the calls that throw or are slow

#### `--slower-than DURATION`

🐢 Record with their details only the calls that take at least this long (500ms, 2s, 1m): the others are only counted in the statistics. With `--only-failed`, the calls that are slow or throw

#### `--output-dir, -o OUTPUT_DIR`

📂 Folder for the trace and its HTML report, used by `--action` stop (default: current folder)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `.`

#### `--no-analyze`

🙈 With `--action` stop, only copy the trace, do not analyze it

## Examples

```bash
playground debug jscissors --class io.confluent.connect.jdbc.sink.JdbcDbWriter --method write --action start
```

```bash
playground debug jscissors --action stop
```

```bash
playground debug jscissors --action status
```

```bash
playground debug jscissors --class 'io.confluent.connect.jdbc.sink.*' --duration 60s
```

```bash
playground debug jscissors --class org.apache.kafka.connect.runtime.WorkerSinkTask --method 'poll|convertMessages' --operation VALUES --operation EXCEPTION_THREADS
```

```bash
playground debug jscissors -c broker --class kafka.server.KafkaApis --method handleProduceRequest --restart
```

```bash
playground debug jscissors --class io.confluent.connect.jdbc.sink.BufferedRecords --only-failed --duration 2m
```

```bash
playground debug jscissors --class 'io.confluent.connect.s3.*' --slower-than 500ms --action start
```


