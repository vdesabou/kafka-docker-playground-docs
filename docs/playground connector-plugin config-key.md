# playground connector-plugin config-key

🔑 Explain a connector configuration key: documentation, type, default, since when, and which examples set it

Answers "what does this key do, what is its default, since which  
version does it exist, and how is it used" in one call, without a  
running environment.

📗 Documentation, type, default, importance and group come from the  
configuration reference that CI records for every tested connector,  
self-managed and fully managed (the config-`<class>`.txt files next to  
the examples, refreshed with the latest connector version).

📅 The git history of that file tells when CI first saw the key, which  
is when a new connector version introduced it. Versions you ran  
locally (playground connector show-config-parameters cache) are also  
checked one by one.

🧪 Examples that set the key are listed with the value they use.

Without `--connector-class`, every connector having the key is listed.  
When the key is not found, similar keys are suggested.

## Usage

```bash
playground connector-plugin config-key [OPTIONS]
```

## Options

#### `--key, -k KEY`

🔑 Exact configuration key, for example behavior.on.null.values

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--connector-class, -c CONNECTOR-CLASS`

🔌 Only this connector: part of its class name or fully managed type, case insensitive

Examples: S3SinkConnector, io.confluent.connect.jdbc.JdbcSinkConnector, `S3_SINK`, jdbc

#### `--max-examples MAX_EXAMPLES`

🧪 Maximum number of examples to show (default 10)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `10`

#### `--since-version`

📅 Find the first version of the plugin having the key (self-managed connectors)

A binary search over the versions of Confluent Hub: each probed version is downloaded and its configuration  
read without a worker, like playground connector-plugin config-diff (about 5 s per version, 6 or 7 versions).  
Needs one connector (`--connector-class`). The plugin is found from the examples, or set with `--connector-plugin`.

#### `--connector-plugin CONNECTOR-PLUGIN`

🔌 Plugin of the connector for `--since-version` (owner/name), when the examples don't tell it

#### `--json`

🤖 Print the result as JSON (connectors with their definition, versions run locally, values in examples)

## Examples

```bash
playground connector-plugin config-key --key behavior.on.null.values
```

```bash
playground connector-plugin config-key --key behavior.on.null.values --connector-class S3SinkConnector
```

```bash
playground connector-plugin config-key -k s3.part.size -c S3_SINK
```

```bash
playground connector-plugin config-key -k errors.tolerance -c jdbc --max-examples 3
```

```bash
playground connector-plugin config-key -k batch.max.rows -c io.confluent.connect.jdbc.JdbcSourceConnector --since-version
```

## Example output

```text
$ playground connector-plugin config-key --key flush.size
17:22:28 ℹ️ 🔌 12 connector(s) have key flush.size, use --connector-class to see the details of one
   defaults: null (x7), 1000 (x5)

CONNECTOR                                                                TYPE  DEFAULT  IMPORTANCE
AzureBlobSink                                                            INT   1000     HIGH
GcsSink                                                                  INT   1000     HIGH
io.confluent.connect.gcs.GcsSinkConnector                                INT   null     HIGH
io.confluent.connect.hdfs.HdfsSinkConnector                              INT   null     HIGH
io.confluent.connect.s3.S3SinkConnector                                  INT   null     HIGH
S3_SINK                                                                  INT   1000     HIGH
...

17:22:30 ℹ️ 🧪 427 line(s) in examples set flush.size, values used (most frequent first):
   "3"                            x275 e.g. connect/connect-gcp-gcs-source/gcs-source-backup-and-restore.sh:98
   "1000"                         x63  e.g. ccloud/fm-azure-data-lake-storage-gen2-sink/fully-managed-azure-data-lake-storage-gen2-sink.sh:134
   "1"                            x14  e.g. connect/connect-ftps-sink/ftps-sink.sh:55
```


