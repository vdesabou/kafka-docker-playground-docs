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

#### *--container, -c CONTAINER*

🐳 Container name  
  
🎓 Tip: you can pass multiple containers by specifying --container multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | connect

#### *--open, -o*

🔖 Save output to a file and open with text editor set with playground config editor \<editor\> (default is code)

#### *--domain, -d DOMAIN*

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


