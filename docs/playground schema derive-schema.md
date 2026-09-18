# playground schema derive-schema

🪄 Derive a schema based on payload  
  
Give it one or more json records, on stdin or with --payload, and it  
works out a schema that covers them all. Much faster than writing an  
avro schema by hand, and it handles unions when a field has different  
types across records.

## Usage

```bash
playground schema derive-schema [OPTIONS]
```

## Options

#### *--payload PAYLOAD*

📦 Payload to derive schema from

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | -

#### *--schema-type SCHEMA-TYPE*

🧩 Schema Registry schema "type":  
  
- AVRO  
- JSON (json schema)  
- PROTOBUF  
  
Default is AVRO

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | AVRO
| Allowed Values: | AVRO, JSON, PROTOBUF

## Examples

```bash
playground schema derive-schema << EOF
{"name": "Foo", "Age": {"int": 12}}
{"name": "Bar", "Age": {"string": "12"}}
{"sport": "Football"}
{"_id":{"key":"AA"},"duration":{"numberInt":"240"},"employeeNumber":{"numberInt":"12345"},"isActive":"Y","plannedAbsenceKey":"AA","startTimeMin":{"numberLong":"11599920"}}
EOF

playground schema derive-schema --payload '{"sport": "Football"}' --schema-type PROTOBUF

```


