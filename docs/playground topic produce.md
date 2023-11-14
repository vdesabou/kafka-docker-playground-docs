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
      "name": "myDecimal",
      "type": [
        "null",
        {
          "logicalType": "decimal",
          "precision": 15,
          "scale": 2,
          "type": "bytes"
        }
      ]
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
  "merchant_id" int NOT NULL COMMENT 'faker.datatype.number()',
  "price" int COMMENT 'faker.datatype.number()',
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
playground topic produce -t topic-avro-with-key --nb-messages 10 --key '{"fields":[{"name":"id","type":"long"}],"name":"Key","namespace":"com.github.vdesabou","type":"record"}' << 'EOF'
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

```

## Options

#### *--key KEY*

🗝️ Key to use. If not set, no key is used.  
  
🔥 You can either:  
  
* Set your own schema (avro, json-schema, protobuf) within single quotes (see examples)   
  
* You can also generate json data using json or sql format using syntax from https://github.com/MaterializeInc/datagen  
  
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
  
* Use completion to select predefined schemas (or use your own schema file) 🎓 Tip: use \<tab\> completion to trigger fzf completion  
  
* Directly set payload ("%g" can be used to generate a counter)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | -

#### *--verbose, -v*

🐞 Show command being ran.

#### *--debug, -d*

debug mode (internal)

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

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

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 0


