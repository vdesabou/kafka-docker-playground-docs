# playground topic get-offsets

📍 Get earliest and latest offsets per partition of a topic

The low and high watermarks of every partition, and the number of  
records in between. Useful to see whether retention has already  
deleted data, which partitions received records, or which offsets a  
connector should be at.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-topic-administration  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%AA%9B-a-producer-gets-recordtoolargeexception

## Usage

```bash
playground topic get-offsets [OPTIONS]
```

## Options

#### `--topic, -t TOPIC`

🗳 Topic name

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground topic get-offsets --topic a-topic
```

## Example output

```text
$ playground topic get-offsets --topic filestream
17:22:55 ℹ️ 📍 Earliest and latest offsets per partition of topic filestream
PARTITION  EARLIEST        LATEST          RECORDS
0          0               5               5
TOTAL                                      5
```


