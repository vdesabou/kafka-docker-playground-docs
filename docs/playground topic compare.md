# playground topic compare

🔀 Compare a topic with its replica: is everything replicated?

Earliest and latest offsets and number of records of every partition, on  
both sides, and what the destination misses. In an mdc-\* environment  
the two sides are the clusters given with `--from` and `--to` (Replicator,  
MirrorMaker 2, Cluster Linking); elsewhere, two topics of the same  
cluster (`--to-topic`).

Exits 1 when the destination has fewer records than the source. The  
counts come from the offsets: transaction markers and compaction make  
them approximate.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-replication

## Usage

```bash
playground topic compare [OPTIONS]
```

## Options

#### `--topic, -t TOPIC`

🗳 Topic name in the source

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--to-topic TO_TOPIC`

🎯 Topic name in the destination (default: the same name). MirrorMaker 2  
prefixes it with the source alias, e.g. EUROPE.sales_EUROPE

#### `--from FROM`

🌍 Source cluster in an mdc-\* environment

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

#### `--to TO`

🌍 Destination cluster in an mdc-\* environment

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

#### `--wait`

⏳ Wait until the destination has as many records as the source

#### `--max-wait MAX_WAIT`

⏳ Max seconds to wait with `--wait` (default 120)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `120`

#### `--json`

🤖 Print the comparison as JSON

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground topic compare --topic sales_EUROPE --from europe --to us
```

```bash
playground topic compare --topic sales_EUROPE --to-topic EUROPE.sales_EUROPE --from europe --to us --wait
```

```bash
playground topic compare --topic test-topic --to-topic test-topic-duplicate
```


