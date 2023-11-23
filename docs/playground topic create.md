# playground topic create

🆕 Create topic

## Usage

```bash
playground topic create [OPTIONS] [ARGUMENTS...]
```

## Options

#### *--topic, -t TOPIC*

🗳 Topic name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--nb-partitions NB-PARTITIONS*

Number of partitions for the topic. (default is 1)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 

## Examples

```bash
playground topic create --topic atopic
playground topic create --topic atopic --nb-partitions 8 --config retention.ms=30000 --config cleanup.policy=compact

```


