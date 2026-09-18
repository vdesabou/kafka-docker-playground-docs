# playground topic create

🆕 Create topic  
  
Only needed when you want something other than the defaults, since  
'playground topic produce' creates the topic on the fly. Any extra  
argument is passed through to kafka-topics --create, so --config works  
as usual.

## Usage

```bash
playground topic create [OPTIONS] [--] [ARGUMENTS...]
```

## Options

#### *--verbose, -v*

🐞 Show command being ran.

#### *--topic, -t TOPIC*

🗳 Topic name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--nb-partitions NB-PARTITIONS*

Number of partitions for the topic. (default is 1)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 1

## Examples

```bash
playground topic create --topic atopic
playground topic create --topic atopic --nb-partitions 8 --config retention.ms=30000 --config cleanup.policy=compact

```


