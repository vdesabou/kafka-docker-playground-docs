# playground flink table-ddl

🧱 Print the Flink SQL CREATE TABLE of a Kafka topic, its columns read from the Avro value schema in Schema Registry

Flink cannot read the columns of a table from Schema Registry: this command writes them for you, from the latest version of the subject `<topic>`-value (or of `--schema-topic`), with the Avro types mapped to Flink SQL types (records become ROW, arrays ARRAY, maps MAP, unions with null a nullable column, logical types DATE, TIME, TIMESTAMP and DECIMAL). The table reads (or, with `--sink`, writes) the values with the avro-confluent format; the key of the records is not read.

Paste the result in `playground flink sql`, or use it in a script, as `playground repro bootstrap --pipeline-step flink` does.

⚠️ Avro values only (open source Flink has no Protobuf or JSON Schema Schema Registry format); local Flink cluster only.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-flink

## Usage

```bash
playground flink table-ddl [OPTIONS]
```

## Options

#### `--topic, -t TOPIC`

🗳 Topic of the table

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--table TABLE`

🧱 Name of the table (default: the topic, with every character other than a letter, a digit or _ replaced by _)

#### `--schema-topic TOPIC`

📜 Topic whose value schema gives the columns (default: `--topic`). For a table written by an INSERT INTO a new topic, use the topic it copies.

#### `--sink`

✍️ A table written by an INSERT INTO: no consumer group nor startup mode in its options

#### `--field FIELD`

🧩 The columns of this record field of the value instead of the whole value, for example after for a Debezium envelope

#### `--select-from TABLE`

🔎 Print the SELECT of the columns of `--field` from this table (SELECT `after`.`id` AS `id`, … FROM `<table>` WHERE `after` IS NOT NULL) instead of the CREATE TABLE

## Examples

```bash
playground flink table-ddl --topic orders
```

```bash
playground flink table-ddl --topic orders_copy --schema-topic orders --table orders_copy --sink
```

```bash
playground flink table-ddl --topic cdc_flat --schema-topic server1_mydb_CUSTOMERS --field after --table cdc_flat --sink
```

```bash
playground flink table-ddl --topic server1_mydb_CUSTOMERS --field after --select-from cdc_source
```

## Example output

```text
$ playground flink table-ddl --topic orders
CREATE TABLE `orders` (
  `id` INT,
  `product` STRING,
  `quantity` INT
) WITH (
  'connector' = 'kafka',
  'topic' = 'orders',
  'properties.bootstrap.servers' = 'broker:9092',
  'properties.group.id' = 'flink-orders',
  'scan.startup.mode' = 'earliest-offset',
  'value.format' = 'avro-confluent',
  'value.avro-confluent.url' = 'http://schema-registry:8081'
);
```


