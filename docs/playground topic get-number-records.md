# playground topic get-number-records

💯 Get number of records in a topic

Counts the records currently in the topic, from the partition offsets.  
The cheap way to check that a source connector produced something, or  
that a sink has data to read.

## Usage

```bash
playground topic get-number-records [OPTIONS]
```

## Options

#### `--topic, -t TOPIC`

🗳 Topic name

## Examples

```bash
playground topic get-number-records --topic a-topic
```

```bash
playground topic get-number-records -t a-topic
```

## Example output

```text
$ playground topic get-number-records --topic filestream
17:22:53 ℹ️ 💯 Get number of records in topic filestream
5
```


