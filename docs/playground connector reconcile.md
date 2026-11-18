# playground connector reconcile

🧮 Compare the records of the topic with the rows of the table: lost, duplicated, different?

Answers "the sink lost records", "the source missed rows", "we have  
duplicates" with one verdict instead of counting rows by hand. Reads  
both sides of the connector, compares them record by record, and  
lists what does not match:

- **sink**: for each key, the last record of the topic against the row of the table (a tombstone or a delete event: the row must be gone, when the connector deletes)
- **source**: each row of the table against the last record of its key in the topic (Debezium / CDC envelopes: the "after" state)

- **❌ lost**: in the topic (sink) or the table (source), not on the other side
- **❌ duplicated**: a key twice in the table, or the same record twice in the topic of a source
- **❌ different**: fields whose values differ (converter, SMT, column type, truncation...)
- **❌ not deleted**: the last record is a tombstone, the row is still there
- **⚠️ extra**: only on the other side (rows written before, by another producer): reported, not a failure

The topic, the table, the database container, the key and whether  
deletes are applied come from the config of the connector, for the  
JDBC sink and source (Confluent and Debezium), the Debezium sources,  
the MongoDB sink and their fully managed versions:

- **key**: pk.mode / pk.fields (record_key, record_value, kafka: topic, partition, offset), primary.key.mode of the Debezium JDBC sink, incrementing.column.name, else the fields of the record key when it is a struct, else no key (the records and the rows are compared as multisets of values)
- **table**: table.name.format (${topic} replaced), collection, table.whitelist / table.include.list
- **database**: the host of connection.url / database.hostname when it is a running container, with the user and password of the connector

Pass `--topic`, `--table`, `--key-field` and `--container` for anything else,  
and `--rows-file` to compare with rows exported from any system (a  
bucket, a warehouse, a customer dump), one json object per line.

Values are compared by meaning, not by text: 1, 1.0 and "1"; true and  
1; epoch milliseconds (or days) and a date or timestamp column;  
json text and an object; CHAR padding; Avro unions; MongoDB extended  
json. Column names are compared case-insensitively.

Exits with 1 when records are lost, duplicated, different or not  
deleted, so an example or a repro model can assert on it.

Supported databases: the ones of `playground db sql` except Db2  
(PostgreSQL, MySQL, MariaDB, SQL Server, Oracle 19c and later, MongoDB).

☁️ Fully managed: supported when the database runs in a local container,  
else with `--rows-file`

## Usage

```bash
playground connector reconcile [OPTIONS]
```

## Options

#### `--verbose, -v`

🐞 Show command being ran.

#### `--connector, -c CONNECTOR`

🔗 Connector name

🎓 Tip: If not specified, the command will apply to all connectors

#### `--topic, -t TOPIC`

🗳 Topic to compare

ℹ️ If not set, from the config of the connector (topics of a sink with one topic, topic.prefix + table of a source)

#### `--table TABLE`

🛢️ Table (or collection) to compare, schema.table works too

ℹ️ If not set, from the config of the connector (table.name.format, collection, table.whitelist...)

#### `--key-field, -k KEY-FIELD`

🔑 Column that identifies a row (repeat it for a composite key)

ℹ️ If not set, from the config of the connector, else the fields of the record key

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--ignore-field IGNORE-FIELD`

🙈 Field or column never compared, e.g. a column filled by the database (repeat it for several)

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--container CONTAINER`

🐳 Container of the database

ℹ️ If not set, the host of the connection url of the connector when it is a running container, else the only running database container

#### `--user, -u USER`

👤 Database user

ℹ️ If not set, the user of the connector config (connection.user, database.user), else the admin user of the container

#### `--password PASSWORD`

🔑 Password of `--user`

ℹ️ If not set, the password of the connector config, else the password of the container environment

#### `--database, -d DATABASE`

🗄️ Database (Oracle: service name)

ℹ️ If not set, from the connection url of the connector, else the database of the container environment

#### `--rows-file ROWS-FILE`

📄 Rows to compare with, one json object per line, instead of reading a database table

#### `--direction DIRECTION`

🧭 sink: the topic is the truth, source: the table is the truth

ℹ️ If not set, sink when the config has topics or topics.regex

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `sink`, `source`

#### `--max-examples MAX-EXAMPLES`

🔢 Number of keys listed in each category

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `10`

#### `--json`

🤖 Print the result as JSON on stdout, and nothing else (the log lines go to stderr)

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

## Examples

```bash
playground connector reconcile
```

```bash
playground connector reconcile --connector jdbc-postgresql-sink --key-field id
```

```bash
playground connector reconcile --connector debezium-postgres-source --table public.customers --json
```

```bash
playground connector reconcile --connector s3-sink --rows-file /tmp/objects.json --key-field id
```

## Example output

```text
$ playground connector reconcile --connector pg-upsert
16:47:12 ℹ️ 🛢️ Reading postgres table customers (postgres, user myuser, database postgres)
16:47:12 ℹ️ 📥 Reading every record of topic customers
16:47:17 ℹ️ 🧮 Comparing (sink connector pg-upsert, pk.mode record_key, deletes applied: true)
🔎 Sink connector: is every record of the topic customers in the table customers?

   📥 topic customers                      5 record(s), 3 key(s)
   🛢️  table customers                      3 row(s), 3 key(s)
   🔑 key: id (pk.fields, pk.mode record_key)

❌ Not deleted, the last record is a tombstone or a delete event but the row is still there: 1
   key 3 (record p0@4)

❌ Different, the row does not match the last record of its key: 1
   key 2 (record p0@3): updated: topic 1763485200000 (2025-11-18 17:00:00 UTC), table "2025-11-18T17:00:01"

✅ 1 matching

❌ different: rows do not match the last record of their key (converter, SMT, column type?)
❌ not deleted: tombstones / delete events were not applied
```

```text
$ playground connector reconcile --connector debezium-postgres-source --table public.customers
🔎 Source connector: is every record of the table public.customers in the topic asgard.public.customers-raw?

   📥 topic asgard.public.customers-raw    23 record(s), 21 key(s)
   🛢️  table public.customers               20 row(s), 20 key(s)
   🔑 key: id (fields of the record key)

❌ Lost, in the table but not in the topic: 1
   key 22

❌ Different, the row does not match the last record of its key: 1
   key 7 (record p0@6): email: topic "fhuc6@quantcast.com", table "changed@example.com"; update_ts: topic 1795016619914819, table "2026-11-18T15:46:03.623079"

⚠️ Extra, only in the topic: deleted from the table without a delete event, or filtered (not a failure): 1
   key 9 (record p0@8)

🗑️ 1 key(s) deleted on both sides
✅ 18 matching

❌ lost: records of the table are missing in the topic
❌ different: rows do not match the last record of their key (converter, SMT, column type?)
```


