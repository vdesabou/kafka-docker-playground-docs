# playground topic check-format

🧬 Check the format of the records of a topic, from their bytes

Looks at the first bytes of each key and value, and gives a census per  
partition and offset range: Schema Registry wire format (magic byte +  
schema id, looked up in Schema Registry: Avro, Protobuf with its  
message, JSON Schema, or ❌ not found), schema id in a  
__key_schema_id / __value_schema_id header, JSON with or without the  
JsonConverter {"schema":…,"payload":…} envelope, string, binary, Avro  
container file, tombstones and null keys.

Then the findings, and the converter to use:

- **❌ mixed formats**: some records are not in the format of the others, and the error each converter gives on them ('Unknown magic byte!', 'JsonConverter with schemas.enable requires "schema" and "payload" fields', 'Converting byte[] to Kafka Connect data failed due to serialization error')
- **❌ unknown schema id**: 'Error retrieving Avro schema for id …', 'Schema not found': another registry, or a hard deleted schema
- **❌ subject, no wire**: a `<topic>`-value subject exists, but the values format             are JSON or strings
- **⚠️ subject mismatch**: the schema id is not a version of `<topic>`-value (RecordNameStrategy producer)
- **ℹ️ tombstones, null keys, schema id in a header, JSON envelope**
- **✅ key.converter / value.converter when each side has one format**

'topic consume' picks one format for the whole topic from its subjects:  
a topic where some records differ is decoded wrong, with no hint of  
where the bad records are. This command reads raw bytes (never  
decoded), so it shows them. Exit code 1 on a ❌ finding.

Reads `--max-messages` records (default 1000) spread across the  
partitions: the last ones of each partition, the first ones with  
`--from-beginning`, or the ones around `--offset` (the offset of a  
connector error). Works on every environment, Confluent Cloud  
included.

🎓 Tip: then test the converters of a connector on one record with  
`playground connector smt test --from-topic <topic> --offset <o>`.

## Usage

```bash
playground topic check-format [OPTIONS]
```

## Dependencies

#### *python3*

visit https://www.python.org/downloads/ to install

## Options

#### `--topic, -t TOPIC`

🗳 Topic name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--max-messages MAX_MESSAGES`

🔢 Number of records to read, spread across the partitions (default is 1000)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `1000`

#### `--from-beginning`

⏮️ Read the first records of each partition instead of the last ones

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--offset`

#### `--partition PARTITION`

🔢 Only this partition

#### `--offset OFFSET`

📍 Read the records around this offset (the one of a converter error), on each partition or on `--partition`

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--from-beginning`

#### `--key-only`

🔑 Only check the keys

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--value-only`

#### `--value-only`

📦 Only check the values

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--key-only`

#### `--samples`

🔎 Show the first record of each range, as text and hex

#### `--json`

🤖 Print the census and the findings as JSON

#### `--verbose, -v`

🐞 Show command being ran.

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

## Examples

```bash
playground topic check-format --topic orders
```

```bash
playground topic check-format --topic orders --partition 0 --offset 1488 --samples
```

```bash
playground topic check-format --topic orders --value-only --max-messages 10000
```

```bash
playground topic check-format --topic orders --json
```

## Example output

```text
$ playground topic check-format --topic orders
16:46:11 ℹ️ 🔍 orders: 5 record(s) read of 5, the last ones of its only partition
16:46:11 ℹ️ 🗂️ subjects: orders-value (AVRO, latest version 1, id 1)

   key
   all                     5        null key

   value
   partition  offsets      records  format
   0          0-2          3        Avro, schema id 1 (orders-value v1)
   0          3-4          2        JSON, no schema  ❌

   ❌ 2 values are plain JSON (no schema), the others are in the Schema Registry wire format: partition 0 offsets 3-4
      👉 a sink with value.converter=AvroConverter (or Protobuf / JsonSchema) fails with 'Unknown magic byte!' at partition 0 offset 3
      👉 send them to a dead letter queue (errors.tolerance=all + errors.deadletterqueue.topic.name), or skip them (playground connector offsets alter)
   ℹ️  all keys are null
      👉 a sink keyed on the record key (JDBC pk.mode=record_key, upserts, document id = key) cannot use them
16:46:11 🔥 ❌ 1 problem(s): the records of orders are not all in a format their converter can read
```


