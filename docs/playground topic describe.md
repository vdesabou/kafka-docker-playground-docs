# playground topic describe

🔬 Describe topic

Partitions, replicas, in-sync replicas and the configuration overrides  
set on the topic. Where to look when records go to an unexpected  
partition, or when a topic is not retaining what you expected.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-topic-administration  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%AA%9B-a-producer-gets-recordtoolargeexception

## Usage

```bash
playground topic describe [OPTIONS]
```

## Options

#### `--topic, -t TOPIC`

🗳 Topic name

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground topic describe --topic filestream
```

## Example output

```text
$ playground topic describe --topic filestream
17:22:51 ℹ️ 🔎 Describing topic filestream
Topic: filestream  TopicId: ZTSM7bjsQxq2aigCM3C-8w  PartitionCount: 1  ReplicationFactor: 1  Configs: min.insync.replicas=1
    Topic: filestream  Partition: 0  Leader: 1  Replicas: 1  Isr: 1  Offline:   Elr:   LastKnownElr:
```


