# playground storage ls

🪣 List the objects written by a sink connector

Lists every object under the folder of the connector (topics.dir,  
"topics" by default) with its size and time, then a summary per  
topic-partition: number of objects, size, first offset and start  
offset of the last object (from the object names  
`<topic>`+`<partition>`+`<start offset>`.`<format>`).

Temporary files of the HDFS sink (+tmp folders) are left out.

## Usage

```bash
playground storage ls [OPTIONS]
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

🔢 Max number of objects to show (default is 100, 0 for all); the summary counts all of them

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `100`

#### `--json`

🤖 Print the objects and the summary as json

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground storage ls
```

```bash
playground storage ls --connector s3-sink --topic s3-topic
```

```bash
playground storage ls --url s3://mybucket/topics --endpoint http://minio:9000
```

```bash
playground storage ls --url gs://my-bucket/topics --include "partition=0/"
```

```bash
playground storage ls --url hdfs://namenode:9000/topics
```

## Example output

```text
$ playground storage ls --url s3://mybucket/topics --endpoint http://minio:9000 --topic t1
12:50:25 ℹ️ 🪣 s3://mybucket/topics, credentials of AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY
object                                     size  modified
t1/partition=0/t1+0+0000000000.avro       224 B  2026-11-26 11:40:06
t1/partition=0/t1+0+0000000003.avro       224 B  2026-11-26 11:40:07
t1/partition=0/t1+0+0000000008.avro       215 B  2026-11-26 11:40:07
t1/partition=2/t1+2+0000000000.avro       224 B  2026-11-26 11:40:06
t1/partition=2/t1+2+0000000002.avro       224 B  2026-11-26 11:40:08

topic-partition                            objects     size first off.   last start  last modified
t1-0                                             3    663 B          0            8  2026-11-26 11:40:07
t1-2                                             2    448 B          0            2  2026-11-26 11:40:08

🪣 5 object(s) of 7, 1.1 KB
```


