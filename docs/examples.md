# 🧑‍🎓 Playground Academy

Below is a collection of real use cases/issues for which a reproduction model was done using the playground.

Each example (categorized by difficulty) is composed of:

* 🔥 A small description of the issue.
* 🤯 A detailed description with all required information.
* 📍 Series of step to follow. An (optional) solution for each step is provided in following step.
* 🌟 Results with a link to the full reproduction model, which can be executed directly using playground.

🧠 The goal is to let users do the reproduction by themselves. This is the only way to learn 😀.

> [!TIP]
> This is the counter of ![reproduction models](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/vdesabou/b7d51da11b2e8a7bdd1d2e45d4aaa2e5/raw/badges.json) made with playground so far..
> 


## ⭐ Beginner

### Unknown magic byte

<!-- tabs:start -->
#### **🔥 Description**

Sink connector is getting "Unknown magic byte" deserialization error.

💡 What you'll learn:

* Understand converter issue
* How to reset offsets
* Understand impact of DLQ

#### **🤯 Details**

Versions used:

* 🎯 CP: 7.4.0

* 🔗 Filestream sink: 7.4.0 (shipped with CP)

> [!TIP] Make sure to be aware of default converters used at worker level, see [↔️ Default Connect converter used](/how-it-works?id=%e2%86%94%ef%b8%8f-default-connect-converter-used)

#### **📍 Step 1**

Run the example `filestream-sink-repro-000002-deserialization-error.sh` (use `fzf` completion to find the example with `-f`):

```bash
playground run -f 000002<tab> --tag 7.4.0
```

As you can see, connector is failing (check output of `playground connector status`)

❔Questions:

* Do you know why it is failing ?
* Do you know how it could have been avoided ?

#### **📍 Step 2**
<!-- select:start -->
<!-- select-menu-labels: 🙋 See solution for previous step ? -->
#### --No--
#### --Yes--

> Do you know why it is failing ?

💡 Explanations:

Connector is configured with AvroConverter for the value:

```json
               "value.converter": "io.confluent.connect.avro.AvroConverter",
               "value.converter.schema.registry.url": "http://schema-registry:8081"
```

The 3 first requests are sent using Avro as `kafka-avro-console-producer` is used:

```bash
log "Sending messages to topic filestream"
docker exec -i connect kafka-avro-console-producer --broker-list broker:9092 --property schema.registry.url=http://schema-registry:8081 --topic a-topic --property value.schema='{"type":"record","name":"myrecord","fields":[{"name":"u_name","type":"string"},
{"name":"u_price", "type": "float"}, {"name":"u_quantity", "type": "int"}]}' << EOF
{"u_name": "scissors", "u_price": 2.75, "u_quantity": 3}
{"u_name": "tape", "u_price": 0.99, "u_quantity": 10}
{"u_name": "notebooks", "u_price": 1.99, "u_quantity": 5}
EOF
```

This is fine.

But 4th message is sent using `kafka-console-producer`:

```bash
log "Sending again message to topic filestream"
docker exec -i broker kafka-console-producer --broker-list broker:9092 --topic filestream << EOF
{"u_name": "poison pill", "u_price": 1.75, "u_quantity": 1}
EOF
```

So this is not AVRO, it is only sending plain JSON string.

This is why avro converter fails with `Unknown magic byte` since 4th message does not contain in the first 4 bytes the avro schema id.

> Do you know how it could have been avoided ?

One way to avoid this situation is to enable Confluent feature [Broker-side Schema ID Validation](https://docs.confluent.io/platform/7.4/schema-registry/schema-validation.html).
If this is setup, the 4th message would have been rejected by broker validation.


<!-- select:end -->

* Skip the 4th message (also called "Poison pill") by resetting consumer offset using `kafka-consumer-groups` CLI 

> [!TIP] If you're Confluent customer, check this [Knowledge Base article](https://support.confluent.io/hc/en-us/articles/360031115091-How-to-skip-messages-in-Kafka-Connect-or-reset-a-connector-to-the-earliest-offset-for-sink-connectors)

Here is an example of how you can use the CLI (in this case it is to reset to earliest, update it to reset to specific offset in order to skip poison pill):

```bash
docker exec broker kafka-consumer-groups --bootstrap-server broker:9092 --group connect-<connector name> --describe
docker exec broker kafka-consumer-groups --bootstrap-server broker:9092 --group connect-<connector name> --to-earliest --topic a-topic --reset-offsets --dry-run
docker exec broker kafka-consumer-groups --bootstrap-server broker:9092 --group connect-<connector name> --to-earliest --topic a-topic --reset-offsets --execute
```

> [!TIP] You can check offset and partition using `playground topic consume`

```bash
playground topic consume                                                
11:03:51 ℹ️ ✨ --topic flag was not provided, applying command to all topics
11:17:03 ℹ️ ✨ Display content of topic filestream, it contains 5 messages
11:17:03 ℹ️ 🔮🙅 topic is not using any schema for key
11:17:03 ℹ️ 🔮🔰 topic is using avro for value
[2023-05-16 09:17:08,473] ERROR Error processing message, skipping this message:  (kafka.tools.ConsoleConsumer$)
org.apache.kafka.common.errors.SerializationException: Unknown magic byte!
        at io.confluent.kafka.serializers.AbstractKafkaSchemaSerDe.getByteBuffer(AbstractKafkaSchemaSerDe.java:539)
        at io.confluent.kafka.serializers.AbstractKafkaAvroDeserializer$DeserializationContext.<init>(AbstractKafkaAvroDeserializer.java:386)
        at io.confluent.kafka.serializers.AbstractKafkaAvroDeserializer.deserialize(AbstractKafkaAvroDeserializer.java:184)
        at io.confluent.kafka.formatter.AvroMessageFormatter$AvroMessageDeserializer.deserialize(AvroMessageFormatter.java:134)
        at io.confluent.kafka.formatter.AvroMessageFormatter.writeTo(AvroMessageFormatter.java:89)
        at io.confluent.kafka.formatter.SchemaMessageFormatter.writeTo(SchemaMessageFormatter.java:262)
        at kafka.tools.ConsoleConsumer$.process(ConsoleConsumer.scala:116)
        at kafka.tools.ConsoleConsumer$.run(ConsoleConsumer.scala:76)
        at kafka.tools.ConsoleConsumer$.main(ConsoleConsumer.scala:53)
        at kafka.tools.ConsoleConsumer.main(ConsoleConsumer.scala)
CreateTime: 2023-05-16 11:16:50.530|Partition:0|Offset:0|NO_HEADERS|null|{"u_name":"scissors","u_price":2.75,"u_quantity":3}
Processed a total of 5 messages
CreateTime: 2023-05-16 11:16:50.543|Partition:0|Offset:1|NO_HEADERS|null|{"u_name":"tape","u_price":0.99,"u_quantity":10}
CreateTime: 2023-05-16 11:16:50.543|Partition:0|Offset:2|NO_HEADERS|null|{"u_name":"notebooks","u_price":1.99,"u_quantity":5}
CreateTime: 2023-05-16 11:16:52.232|Partition:0|Offset:3|NO_HEADERS|null|CreateTime:1684228614066|Partition:0|Offset:4|NO_HEADERS|null|{"u_name":"bottle","u_price":2.75,"u_quantity":3}
```

Poison pill is at `Partition:0|Offset:3`

#### **📍 Step 3**
<!-- select:start -->
<!-- select-menu-labels: 🙋 See solution for previous step ? -->
#### --No--
#### --Yes--

The output of describe command is:

```bash
docker exec broker kafka-consumer-groups --bootstrap-server broker:9092 --group connect-filestream-sink --describe
Consumer group 'connect-filestream-sink' has no active members.
```

This is because the connector task is in FAILED state.

In order to reset offset, the consumer group should not have any active members (in case connector is RUNNING, a common approach is to delete the connector, then reset offset, and then re-create connector), so we're good to proceed with reset offset here.

Reset offset to 4 (dry-run):

```bash
docker exec broker kafka-consumer-groups --bootstrap-server broker:9092 --group connect-filestream-sink --to-offset 4 --topic filestream --reset-offsets --dry-run

GROUP                          TOPIC                          PARTITION  NEW-OFFSET     
connect-filestream-sink        filestream                     0          4  
```

All good, do it !

```bash
docker exec broker kafka-consumer-groups --bootstrap-server broker:9092 --group connect-filestream-sink --to-offset 4 --topic filestream --reset-offsets --execute

GROUP                          TOPIC                          PARTITION  NEW-OFFSET     
connect-filestream-sink        filestream                     0          4         
```

Restart connector now:

```bash
playground connector restart
```

Verify connector is now running

```bash
playground connector status
```

Check data was processed:

```bash
docker exec connect cat /tmp/output.json
Struct{u_name=bottle,u_price=2.75,u_quantity=3}
```

Note: First 3 records were skipped, filestream connector is very basic, so not handling this issue very well..

<!-- select:end -->
👉 Now add a DLQ and re-run the example

To add DLQ, add this in connector config:

```json
               "errors.tolerance": "all",
               "errors.deadletterqueue.topic.name": "dlq",
               "errors.deadletterqueue.topic.replication.factor": "1",
               "errors.deadletterqueue.context.headers.enable": "true",
               "errors.log.enable": "true",
               "errors.log.include.messages": "true",
```

> [!TIP] to run again the example, just use `playground re-run`

See the difference in behaviour.

#### **📍 Step 4**
<!-- select:start -->
<!-- select-menu-labels: 🙋 See solution for previous step ? -->
#### --No--
#### --Yes--

Poison pill is going to DLQ:

```bash
11:23:53 ℹ️ ✨ Display content of topic dlq, it contains 1 messages
11:23:54 ℹ️ 🔮🙅 topic is not using any schema for key
11:23:54 ℹ️ 🔮🙅 topic is not using any schema for value
CreateTime: 2023-05-16 11:23:43.57|Partition:0|Offset:0|__connect.errors.topic:filestream,__connect.errors.partition:0,__connect.errors.offset:3,__connect.errors.connector.name:filestream-sink,__connect.errors.task.id:0,__connect.errors.stage:VALUE_CONVERTER,__connect.errors.class.name:io.confluent.connect.avro.AvroConverter,__connect.errors.exception.class.name:org.apache.kafka.connect.errors.DataException,__connect.errors.exception.message:Failed to deserialize data for topic filestream to Avro: ,__connect.errors.exception.stacktrace:org.apache.kafka.connect.errors.DataException: Failed to deserialize data for topic filestream to Avro:
at io.confluent.connect.avro.AvroConverter.toConnectData(AvroConverter.java:148)
at org.apache.kafka.connect.runtime.WorkerSinkTask.lambda$convertAndTransformRecord$5(WorkerSinkTask.java:525)
at org.apache.kafka.connect.runtime.errors.RetryWithToleranceOperator.execAndRetry(RetryWithToleranceOperator.java:190)
at org.apache.kafka.connect.runtime.errors.RetryWithToleranceOperator.execAndHandleError(RetryWithToleranceOperator.java:224)
at org.apache.kafka.connect.runtime.errors.RetryWithToleranceOperator.execute(RetryWithToleranceOperator.java:166)
at org.apache.kafka.connect.runtime.WorkerSinkTask.convertAndTransformRecord(WorkerSinkTask.java:525)
at org.apache.kafka.connect.runtime.WorkerSinkTask.convertMessages(WorkerSinkTask.java:500)
at org.apache.kafka.connect.runtime.WorkerSinkTask.poll(WorkerSinkTask.java:336)
at org.apache.kafka.connect.runtime.WorkerSinkTask.iteration(WorkerSinkTask.java:238)
at org.apache.kafka.connect.runtime.WorkerSinkTask.execute(WorkerSinkTask.java:207)
at org.apache.kafka.connect.runtime.WorkerTask.doRun(WorkerTask.java:213)
at org.apache.kafka.connect.runtime.WorkerTask.run(WorkerTask.java:268)
at org.apache.kafka.connect.runtime.isolation.Plugins.lambda$withClassLoader$1(Plugins.java:177)
at java.base/java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:515)
at java.base/java.util.concurrent.FutureTask.run(FutureTask.java:264)
at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1128)
at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:628)
at java.base/java.lang.Thread.run(Thread.java:829)
Caused by: org.apache.kafka.common.errors.SerializationException: Unknown magic byte!
at io.confluent.kafka.serializers.AbstractKafkaSchemaSerDe.getByteBuffer(AbstractKafkaSchemaSerDe.java:539)
at io.confluent.kafka.serializers.AbstractKafkaAvroDeserializer$DeserializationContext.<init>(AbstractKafkaAvroDeserializer.java:386)
at io.confluent.kafka.serializers.AbstractKafkaAvroDeserializer.deserializeWithSchemaAndVersion(AbstractKafkaAvroDeserializer.java:261)
at io.confluent.connect.avro.AvroConverter$Deserializer.deserialize(AvroConverter.java:199)
at io.confluent.connect.avro.AvroConverter.toConnectData(AvroConverter.java:126)
... 17 more
|null|{"u_name": "poison pill", "u_price": 1.75, "u_quantity": 1}
Processed a total of 1 messages
```

And connector is RUNNING:

```bash
playground connector status 
11:26:47 ℹ️ 🧩 Displaying connector(s) status
Name                           Status       Tasks                          Stack Trace                                       
-------------------------------------------------------------------------------------------------------------
filestream-sink                ✅ RUNNING  0:🟢 RUNNING                 -                                                 
-------------------------------------------------------------------------------------------------------------
```

<!-- select:end -->
🥁 So...did you learn about converter issues (Unknown magic byte) ?

#### **🎓 Next Steps**

* Read [Kafka Connect Deep Dive – Error Handling and Dead Letter Queues](https://www.confluent.io/en-gb/blog/kafka-connect-deep-dive-error-handling-dead-letter-queues/) and plays with different config parameters.
* Update example to enable [Broker-side Schema ID Validation](https://docs.confluent.io/platform/7.4/schema-registry/schema-validation.html)
* `Unknown magic byte` is when using AVRO. You can also test with JSON Schema and Protobuf to see the differences in stack traces, error messages.

To produce JSON Schema data, please refer to [this](/reusables?id=%f0%9f%94%a3-kafka-json-schema-console-producer) (use a new topic!) and make sure to change connector config with:

```json
"value.converter": "io.confluent.connect.json.JsonSchemaConverter",
"value.converter.schema.registry.url": "http://schema-registry:8081",
```

To produce Protobuf data, please refer to [this](/reusables?id=%f0%9f%94%a3-kafka-protobuf-console-producer) (use a new topic!) and make sure to change connector config with:

```json
"value.converter": "io.confluent.connect.protobuf.ProtobufConverter",
"value.converter.schema.registry.url": "http://schema-registry:8081",
```

<!-- tabs:end -->


## ⭐⭐ Intermediate

### StackOverflowError with S3 sink connector

<!-- tabs:start -->
#### **🔥 Description**

User is getting StackOverflowError with S3 sink connector. See stack trace in Details section.

💡 What you'll learn:

* [Bootstrap a reproduction model](/reusables?id=%f0%9f%9b%a0-bootstrap-reproduction-model) and use [Java Producer](/reusables?id=%e2%99%a8%ef%b8%8f-java-producers) to inject data using custom Avro schema.

#### **🤯 Details**

Versions used:

* 🎯 CP: 7.3.1

* 🔗 S3 sink: 10.3.3

S3 sink config:

```json
{
  "aws.access.key.id": "xxx",
  "aws.secret.access.key": "xxx",
  "connector.class": "io.confluent.connect.s3.S3SinkConnector",
  "errors.log.enable": "true",
  "errors.tolerance": "all",
  "flush.size": "50000",
  "format.class": "io.confluent.connect.s3.format.parquet.ParquetFormat",
  "key.converter": "org.apache.kafka.connect.storage.StringConverter",
  "locale": "de_DE",
  "partitioner.class": "io.confluent.connect.storage.partitioner.DailyPartitioner",
  "rotate.interval.ms": "3600000",
  "s3.bucket.name": "xxx",
  "s3.region": "eu-west-1",
  "storage.class": "io.confluent.connect.s3.storage.S3Storage",
  "tasks.max": "1",
  "timestamp.extractor": "Record",
  "timezone": "UTC",
  "topics.dir": "xxx",
  "topics": "topic1",
  "value.converter.schema.registry.url": "xxx",
  "value.converter": "io.confluent.connect.avro.AvroConverter"
}
```

AVRO schema for topic `topic1` (value):

```json
{
    "type": "record",
    "namespace": "acme",
    "name": "Characteristic",
    "fields": [
        {
            "name": "physicalCharacteristic",
            "type": [
                "null",
                {
                    "type": "record",
                    "name": "PhysicalCharacteristic",
                    "fields": [
                        {
                            "name": "children",
                            "type": [
                                "null",
                                {
                                    "type": "array",
                                    "items": "PhysicalCharacteristic"
                                }
                            ],
                            "default": null
                        }
                    ]
                }
            ]
        }
    ]
}
```

User is getting in logs:

```log
[2022-12-12 16:44:06,186] ERROR [s3-sink|task-0] WorkerSinkTask{id=s3-sink-0} Task threw an uncaught and unrecoverable exception. Task is being killed and will not recover until manually restarted (org.apache.kafka.connect.runtime.WorkerTask:208)
org.apache.kafka.connect.errors.ConnectException: Exiting WorkerSinkTask due to unrecoverable exception.
	at org.apache.kafka.connect.runtime.WorkerSinkTask.deliverMessages(WorkerSinkTask.java:618)
	at org.apache.kafka.connect.runtime.WorkerSinkTask.poll(WorkerSinkTask.java:334)
	at org.apache.kafka.connect.runtime.WorkerSinkTask.iteration(WorkerSinkTask.java:235)
	at org.apache.kafka.connect.runtime.WorkerSinkTask.execute(WorkerSinkTask.java:204)
	at org.apache.kafka.connect.runtime.WorkerTask.doRun(WorkerTask.java:201)
	at org.apache.kafka.connect.runtime.WorkerTask.run(WorkerTask.java:256)
	at java.base/java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:515)
	at java.base/java.util.concurrent.FutureTask.run(FutureTask.java:264)
	at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1128)
	at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:628)
	at java.base/java.lang.Thread.run(Thread.java:829)
Caused by: java.lang.StackOverflowError
	at org.apache.parquet.avro.AvroSchemaConverter.convertFields(AvroSchemaConverter.java:130)
	at org.apache.parquet.avro.AvroSchemaConverter.convertField(AvroSchemaConverter.java:163)
	at org.apache.parquet.avro.AvroSchemaConverter.convertField(AvroSchemaConverter.java:169)
	at org.apache.parquet.avro.AvroSchemaConverter.convertUnion(AvroSchemaConverter.java:226)
	at org.apache.parquet.avro.AvroSchemaConverter.convertField(AvroSchemaConverter.java:182)
	at org.apache.parquet.avro.AvroSchemaConverter.convertField(AvroSchemaConverter.java:141)
```

#### **📍 Step 1**

*  🎯 Choose the best [example](/content) to use as basis.

* 🛠 [Bootstrap](/reusables?id=%f0%9f%9b%a0-bootstrap-reproduction-model) your reproduction model!

> [!TIP]
> Do not forget to [🪄 Specify versions](/how-to-use?id=%f0%9f%aa%84-specify-versions) for CP and Connector before running the test !

#### **📍 Step 2**
<!-- select:start -->
<!-- select-menu-labels: 🙋 See solution for previous step ? -->
#### --No--
#### --Yes--


🛠 Bootstrap reproduction model was done as following (use tab completion to select the files s3-sink.sh using `fzf`):

```bash
playground bootstrap-reproduction-model --file s3-sink<tab> --description "000001 StackOverflowError with S3 sink connector" --producer avro --tag 7.3.1 --connector-tag 10.3.3
```

💡 Explanations:

* [s3-sink.sh](https://github.com/vdesabou/kafka-docker-playground/blob/master/connect/connect-aws-s3-sink/s3-sink.sh) is the closest example.
* The problem seems related to input data, so using [avro java producer](/reusables?id=%e2%99%a8%ef%b8%8f-java-producers) seems the right thing to do.

> [!NOTE]
> As the key converter is StringConverter, we should not use `avro-with-key` for `--producer` flag.

<!-- select:end -->

* 👉 Follow steps from [♨️ Java producers](/reusables?id=%e2%99%a8%ef%b8%8f-java-producers) in order to produce same data as user.

> [!TIP]
> Since we did not use `--producer-schema-value` flag when bootstrapping the reproduction model, step 3 in [♨️ Java producers](/reusables?id=%e2%99%a8%ef%b8%8f-java-producers) should be done manually.

#### **📍 Step 3**
<!-- select:start -->
<!-- select-menu-labels: 🙋 See solution for previous step ? -->
#### --No--
#### --Yes--

⌨️ Here are the steps to follow:

Update `producer-repro-000001/src/main/resources/schema/customer.avsc` file with content of user schema:

```
{
    "type": "record",
    "namespace": "acme",
    "name": "Characteristic",
    "fields": [
        {
            "name": "physicalCharacteristic",
            "type": [
                "null",
                {
                    "type": "record",
                    "name": "PhysicalCharacteristic",
                    "fields": [
                        {
                            "name": "children",
                            "type": [
                                "null",
                                {
                                    "type": "array",
                                    "items": "PhysicalCharacteristic"
                                }
                            ],
                            "default": null
                        }
                    ]
                }
            ]
        }
    ]
}
```

And replace:

```json
    "namespace": "acme",
    "name": "Characteristic",
```

by

```json
    "namespace": "com.github.vdesabou",
    "name": "Customer",
```

Note that you could have use step 2 when bootstrapping reproduction model and this step would be fully automated:

Example:

```bash
playground bootstrap-reproduction-model -f s3-sink<tab> -d "000001 StackOverflowError with S3 sink connector" -p avro --producer-schema-value schema<tab>
```

<!-- select:end -->
👉 Adapt the example to user details and run it !

#### **📍 Step 4**
<!-- select:start -->
<!-- select-menu-labels: 🙋 See solution for previous step ? -->
#### --No--
#### --Yes--

* The only relevant connector configuration for that use case is the fact that Parquet format is used, so I just replaced `format.class`to use Parquet instead of Avro, i.e:

```json
"format.class": "io.confluent.connect.s3.format.parquet.ParquetFormat"`:
```

* Full connector config:

```json
curl -X PUT \
     -H "Content-Type: application/json" \
     --data '{
               "connector.class": "io.confluent.connect.s3.S3SinkConnector",
               "key.converter": "org.apache.kafka.connect.storage.StringConverter",
               "value.converter": "io.confluent.connect.avro.AvroConverter",
               "value.converter.schema.registry.url": "http://schema-registry:8081",
               "tasks.max": "1",
               "topics": "customer_avro",
               "s3.region": "'"$AWS_REGION"'",
               "s3.bucket.name": "'"$AWS_BUCKET_NAME"'",
               "topics.dir": "'"$TAG"'",
               "s3.part.size": 52428801,
               "flush.size": "3",
               "aws.access.key.id" : "'"$AWS_ACCESS_KEY_ID"'",
               "aws.secret.access.key": "'"$AWS_SECRET_ACCESS_KEY"'",
               "storage.class": "io.confluent.connect.s3.storage.S3Storage",
               "format.class": "io.confluent.connect.s3.format.parquet.ParquetFormat",
               "schema.compatibility": "NONE"
          }' \
     http://localhost:8083/connectors/s3-sink/config | jq .
```

<!-- select:end -->
🥁 So...did you reproduce ??

#### **🌟 Results**

* Check the connector status

```bash
$ 15:18:58 ℹ️ 🧩 Displaying connector(s) status
Name                           Status       Tasks                          Stack Trace                                       
-------------------------------------------------------------------------------------------------------------
s3-sink                        ✅ RUNNING  0:🛑 FAILED                   tasks: org.apache.kafka.connect.errors.ConnectException: Exiting WorkerSinkTask due to unrecoverable exception.
        at org.apache.kafka.connect.runtime.WorkerSinkTask.deliverMessages(WorkerSinkTask.java:618)
        at org.apache.kafka.connect.runtime.WorkerSinkTask.poll(WorkerSinkTask.java:334)
        at org.apache.kafka.connect.runtime.WorkerSinkTask.iteration(WorkerSinkTask.java:235)
        at org.apache.kafka.connect.runtime.WorkerSinkTask.execute(WorkerSinkTask.java:204)
        at org.apache.kafka.connect.runtime.WorkerTask.doRun(WorkerTask.java:201)
        at org.apache.kafka.connect.runtime.WorkerTask.run(WorkerTask.java:256)
        at java.base/java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:515)
        at java.base/java.util.concurrent.FutureTask.run(FutureTask.java:264)
        at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1128)
        at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:628)
        at java.base/java.lang.Thread.run(Thread.java:829)
Caused by: java.lang.StackOverflowError
        at org.apache.avro.Schema$RecordSchema.getFields(Schema.java:902)
        at org.apache.parquet.avro.AvroSchemaConverter.convertField(AvroSchemaConverter.java:163)
        at org.apache.parquet.avro.AvroSchemaConverter.convertField(AvroSchemaConverter.java:169)
        at org.apache.parquet.avro.AvroSchemaConverter.convertUnion(AvroSchemaConverter.java:226)
        at org.apache.parquet.avro.AvroSchemaConverter.convertField(AvroSchemaConverter.java:182)
        at org.apache.parquet.avro.AvroSchemaConverter.convertField(AvroSchemaConverter.java:141)
        at org.apache.parquet.avro.AvroSchemaConverter.convertField(AvroSchemaConverter.java:244)
        at org.apache.parquet.avro.AvroSchemaConverter.convertFields(AvroSchemaConverter.java:135)
        at org.apache.parquet.avro.AvroSchemaConverter.convertField(AvroSchemaConverter.java:163)
        at org.apache.parquet.avro.AvroSchemaConverter.convertField(AvroSchemaConverter.java:169)
        at org.apache.parquet.avro.AvroSchemaConverter.convertUnion(AvroSchemaConverter.java:226)
        at org.apache.parquet.avro.AvroSchemaConverter.convertField(AvroSchemaConverter.java:182)
        at org.apache.parquet.avro.AvroSchemaConverter.convertField(AvroSchemaConverter.java:141)
        at org.apache.parquet.avro.AvroSchemaConverter.convertField(AvroSchemaConverter.java:244)
        at org.apache.parquet.avro.AvroSchemaConverter.convertFields(AvroSchemaConverter.java:135)
        at org.apache.parquet.avro.AvroSchemaConverter.convertField(AvroSchemaConverter.java:163)
        at org.apache.parquet.avro.AvroSchemaConverter.convertField(AvroSchemaConverter.java:169)
        at org.apache.parquet.avro.AvroSchemaConverter.convertUnion(AvroSchemaConverter.java:226)
        at org.apache.parquet.avro.AvroSchemaConverter.convertField(AvroSchemaConverter.java:182)
        at org.apache.parquet.avro.AvroSchemaConverter.convertField(AvroSchemaConverter.java:141)
        at org.apache.parquet.avro.AvroSchemaConverter.convertField(AvroSchemaConverter.java:244)
        at org.apache.parquet.avro.AvroSchemaConverter.convertFields(AvroSchemaConverter.java:135)
        at org.apache.parquet.avro.AvroSchemaConverter.convertField(AvroSchemaConverter.java:163)
```

👍 It failed as expected 

Note: You can also check the logs for a pattern `StackOverflowError` ERROR using

```bash
$ playground container logs -c connect --wait-for-log "StackOverflowError"
15:25:00 ℹ️ ⌛ Waiting up to 600 seconds for message StackOverflowError to be present in connect container logs...
java.lang.StackOverflowError
Caused by: java.lang.StackOverflowError
15:25:00 ℹ️ The log is there !
```

* Full example is available [here](https://github.com/vdesabou/kafka-docker-playground/blob/master/academy/connect-connect-aws-s3-sink/s3-sink-repro-000001-stackoverflowerror-with-s3-sink-connector.sh)


<!-- tabs:end -->

## ⭐⭐⭐ Expert

🧑‍🏭 Work in Progress...Come back later !