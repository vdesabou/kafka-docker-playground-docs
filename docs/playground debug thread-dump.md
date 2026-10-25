# playground debug thread-dump

🎯 Take a java thread dump

🔖 It will save output to a file and open with text editor set with playground config editor `<editor>` (default is code)

The first thing to take when something is stuck: it shows the stack of  
every thread, and the deadlocks if any.

🔖 It sends kill -3 to the JVM, which prints the dump to the container logs: no JDK is needed in the image and the container is not restarted. It falls back to jstack -l when the dump does not reach the logs.

🎓 Tip: take two or three dumps a few seconds apart. Threads that appear  
in the same place every time are the ones that are really blocked. playground analyze thread-dump does it and analyzes them.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-jvm-diagnostics  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%A7%B5-a-connector-looks-stuck-analyze-thread-dumps

## Usage

```bash
playground debug thread-dump [OPTIONS]
```

## Options

#### `--container, -c, --pod, -p CONTAINER`

🐳 container name (or pod name when cfk environment is used)

🎓 Tip: you can pass multiple containers by specifying `--container` multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | `connect`

#### `--jstack`

🔧 Use jstack -l instead of kill -3: adds the owners of java.util.concurrent locks ("Locked ownable synchronizers"). Needs a JDK in the image (on cfk, a debug container is attached); the container is never restarted

## Examples

```bash
playground debug thread-dump
```

```bash
playground debug thread-dump --container broker
```

```bash
playground debug thread-dump -c connect -c broker
```

```bash
playground debug thread-dump --container schema-registry --container ksqldb-server
```

```bash
playground debug thread-dump --container connect --jstack
```


