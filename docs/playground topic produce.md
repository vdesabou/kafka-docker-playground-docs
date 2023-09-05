# playground topic produce

📤 Produce to a topic

## Usage

```bash
playground topic produce [OPTIONS]
```

## Examples

```bash

playground topic produce --tombstone --topic a-topic --key mykey

playground topic produce -t topic-json --nb-messages 10 << 'EOF'
{
    "_meta": {
        "topic": "",
        "key": "",
        "relationships": []
    },
    "nested": {
        "phone": "faker.phone.imei()",
        "website": "faker.internet.domainName()"
    },
    "id": "iteration.index",
    "name": "faker.internet.userName()",
    "email": "faker.internet.exampleEmail()",
    "phone": "faker.phone.imei()",
    "website": "faker.internet.domainName()",
    "city": "faker.address.city()",
    "company": "faker.company.name()"
}
EOF

playground topic produce -t topic-avro --nb-messages 10 << 'EOF'
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

playground topic produce -t topic-json-schema --nb-messages 3 << 'EOF'
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "additionalProperties": false,
  "$id": "http://lh.test/Customer.schema.json",
  "title": "Customer",
  "description": "Customer description",
  "type": "object",
  "properties": {
    "name": {
      "description": "Customer name",
      "type": "string",
      "maxLength": 25
    },
    "surname": {
      "description": "Customer surname",
      "type": "string",
      "minLength": 2
    },
    "email": {
      "description": "Email",
      "type": "string",
      "pattern": "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$"
    }
  },
  "required": [
    "name",
    "surname"
  ]
}
EOF


playground topic produce -t topic-proto --nb-messages 3 << 'EOF'
syntax = "proto3";

message Order {
  float         total = 1;
  repeated Item items = 2;

  message Item {
    string name  = 1;
    float  price = 2;
  }
}
EOF

playground topic produce -t vincent-jsql --nb-messages 10 << 'EOF'
CREATE TABLE "notused"."notused" (
  "id" int PRIMARY KEY,
  "name" varchar COMMENT 'faker.internet.userName()',
  "merchant_id" int NOT NULL COMMENT 'faker.datatype.number()',
  "price" int COMMENT 'faker.datatype.number()',
  "status" int COMMENT 'faker.datatype.boolean()',
  "created_at" datetime DEFAULT (now())
);
EOF

```

## Options

#### *--input INPUT*

🔥 You can either:  
  
* Set your own schema (avro, json-schema, protobuf) with stdin (see example section).   
  
* You can also generate json data using json or sql format using syntax from https://github.com/MaterializeInc/datagen  
  
* Use completion to select predefined schemas (or use your own schema file) 🎓 Tip: use \<tab\> completion to trigger fzf completion  
  
* Directly set payload

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | -

#### *--verbose, -v*

🐞 Show command being ran.

#### *--topic, -t TOPIC*

🗳 Topic name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--nb-messages NB-MESSAGES*

💯 Number of messages to produce (default is 1)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 1

#### *--nb-partitions NB-PARTITIONS*

🔢 Number of partitions for the topic. (default is 1)  
  
❌ Important: If topic is existing, it will be re-created before producing to topic.

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 

#### *--compatibility COMPATIBILITY*

Schema Registry compatibility rule

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | BACKWARD, BACKWARD_TRANSITIVE, FORWARD, FORWARD_TRANSITIVE, FULL, FULL_TRANSITIVE, NONE

#### *--value-subject-name-strategy VALUE-SUBJECT-NAME-STRATEGY*

Value Subject Name Strategy

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | TopicNameStrategy, RecordNameStrategy, TopicRecordNameStrategy

#### *--key KEY*

🗝️ Key to use. If not set, no key is used.  
  
If the key contain a number, it will be used as starting point and incremented for each record.   
  
Example: key1 will start with key1, then key1, etc..  
Example: mykey-10-suffix will start with mykey-10-suffix then mykey-11-suffix, etc..  
  
Otherwise, the key will be same for all records.

#### *--headers HEADERS*

🚏 Headers to use for all records. If not set, no header is used.  
  
Example: --headers "header1:value1,header2:value2"  
  
Note: CP 7.2+ is required.

#### *--forced-value FORCED-VALUE*

☢️ Value to use for all records.   
  
🎓 Tip: use --generate-only first with avro, json-schema or protobuf to get skeleton of messages and then use --forced-value to send the message you need. 

#### *--generate-only*

🚪 Only generate messages without sending to kafka topic.  
  
Used with --forced-value, this is a powerful way to send specific messages.

#### *--tombstone*

⚰️ Generate tombstone (record with null value).   
  
--key must be set when this flag is used.  
  
Note: CP 7.2+ is required.

#### *--validate*

☑️ Validate schema according to connect sink converter used

#### *--validate-config VALIDATE-CONFIG*

🔩 Converter configuration parameters to use   
  
See docs: https://docs.confluent.io/platform/current/schema-registry/connect.html#using-kconnect-long-with-sr  
  
🎓 Tip: you can pass multiple parameters by specifying --validate-config multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Allowed Values: | scrub.invalid.names=true, enhanced.avro.schema.support=true, connect.meta.data=false, object.additional.properties=false, use.optional.for.nonrequired=true, ignore.default.for.nullables=true, generalized.sum.type.support=true, enhanced.protobuf.schema.support=true, generate.index.for.unions=false, int.for.enums=true, optional.for.nullables=true, generate.struct.for.nulls=true, wrapper.for.nullables=true, wrapper.for.raw.primitives=false


