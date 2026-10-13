# playground topic get-offsets

📍 Get earliest and latest offsets per partition of a topic  
  
The low and high watermarks of every partition, and the number of  
records in between. Useful to see whether retention has already  
deleted data, which partitions received records, or which offsets a  
connector should be at.

## Usage

```bash
playground topic get-offsets [OPTIONS]
```

## Options

#### *--topic, -t TOPIC*

🗳 Topic name

#### *--verbose, -v*

🐞 Show command being ran.

## Examples

```bash
playground topic get-offsets --topic a-topic
```


