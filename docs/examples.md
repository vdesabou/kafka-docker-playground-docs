# 🧑‍🎓 Examples

Below is a collection of reproduction models examples.

## ⭐ Beginner

### StackOverflowError with S3 sink connector

<!-- tabs:start -->
#### **🔥 Description**

User is getting StackOverflowError with S3 sink connector.

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

*  🎯 Choose the best [example](https://kafka-docker-playground.io/#/content) to use as basis.

* 🛠 [Bootstrap](http://localhost:3000/#/how-to-build-your-own?id=%f0%9f%9b%a0-bootstrap-reproduction-model) your reproduction model!

#### **📍 Step 2**
<!-- select:start -->
<!-- select-menu-labels: 🙋 see solution for previous step ? -->
#### --No--
#### --Yes--

🛠 Bootstrap reproduction model was done as following:

```bash
cd connect/connect-aws-s3-sink
playground bootstrap-reproduction-model -f s3-sink.sh -d "000001 StackOverflowError with S3 sink connector" -p avro
```

💡 Explanations:

* [s3-sink.sh](https://github.com/vdesabou/kafka-docker-playground/blob/master/connect/connect-aws-s3-sink/s3-sink.sh) is the closest example.
* The problem seems related to input data, so using [avro java producer](https://kafka-docker-playground.io/#/how-to-build-your-own?id=%e2%99%a8%ef%b8%8f-java-producers) seems the right thing to do.

> [!NOTE]
> As the key converter is StringConverter, we should not use `avro-with-key` for `--producer` flag.

<!-- select:end -->

* 👉 Follow steps from [♨️ Java producers](https://kafka-docker-playground.io/#/how-to-build-your-own?id=%e2%99%a8%ef%b8%8f-java-producers) in order to produce same data as user.

#### **📍 Step 3**
<!-- select:start -->
<!-- select-menu-labels: 🙋 see solution for previous step ? -->
#### --No--
#### --Yes--

⌨️ Here are the steps to follow:

<iframe width="100%" height="400" src="https://www.youtube.com/embed/oXDdHh00TFw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>


<!-- select:end -->
👉 Adapt the example to customer details and run it !

> [!TIP]
> Do not forget to [🪄 Specify versions](https://kafka-docker-playground.io/#/how-to-use?id=%f0%9f%aa%84-specify-versions) for CP and Connector before running the test !

#### **📍 Step 4**
<!-- select:start -->
<!-- select-menu-labels: 🙋 see solution for previous step ? -->
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

* Added the version to use at very beginning of script (needs to be before `source ${DIR}/../../scripts/utils.sh`):

```bash
#!/bin/bash
set -e

export TAG=7.3.1
export CONNECTOR_TAG=10.3.3
```

* Then I ran the test:

```bash
./s3-sink-repro-000001-stackoverflowerror-with-s3-sink-connector.sh
```

<!-- select:end -->
🥁 So...did you reproduce ??

#### **🌟 Results**

* Check the connector status

```bash
$ playground connector status
sink  |  s3-sink  |  RUNNING  |  FAILED  |  io.confluent.connect.s3.S3SinkConnector
```

👍 It failed as expected 

* Check the connector logs and search for the `StackOverflowError` ERROR

```bash
$ playground logs -c connect --wait-for-log "StackOverflowError"
23:04:59 ℹ️ ⌛ Waiting up to 600 seconds for message StackOverflowError to be present in connect container logs...
java.lang.StackOverflowError
Caused by: java.lang.StackOverflowError
23:04:59 ℹ️ The log is there !
```

* Full example is available [here](https://github.com/vdesabou/kafka-docker-playground/blob/master/docs-examples/connect-connect-aws-s3-sink/s3-sink-repro-000001-stackoverflowerror-with-s3-sink-connector.sh)


<!-- tabs:end -->