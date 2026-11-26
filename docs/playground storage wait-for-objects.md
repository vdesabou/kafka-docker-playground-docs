# playground storage wait-for-objects

⏳ Wait for a sink connector to write a minimum number of objects

Lists the objects every `--interval` seconds until there are at least  
`--min-expected-objects` (of `--topic`, matching `--include`), and fails  
after `--max-wait` seconds. A bucket folder that does not exist yet  
counts as empty.

🎓 Tip: a storage sink writes an object every flush.size records (or  
rotate.interval.ms): 10 records with flush.size=3 make 3 objects.

## Usage

```bash
playground storage wait-for-objects [OPTIONS]
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

#### `--min-expected-objects MIN_EXPECTED_OBJECTS`

🔢 Minimum number of objects to wait for (default is 1)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `1`

#### `--max-wait MAX_WAIT`

⏳ Max time in seconds to wait (default is 120)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `120`

#### `--interval INTERVAL`

🔁 Interval in seconds between checks (default is 5)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `5`

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground storage wait-for-objects --min-expected-objects 3
```

```bash
playground storage wait-for-objects --connector gcs-sink --topic gcs-topic --max-wait 300
```

```bash
playground storage wait-for-objects --url s3://mybucket/topics --endpoint http://minio:9000 --include "partition=0/"
```

## Example output

```text
$ playground storage wait-for-objects --url s3://mybucket/topics --endpoint http://minio:9000 --topic t3 --max-wait 4 --interval 2
12:50:34 ℹ️ ⏳ Waiting up to 4 seconds for at least 1 object(s) in s3://mybucket/topics (topic t3)
12:50:34 ℹ️ ⌛ 0 object(s) (expected at least 1)
12:50:39 🔥 ❌ 0 object(s) in s3://mybucket/topics (topic t3) after 4 seconds, expected at least 1
```


