# playground schema register

⏺️ Register a schema in specified subject

## Usage

```bash
playground schema register [OPTIONS]
```

## Options

#### *--subject SUBJECT*

📛 Subject name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--verbose, -v*

🐞 Show command being ran.

#### *--schema SCHEMA*

🔥 You can either:  
  
* Set your own schema (avro, json-schema, protobuf) with stdin (see example section).   
  
* Use completion to select predefined schemas (or use your own schema file) 🎓 Tip: use \<tab\> completion to trigger fzf completion

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | -

#### *--id ID*

☢️ Force schema id  
  
❗it will replace any schema which already exists at given id

#### *--metadata-property METADATA-PROPERTY*

🟡 Add metadata properties to schema contract  
  
See docs: https://docs.confluent.io/platform/current/schema-registry/fundamentals/data-contracts.html#metadata-properties  
  
🎓 Tip: you can pass multiple properties by specifying --metadata-property multiple times  
  
Example: --metadata-property "metadata1=value" --metadata-property "metadata2=value"

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### *--normalize*

🫧 Add ?normalize=true at the end of the request to normalize the schema. The default is false.

## Examples

```bash
playground schema register --subject test-protobuf << 'EOF'
syntax = "proto3";

package com.github.vdesabou;

message Customer {
    int64 count = 1;
    string first_name = 2;
    string last_name = 3;
    string address = 4;
}
EOF

playground schema register --subject test-avro --metadata-property test=test --metadata-property test2=test << 'EOF'
{
    "type": "record",
    "namespace": "com.github.vdesabou",
    "name": "Customer",
    "fields": [
        {
            "name": "count",
            "type": "long",
            "doc": "count"
        },
        {
            "name": "first_name",
            "type": "string",
            "doc": "First Name of Customer"
        },
        {
            "name": "last_name",
            "type": "string",
            "doc": "Last Name of Customer"
        },
        {
            "name": "address",
            "type": "string",
            "doc": "Address of Customer"
        }
    ]
}
EOF

```


