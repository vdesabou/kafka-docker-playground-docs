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

| Attributes      | &nbsp;
|-----------------|-------------
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


