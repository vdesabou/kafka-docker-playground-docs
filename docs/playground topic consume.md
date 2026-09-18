# playground topic consume

📥 Consume topic from beginning  
  
Reads from the earliest offset and deserialises records on its own:  
avro, protobuf, json schema and plain formats are all detected from  
the payload, so you do not have to pick a console consumer.  
  
🎓 Tip: --min-expected-messages turns it into an assertion. It waits  
up to --timeout for that many records and fails otherwise, which is  
how examples verify that data actually flowed.

## Usage

```bash
playground topic consume [OPTIONS]
```

## Options

#### *--verbose, -v*

🐞 Show command being ran.

#### *--topic, -t TOPIC*

🗳 Topic name

#### *--max-messages MAX-MESSAGES*

Max number of messages to display (default is 100)  
  
You can use -1 to display all messages

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 100

#### *--min-expected-messages MIN-EXPECTED-MESSAGES*

Minimum expected number of messages to be present in topic, returns an error if this is not the case  
  
Note: --topic should be specified in this case.

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 0

#### *--grep GREP*

Verify that topic content contains record which contains specified string

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 

#### *--timeout TIMEOUT*

Max number of seconds to wait when --min-expected-messages is used.  
  
Default is 60 seconds

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 60

#### *--tail*

Tail on logs.

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--min-expected-messages, --max-messages, --open*

#### *--plot-latencies-timestamp-field TIMESTAMP*

🗳 Timestamp field name that represents when record was created in source system

#### *--key-subject KEY-SUBJECT*

📛 Subject for key in schema-registry to use (useful when data was produced with --key-subject-name-strategy other than TopicNameStrategy)  
  
Note: --topic should be specified in this case.

#### *--value-subject VALUE-SUBJECT*

📛 Subject for value in schema-registry to use (useful when data was produced with --value-subject-name-strategy other than TopicNameStrategy)  
  
Note: --topic should be specified in this case.

#### *--max-characters MAX-CHARACTERS*

Max characters per message to display (default is 3000)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 3000

#### *--open, -o*

🔖 Save full dump of topic to a file and open with text editor set with playground config editor \<editor\> (default is code)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--max-characters, --tail, --min-expected-messages*

#### *--isolation-level ISOLATION-LEVEL*

🫥 The isolation level to use, see https://docs.confluent.io/platform/current/installation/configuration/consumer-configs.html#isolation-level  
If not set, default is read_uncommitted

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | read_uncommitted
| Allowed Values: | read_uncommitted, read_committed


