# playground storage cat

📄 Print the records of the objects written by a sink connector

Downloads the objects (`--max-objects`, the first ones in topic,  
partition and offset order, or the newest with `--newest`) and prints  
their records: Avro (avro-tools) and Parquet (parquet-tools) as json,  
JSON lines, CSV, text and byte array objects as they are, gzip  
compressed objects uncompressed.

Then a continuity check per topic-partition: the offsets covered by  
the objects (start offset of the name + number of records), with the  
gaps (offsets in no object: records lost, or a compacted topic,  
transaction markers, a filter SMT) and the overlaps (offsets in two  
objects: duplicates, after a task restart with a time based  
partitioner for example).

`--records` prints only the records, one json per line, for jq or a  
script.

## Usage

```bash
playground storage cat [OPTIONS]
```

## Options

#### `--connector, -c CONNECTOR`

🔗 Connector whose bucket to read (default: the only running connector)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--url`

#### `--url URL`

🌐 Location to read instead of the one of a connector

s3://bucket/prefix, gs://bucket/prefix, az://account/container/prefix, hdfs://[user@]namenode:9000/path, sftp://user:password@host:22/path

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--connector`

#### `--endpoint ENDPOINT`

🔌 Endpoint of an S3 compatible store, with an s3:// `--url` (http://minio:9000)

#### `--prefix PREFIX`

📁 Folder to read instead of topics.dir of the connector ("" for the whole bucket)

#### `--topic, -t TOPIC`

🗳 Only the objects of this topic (comma separated list allowed)

#### `--include INCLUDE`

🔎 Only the objects whose path matches this regex (partition=0/, year=2026, \.avro$)

#### `--max-objects MAX_OBJECTS`

🔢 Max number of objects to read (default is 20, 0 for all)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `20`

#### `--newest`

🆕 Read the newest objects instead of the first ones

#### `--records`

📜 Print only the records, one json per line

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--json`, `--summary`

#### `--summary`

📊 Print only the summary per topic-partition (records, offsets, gaps, overlaps)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--json`, `--records`

#### `--json`

🤖 Print the objects, their records and the summary as json

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--records`, `--summary`

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground storage cat
```

```bash
playground storage cat --topic s3-topic --include "partition=0/" --max-objects 5
```

```bash
playground storage cat --summary --max-objects 0
```

```bash
playground storage cat --records | jq -r .f1
```

```bash
playground storage cat --url gs://my-bucket/topics --newest --max-objects 3
```

## Example output

```text
$ playground storage cat --url s3://mybucket/topics --endpoint http://minio:9000 --topic t1 --include partition=0/ --max-objects 2
12:50:27 ℹ️ 🪣 s3://mybucket/topics, credentials of AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY
12:50:27 ❗ 📄 reading 2 of 3 objects (--max-objects 2)
📄 t1/partition=0/t1+0+0000000000.avro (avro, 3 record(s))
   {"id": 0, "f1": "value0"}
   {"id": 1, "f1": "value1"}
   {"id": 2, "f1": "value2"}
📄 t1/partition=0/t1+0+0000000003.avro (avro, 3 record(s))
   {"id": 3, "f1": "value3"}
   {"id": 4, "f1": "value4"}
   {"id": 5, "f1": "value5"}

topic-partition                           objects   records                offsets  continuity
t1-0                                            2         6                  0 → 5  ✅ contiguous
📦 6 record(s) in 2 object(s)
```

```text
$ playground storage cat --url s3://mybucket/topics --endpoint http://minio:9000 --topic t1 --summary
12:50:29 ℹ️ 🪣 s3://mybucket/topics, credentials of AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY
12:50:30 ℹ️ 📄 reading 5 object(s)
topic-partition                           objects   records                offsets  continuity
t1-0                                            3         8                  0 → 9  🕳️ 1 gap(s)
t1-2                                            2         6                  0 → 4  🔁 1 overlap(s)
   🕳️ t1-0: offsets 6-7 are in no object (between t1+0+0000000003.avro and t1+0+0000000008.avro)
   🔁 t1-2: offset 2 is in two objects (t1+2+0000000000.avro and t1+2+0000000002.avro): duplicates
   🎓 a gap is expected on a compacted topic, with transactions (markers use offsets), after a retention deletion, or when an SMT / errors.tolerance dropped records
📦 14 record(s) in 5 object(s)
```


