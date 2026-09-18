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

#### *--topic, -t TOPIC*

🗳 Topic name

## Examples

```bash
playground get-number-records --topic a-topic
```

```bash
playground get-number-records -t a-topic
```


