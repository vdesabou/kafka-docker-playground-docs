# playground get-jmx-metrics

🔢 Get JMX metrics from a container

👉 Check documentation https://kafka-docker-playground.io/#/how-to-use?id=%f0%9f%94%a2-jmx-metrics

## Usage

```bash
playground get-jmx-metrics [OPTIONS]
```

## Dependencies

#### *java*

visit https://openjdk.org/install/ to install

## Options

#### `--container, -c, --pod, -p CONTAINER`

🐳 container name (or pod name when cfk environment is used)

🎓 Tip: you can pass multiple containers by specifying `--container` multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | `connect`

#### `--open, -o`

🔖 Save output to a file and open with text editor set with playground config editor `<editor>` (default is code)

#### `--domain, -d DOMAIN`

Domain name

## Examples

```bash
playground get-jmx-metrics --container connect
```

```bash
playground get-jmx-metrics --container connect --domain "kafka.connect kafka.consumer kafka.producer"
```

```bash
playground get-jmx-metrics -c broker
```

```bash
playground get-jmx-metrics -c connect -c broker
```

```bash
playground get-jmx-metrics --container schema-registry --container ksqldb-server --open
```

```bash
playground get-jmx-metrics -c broker -c connect --domain "kafka.server"
```

## Example output

```text
$ playground get-jmx-metrics -c connect --domain "kafka.connect"
17:24:01 ℹ️ 🪄 Copying files with docker cp
####### domain kafka.connect ########
Welcome to JMX terminal. Type "help" for available commands.
#mbean = kafka.connect:client-id="connect:8083",type=app-info:
start-time-ms = 1791901690493;

commit-id = 328ff4d5ac3448d6;

version = 8.3.2-ce;

#mbean = kafka.connect:client-id=connect-adminclient-producer,node-id=node--1,type=connect-node-metrics:
request-rate = 0.0;

response-rate = 0.0;
...
```


