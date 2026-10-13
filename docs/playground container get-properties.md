# playground container get-properties

📝 Get properties file from a container  
  
👉 Check documentation https://kafka-docker-playground.io/#/how-to-use?id=%f0%9f%93%9d-see-properties-file

## Usage

```bash
playground container get-properties [OPTIONS]
```

## Options

#### *--container, -c, --pod, -p CONTAINER*

🐳 container name (or pod name when cfk environment is used)  
  
🎓 Tip: you can pass multiple containers by specifying --container multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | connect

## Examples

```bash
playground container get-properties
```

```bash
playground container get-properties --container broker
```

```bash
playground container get-properties -c broker
```

## Example output

```text
$ playground container get-properties -c connect
17:22:51 ℹ️ 📝 Displaying properties file for connect
bootstrap.servers=broker:9092
config.storage.topic=connect-configs
group.id=connect-cluster
key.converter=org.apache.kafka.connect.storage.StringConverter
offset.storage.topic=connect-offsets
plugin.path=/usr/share/filestream-connectors
rest.port=8083
status.storage.topic=connect-status
value.converter=io.confluent.connect.avro.AvroConverter
value.converter.schema.registry.url=http://schema-registry:8081
...
```


