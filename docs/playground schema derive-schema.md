# playground schema derive-schema

🪄 Derive a schema based on payload

Give it one or more json records, on stdin or with `--payload`, and it  
works out a schema that covers them all. Much faster than writing an  
avro schema by hand, and it handles unions when a field has different  
types across records.

The type is called Schema unless `--name` is set (`--namespace` for its  
namespace / protobuf package). Values that look like a date, a  
timestamp, a uuid, a decimal in a string or epoch milliseconds get a 💡  
hint with the logical type to use: the plugin only sees strings and  
numbers. `--output-file` writes the schema, `--register` `--subject`  
registers it.

## Usage

```bash
playground schema derive-schema [OPTIONS]
```

## Options

#### `--payload PAYLOAD`

📦 Payload to derive schema from

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `-`

#### `--schema-type SCHEMA-TYPE`

🧩 Schema Registry schema "type":

- AVRO
- JSON (json schema)
- PROTOBUF

Default is AVRO

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `AVRO`
| Allowed Values: | `AVRO`, `JSON`, `PROTOBUF`

#### `--name NAME`

🏷️ Name of the top-level record / message (json schema: title), instead of Schema

#### `--namespace NAMESPACE`

🏷️ Namespace of the record (protobuf: package)

#### `--output-file, -o FILE`

📄 Also write the schema to this file

#### `--register`

⏺️ Register the schema in `--subject` (Schema Registry of the running environment)

#### `--subject SUBJECT`

📛 Subject for `--register`

## Examples

```bash
playground schema derive-schema --name Order --namespace com.example -o order.avsc << EOF
{"order_id": 1, "customer": "acme", "amount": 9.99, "created": "2026-10-31T10:00:00Z"}
EOF

playground schema derive-schema --payload @sample.json --register --subject orders-value

playground schema derive-schema << EOF
{"name": "Foo", "Age": {"int": 12}}
{"name": "Bar", "Age": {"string": "12"}}
{"sport": "Football"}
{"_id":{"key":"AA"},"duration":{"numberInt":"240"},"employeeNumber":{"numberInt":"12345"},"isActive":"Y","plannedAbsenceKey":"AA","startTimeMin":{"numberLong":"11599920"}}
EOF

playground schema derive-schema --payload '{"sport": "Football"}' --schema-type PROTOBUF

```


