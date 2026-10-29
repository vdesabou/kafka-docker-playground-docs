# playground topic

🗳 Topic commands

Produce, consume and manage topics without dealing with the kafka-\* shell  
scripts: the bootstrap server, the security properties and the schema  
registry url are all derived from the running environment, so the same  
command works on plaintext, on sasl-ssl and on Confluent Cloud.

**📤 Get data in**

- **produce**: generate records from a schema, or from your own data
- **create**: create a topic with the partitions you need

**📥 Get data out**

- **consume**: read from the beginning, deserialising automatically
- **get-number-records**: count what is in the topic
- **wait-for-records**: wait until the topic contains N records
- **get-offsets**: earliest and latest offsets per partition
- **display-consumer-offsets**: read the internal offsets topic

**🔧 Manage**

- **list / describe / alter / delete**
- **reassign / elect-leader**: move replicas between brokers, move leaders
- **dlq inspect / replay**: dead letter queue grouped by error, and replay
- **set-schema-compatibility**: compatibility of the topic subjects
- **tag**: stream catalog tags (Confluent Cloud only)

Serialisation is handled for you: 'produce' registers the schema you give  
it and 'consume' works out from the payload whether it is avro, protobuf,  
json schema or plain text.

🎓 Tip: in an example script, 'consume `--min-expected-messages` N' is the  
assertion that the data made it through; it fails the run if it did not.

## Usage

```bash
playground topic COMMAND
```

## Topic commands

- [get-number-records](playground%20topic%20get-number-records) - 💯 Get number of records in a topic
- [wait-for-records](playground%20topic%20wait-for-records) - ⏳ Wait for a topic to contain a minimum number of records
- [get-offsets](playground%20topic%20get-offsets) - 📍 Get earliest and latest offsets per partition of a topic
- [display-consumer-offsets](playground%20topic%20display-consumer-offsets) - 📭 Display content of __consumer_offsets topic
- [list](playground%20topic%20list) - 🔘 List topics
- [get-size](playground%20topic%20get-size) - 📏 Get size of topics
- [describe](playground%20topic%20describe) - 🔬 Describe topic
- [reassign](playground%20topic%20reassign) - 🔀 Move the replicas of a topic to other brokers
- [elect-leader](playground%20topic%20elect-leader) - 👑 Elect the leaders of a topic
- [set-schema-compatibility](playground%20topic%20set-schema-compatibility) - 🛡️ Change topic's schema compatibility
- [consume](playground%20topic%20consume) - 📥 Consume topic from beginning
- [produce](playground%20topic%20produce) - 📤 Produce to a topic
- [create](playground%20topic%20create) - 🆕 Create topic
- [delete](playground%20topic%20delete) - ❌ Delete topic and associated schema/subject if applicable
- [alter](playground%20topic%20alter) - 🪛 Alter topic config
- [dlq](playground%20topic%20dlq) - 📬 Dead letter queue commands
  - [inspect](playground%20topic%20dlq%20inspect) - 🩺 Show what is in a dead letter queue, grouped by error
  - [replay](playground%20topic%20dlq%20replay) - 🔁 Produce the records of a dead letter queue again
- [tag](playground%20topic%20tag) - 🏷️ Stream Catalog tags (Confluent Cloud only)
  - [list](playground%20topic%20tag%20list) - 🏷️ List tag definitions
  - [create](playground%20topic%20tag%20create) - 🆕 Create a tag definition
  - [delete](playground%20topic%20tag%20delete) - ❌ Delete a tag definition
  - [add](playground%20topic%20tag%20add) - 🏷️ Assign a tag to a topic
  - [remove](playground%20topic%20tag%20remove) - 🧽 Remove a tag from a topic
  - [show](playground%20topic%20tag%20show) - 🔎 Show tags assigned to a topic
  - [search](playground%20topic%20tag%20search) - 🔎 Search topics having a tag


