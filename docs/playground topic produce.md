# playground topic produce

📤 Produce to a topic  
  
See video tutorial https://youtu.be/mbzHCewG_XE

## Usage

```bash
playground topic produce [OPTIONS]
```

## Options

#### *--key KEY*

🗝️ Key to use. If not set, no key is used.  
  
🔥 You can either:  
  
* Set your own schema (avro, json-schema, protobuf) within single quotes (see examples)   
  
* You can also generate json data using json or sql format using syntax from https://github.com/MaterializeInc/datagen  
  
* You can also generate json data using syntax from https://github.com/vdesabou/avro-random-generator (same as datagen source connector)  
  
* Use completion to select predefined schemas (or use your own schema file) 🎓 Tip: use \<tab\> completion to trigger fzf completion  
  
* Directly set payload ("%g" can be used to generate a counter)  
  
In case of 'raw' data (i.e not using schema):  
  
If the key contain a number, it will be used as starting point and incremented for each record.   
  
Example: key1 will start with key1, then key2, etc..  
Example: mykey-10-suffix will start with mykey-10-suffix then mykey-11-suffix, etc..  
  
"%g" can also be used to generate a counter  
  
Example: key%g will start with key1, then key2, etc..  
  
Otherwise, the key will be same for all records.

#### *--value VALUE*

🔥 You can either:  
  
* Set your own schema (avro, json-schema, protobuf) with stdin (see example section).   
  
* You can also generate json data using json or sql format using syntax from https://github.com/MaterializeInc/datagen  
  
* You can also generate json data using syntax from https://github.com/vdesabou/avro-random-generator (same as datagen source connector)  
  
* Use completion to select predefined schemas (or use your own schema file) 🎓 Tip: use \<tab\> completion to trigger fzf completion  
  
* Directly set payload ("%g" can be used to generate a counter)

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
     
🎓  - if \> \<value of --max-nb-messages-per-batch\> (default 300000), messages will be sent in batches of \<value of --max-nb-messages-per-batch\> (default 300000) records  
    - if you set it to -1, an infinite number of records will also be sent in batches

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 1

#### *--max-nb-messages-per-batch MAX-NB-MESSAGES-PER-BATCH*

🔼 Max number of messages to send per batch when --nb-messages \> --max-nb-messages-per-batch  
   if --nb-messages is set to -1, this is the number of messages sent per batch  
   default is 300000

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 300000

#### *--max-nb-messages-to-generate MAX-NB-MESSAGES-TO-GENERATE*

🔨 Max number of different messages to generate.  
  
   - when protobuf is used, default is 50 as protobuf generation is really slow  
   - when json or sql datagen format is used, default is 1000  
   - when --record-size is set, default is 100  
   --when nb-messages is set to -1, default is 1000  
   - otherwise default is 100000

#### *--sleep-time-between-batch SLEEP-TIME-BETWEEN-BATCH*

💤 Sleep time in seconds between batches  
   default is 0

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 0

#### *--nb-partitions NB-PARTITIONS*

🔢 Number of partitions for the topic. (default is 1)  
  
❌ Important: If topic is existing, it will be re-created before producing to topic.

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 1

#### *--compression-codec COMPRESSION-CODEC*

🤐 The compression codec: either 'gzip', 'snappy', 'lz4', or 'zstd'  
If not set, there is no compression

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | gzip, snappy, lz4, zstd

#### *--compatibility COMPATIBILITY*

Schema Registry compatibility rule

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | BACKWARD, BACKWARD_TRANSITIVE, FORWARD, FORWARD_TRANSITIVE, FULL, FULL_TRANSITIVE, NONE

#### *--key-subject-name-strategy KEY-SUBJECT-NAME-STRATEGY*

Key Subject Name Strategy

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | TopicNameStrategy, RecordNameStrategy, TopicRecordNameStrategy

#### *--value-subject-name-strategy VALUE-SUBJECT-NAME-STRATEGY*

Value Subject Name Strategy

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | TopicNameStrategy, RecordNameStrategy, TopicRecordNameStrategy

#### *--headers HEADERS*

🚏 Headers to use for all records. If not set, no header is used.  
  
Example: --headers "header1:value1,header2:value2"  
  
Note: CP 7.2+ is required.

#### *--forced-key FORCED-KEY*

☢️ Key to use for all records.   
  
🎓 Tip: use --generate-only first with avro, json-schema or protobuf to get skeleton of messages and then use --forced-key to send the message you need. 

#### *--forced-value FORCED-VALUE*

☢️ Value to use for all records.   
  
🎓 Tip: use --generate-only first with avro, json-schema or protobuf to get skeleton of messages and then use --forced-value to send the message you need. 

#### *--generate-only*

🚪 Only generate messages without sending to kafka topic.  
  
Used with --forced-value, this is a powerful way to send specific messages.

#### *--tombstone*

⚰️ Generate tombstone (record with null value).   
  
Setting --key is recommended when this flag is used.   
If not set, the key will also be null, hence generating a null record (both key and value being null)  
  
Note: CP 7.2+ is required.

#### *--validate*

☑️ Validate schema according to connect sink converter used

#### *--derive-key-schema-as DERIVE-KEY-SCHEMA-AS*

🪄 Use playground schema derive-schema command to deduce schema from key payload  
  
Possible values:  
  
- AVRO  
- JSON (json schema)  
- PROTOBUF

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | AVRO, JSON, PROTOBUF

#### *--derive-value-schema-as DERIVE-VALUE-SCHEMA-AS*

🪄 Use playground schema derive-schema command to deduce schema from value payload  
  
Possible values:  
  
- AVRO  
- JSON (json schema)  
- PROTOBUF

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | AVRO, JSON, PROTOBUF

#### *--no-null*

🪹 Never generate null fields even for optional fields  
  
N.B: only work with avro and json-schema

#### *--consume*

📥 After producing, directly consume topic.

#### *--delete-topic*

❌ Delete topic and associated schema/subject if applicable before producing data.

#### *--validate-config VALIDATE-CONFIG*

🔩 Converter configuration parameters to use   
  
See docs: https://docs.confluent.io/platform/current/schema-registry/connect.html#using-kconnect-long-with-sr  
  
🎓 Tip: you can pass multiple parameters by specifying --validate-config multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Allowed Values: | scrub.invalid.names=true, enhanced.avro.schema.support=true, connect.meta.data=false, object.additional.properties=false, use.optional.for.nonrequired=true, ignore.default.for.nullables=true, generalized.sum.type.support=true, enhanced.protobuf.schema.support=true, generate.index.for.unions=false, int.for.enums=true, optional.for.nullables=true, generate.struct.for.nulls=true, wrapper.for.nullables=true, wrapper.for.raw.primitives=false

#### *--producer-property PRODUCER-PROPERTY*

🔩 Producer configuration parameters to use   
  
See docs: https://docs.confluent.io/platform/current/installation/configuration/producer-configs.html#cp-config-producer  
  
🎓 Tip: you can pass multiple parameters by specifying --producer-property multiple times  
  
Example: --producer-property "max.request.size=990485760" --producer-property "client.id=myid"

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### *--record-size RECORD-SIZE*

🏋️ Record size in bytes, eg. 1048576 for 1MB  
  
📢 If size is \> 1Mb, --producer-property max.request.size and topic max.message.bytes will be automatically set to support the record size.  
  
Note that --no-null will be used when this option is set

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 0

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
    "city": "faker.location.city()",
    "company": "faker.company.name()"
}
EOF

playground topic produce -t topic-datagen-users --nb-messages 10 << 'EOF'
{
        "namespace": "ksql",
        "name": "users",
        "type": "record",
        "fields": [
                {"name": "registertime", "type": {
                    "type": "long",
                    "arg.properties": {
                        "range": {
                            "min": 1487715775521,
                            "max": 1519273364600
                        }
                    }
                }},
                {"name": "userid", "type": {
                    "type": "string",
                    "arg.properties": {
                        "regex": "User_[1-9]"
                    }
                }},
                {"name": "regionid", "type": {
                    "type": "string",
                    "arg.properties": {
                        "regex": "Region_[1-9]"
                    }
                }},
                {"name": "gender", "type": {
                    "type": "string",
                    "arg.properties": {
                        "options": [
                            "MALE",
                            "FEMALE",
                            "OTHER"
                        ]
                    }
                }}
        ]
}
EOF

playground  topic produce -t topic-datagen-json-schema --nb-messages 1 --value predefined-schemas/datagen/purchase.avro --derive-value-schema-as JSON 

playground topic produce -t topic-avro --nb-messages 10 << 'EOF'
{
  "fields": [
    {
      "name": "count",
      "type": "long"
    },
    {
      "name": "first_name",
      "type": "string"
    },
    {
      "name": "last_name",
      "type": "string"
    },
    {
      "default": null,
      "name": "address",
      "type": [
        "null",
        "string"
      ]
    },
    {
      "name": "last_sale_date",
      "type": {
        "logicalType": "timestamp-millis",
        "type": "long"
      }
    },
    {
      "name": "last_sale_price",
      "type": {
        "logicalType": "decimal",
        "precision": 15,
        "scale": 2,
        "type": "bytes"
      }
    },
    {
      "name": "last_connection",
      "type": {
        "logicalType": "date",
        "type": "int"
      }
    }
  ],
  "name": "Customer",
  "namespace": "com.github.vdesabou",
  "type": "record"
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


playground topic produce -t topic-proto --nb-messages 1 << 'EOF'
syntax = "proto3";

package com.github.vdesabou;

message Customer {
    int64 count = 1;
    string first_name = 2;
    string last_name = 3;
    string address = 4;
}
EOF

playground topic produce -t topic-jsql --nb-messages 10 << 'EOF'
CREATE TABLE "notused"."notused" (
  "id" int PRIMARY KEY,
  "name" varchar COMMENT 'faker.internet.userName()',
  "merchant_id" int NOT NULL COMMENT 'faker.number.int()',
  "price" int COMMENT 'faker.number.int()',
  "status" int COMMENT 'faker.datatype.boolean()',
  "created_at" datetime DEFAULT (now())
);
EOF

playground topic produce -t topic-json --nb-messages 1 --producer-property "max.request.size=990485760" < bigjson.json

playground topic produce -t topic-string --nb-messages 5000 << 'EOF'
Ad et ut pariatur officia eos.
Nesciunt fugit nam libero ut qui itaque sed earum at itaque nesciunt eveniet atque.
Quidem libero quis quod et illum excepturi voluptas et in perspiciatis iusto neque.
Quibusdam commodi explicabo dolores molestiae qui delectus dolorum fugiat molestiae natus assumenda omnis expedita.
Et sunt aut architecto suscipit fugiat qui voluptate iure vel doloremque eum culpa.
Qui enim facilis eos similique aperiam totam eius et at dolor dolores.
Ut sunt quia qui quia consectetur aut reiciendis.
Modi adipisci iusto aut voluptatem dolores laudantium.
Sequi sint quia quibusdam molestias minus et aliquid voluptatum aliquam.
Rerum aut amet quo possimus nihil velit quisquam ut cumque.
Pariatur ad officiis voluptatibus quia vel corporis ea fugit adipisci porro.
EOF

# key and headers
# mykey1 %g can also be used
playground topic produce -t topic-json-multiple-lines --nb-messages 10 --key "mykey1" --headers "header1:value1,header2:value2" << 'EOF'
{"u_name": "scissors", "u_price": 2.75, "u_quantity": 3}
{"u_name": "tape", "u_price": 0.99, "u_quantity": 10}
{"u_name": "notebooks", "u_price": 1.99, "u_quantity": 5}
EOF

# avro key
playground topic produce -t topic-avro-with-key --nb-messages 10 --key '
{
  "fields": [
    {
      "name": "id",
      "type": "long"
    }
  ],
  "name": "Key",
  "namespace": "com.github.vdesabou",
  "type": "record"
}
' << 'EOF'
{
  "fields": [
    {
      "doc": "count",
      "name": "count",
      "type": "long"
    },
    {
      "doc": "First Name of Customer",
      "name": "first_name",
      "type": "string"
    },
    {
      "doc": "Last Name of Customer",
      "name": "last_name",
      "type": "string"
    }
  ],
  "name": "Customer",
  "namespace": "com.github.vdesabou",
  "type": "record"
}
EOF

# tombstone
playground topic produce -t topic-json-multiple-lines --tombstone --key "mykey1"

# input file
playground topic produce -t topic-avro-example3 < avro-schema.avsc

# record-size
playground topic produce -t topic-avro-example-big-size --nb-messages 3 --record-size 10000000 << 'EOF'
{
  "fields": [
    {
      "doc": "count",
      "name": "count",
      "type": "long"
    },
    {
      "doc": "First Name of Customer",
      "name": "first_name",
      "type": "string"
    },
    {
      "doc": "Last Name of Customer",
      "name": "last_name",
      "type": "string"
    },
    {
      "doc": "Address of Customer",
      "name": "address",
      "type": "string"
    }
  ],
  "name": "Customer",
  "namespace": "com.github.vdesabou",
  "type": "record"
}
EOF

# validate
playground topic produce -t topic-json-schema-validate --nb-messages 3 --validate << 'EOF'
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
    },
    "holiday": {
      "oneOf": [
        {
          "title": "Not included",
          "type": "null"
        },
        {}
      ]
    },
    "f2": {}
  },
  "required": [
    "name",
    "surname"
  ]
}
EOF

#  --value-subject-name-strategy
playground topic produce -t topic-avro-example-value-subject-name-strategy --nb-messages 10 --value-subject-name-strategy TopicRecordNameStrategy << 'EOF'
{
  "fields": [
    {
      "doc": "count",
      "name": "count",
      "type": "long"
    },
    {
      "doc": "First Name of Customer",
      "name": "first_name",
      "type": "string"
    },
    {
      "doc": "Last Name of Customer",
      "name": "last_name",
      "type": "string"
    },
    {
      "doc": "Address of Customer",
      "name": "address",
      "type": "string"
    }
  ],
  "name": "Customer",
  "namespace": "com.github.vdesabou",
  "type": "record"
}
EOF

# --generate-only
playground topic produce -t topic-avro-example-forced-value --nb-messages 10  --generate-only << 'EOF'
{
  "fields": [
    {
      "doc": "count",
      "name": "count",
      "type": "long"
    },
    {
      "doc": "First Name of Customer",
      "name": "first_name",
      "type": "string"
    },
    {
      "doc": "Last Name of Customer",
      "name": "last_name",
      "type": "string"
    },
    {
      "doc": "Address of Customer",
      "name": "address",
      "type": "string"
    },
    {
      "name": "createdDate",
      "type": {
        "logicalType": "timestamp-millis",
        "type": "long"
      }
    },
    {
      "default": null,
      "name": "warranty_expiration",
      "type": [
        "null",
        {
          "logicalType": "date",
          "type": "int"
        }
      ]
    }
  ],
  "name": "Customer",
  "namespace": "com.github.vdesabou",
  "type": "record"
}
EOF

# --forced-value
playground topic produce -t topic-avro-example-forced-value --nb-messages 1 --forced-value '{"count":4,"first_name":"Vincent","last_name":"de Saboulin","address":"xxx","createdDate":1697852606000,"warranty_expiration":{"int":19653}}' << 'EOF'
{
  "fields": [
    {
      "doc": "count",
      "name": "count",
      "type": "long"
    },
    {
      "doc": "First Name of Customer",
      "name": "first_name",
      "type": "string"
    },
    {
      "doc": "Last Name of Customer",
      "name": "last_name",
      "type": "string"
    },
    {
      "doc": "Address of Customer",
      "name": "address",
      "type": "string"
    },
    {
      "name": "createdDate",
      "type": {
        "logicalType": "timestamp-millis",
        "type": "long"
      }
    },
    {
      "default": null,
      "name": "warranty_expiration",
      "type": [
        "null",
        {
          "logicalType": "date",
          "type": "int"
        }
      ]
    }
  ],
  "name": "Customer",
  "namespace": "com.github.vdesabou",
  "type": "record"
}
EOF

# --derive-value-schema-as
playground topic produce --topic tocpic --derive-value-schema-as PROTOBUF --derive-key-schema-as PROTOBUF --key '{"id": "1"}' << 'EOF'
{"name": "Foo", "Age": {"int": 12}}
EOF

```


