# playground topic create

🆕 Create topic

## Usage

```bash
playground topic create [OPTIONS] [ARGUMENTS...]
```

## Examples

```bash
playground topic create --topic atopic
playground topic create --topic atopic --nb-partitions 8 --config retention.ms=30000

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

