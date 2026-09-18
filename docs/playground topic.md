# playground topic

🗳 Topic commands  
  
Produce, consume and manage topics without dealing with the kafka-* shell  
scripts: the bootstrap server, the security properties and the schema  
registry url are all derived from the running environment, so the same  
command works on plaintext, on sasl-ssl and on Confluent Cloud.  
  
📤 Get data in  
  produce         generate records from a schema, or from your own data  
  create          create a topic with the partitions you need  
  
📥 Get data out  
  consume         read from the beginning, deserialising automatically  
  get-number-records   count what is in the topic  
  display-consumer-offsets   read the internal offsets topic  
  
🔧 Manage  
  list / describe / alter / delete  
  set-schema-compatibility   compatibility of the topic subjects  
  
Serialisation is handled for you: 'produce' registers the schema you give  
it and 'consume' works out from the payload whether it is avro, protobuf,  
json schema or plain text.  
  
🎓 Tip: in an example script, 'consume --min-expected-messages N' is the  
assertion that the data made it through; it fails the run if it did not.

## Usage

```bash
playground topic COMMAND
```

## Topic commands

- [get-number-records](playground%20topic%20get-number-records) - 💯 Get number of records in a topic
- [display-consumer-offsets](playground%20topic%20display-consumer-offsets) - 📭 Display content of __consumer_offsets topic
- [list](playground%20topic%20list) - 🔘 List topics
- [describe](playground%20topic%20describe) - 🔬 Describe topic
- [set-schema-compatibility](playground%20topic%20set-schema-compatibility) - 🛡️ Change topic's schema compatibility
- [consume](playground%20topic%20consume) - 📥 Consume topic from beginning
- [produce](playground%20topic%20produce) - 📤 Produce to a topic
- [create](playground%20topic%20create) - 🆕 Create topic
- [delete](playground%20topic%20delete) - ❌ Delete topic and associated schema/subject if applicable
- [alter](playground%20topic%20alter) - 🪛 Alter topic config


