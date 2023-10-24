# 👷‍♂️ How to build your own examples or reproduction models with reusables

Below is a collection of *how to* that you can re-use when you build your own examples or reproduction models.

## 🛠 Bootstrap reproduction model

If you want to create your own reproduction model, follow these steps:

* Go into the directory of the example of your choice
* Choose the script that you want to use as basis
* Execute [🧠 CLI](/cli) with `repro bootstrap` [command](/playground%20repro%20bootstrap)

Examples:

### Basic

```bash
cd connect/connect-hdfs2-sink
playground repro bootstrap -f hdfs2-sink<tab> -d "123456 testing with parquet format"

12:16:35 ℹ️ ✨ Creating file /Users/vsaboulin/Documents/github/kafka-docker-playground/reproduction-models/connect-connect-hdfs2-sink/docker-compose.plaintext.repro-123456-testing-with-parquet-format.yml
12:16:35 ℹ️ ✨ Creating file /Users/vsaboulin/Documents/github/kafka-docker-playground/reproduction-models/connect-connect-hdfs2-sink/hdfs2-sink-repro-123456-testing-with-parquet-format.sh
12:16:35 ℹ️ 📂 The reproduction files are now available in:
/Users/vsaboulin/Documents/github/kafka-docker-playground/reproduction-models/connect-connect-hdfs2-sink
```

### With Java producer (`--producer`)

> [!TIP]
> Most of times, it's much simpler to use `playground topic produce` [CLI](/playground%20topic%20produce)
> 
> Use java producer only if you have very specific requirements such as specifying record timestamp, use key with schema or to do [perf testing](/reusables?id=%f0%9f%91%88-all-sink-connectors)

If you want to automatically generate a Java Producer, use the flag `--producer` (or `-p`):

Example with `protobuf`:

```bash
cd connect/connect-hdfs2-sink
playground repro bootstrap -f hdfs2-sink<tab> -d "123456 testing with parquet format" --producer protobuf

19:54:45 ℹ️ ✨ Creating file /Users/vsaboulin/Documents/github/kafka-docker-playground/reproduction-models/connect-connect-hdfs2-sink/docker-compose.plaintext.repro-123456-testing-with-parquet-format.yml
19:54:45 ℹ️ ✨ Creating file /Users/vsaboulin/Documents/github/kafka-docker-playground/reproduction-models/connect-connect-hdfs2-sink/hdfs2-sink-repro-123456-testing-with-parquet-format.sh

19:54:45 ℹ️ Examples to consume:
19:54:45 ℹ️ 1️⃣ Simplest
docker exec connect kafka-protobuf-console-consumer -bootstrap-server broker:9092 --property schema.registry.url=http://schema-registry:8081 --topic a-topic --from-beginning --max-messages 1
19:54:45 ℹ️ 2️⃣ Displaying key:
docker exec connect kafka-protobuf-console-consumer -bootstrap-server broker:9092 --property schema.registry.url=http://schema-registry:8081 --topic a-topic --property print.key=true --property key.separator=, --from-beginning --max-messages 1
19:54:45 ℹ️ ✨ Adding Java protobuf producer in /Users/vsaboulin/Documents/github/kafka-docker-playground/reproduction-models/connect-connect-hdfs2-sink/producer-repro-123456-1
19:54:45 ℹ️ 📂 The reproduction files are now available in:
/Users/vsaboulin/Documents/github/kafka-docker-playground/reproduction-models/connect-connect-hdfs2-sink
```

This will create the following files:

![file structure](./images/bootstrap_reproduction_model.jpg)

Then follow instructions in one of [♨️ Java producer](/reusables?id=♨%EF%B8%8F-java-producers) below.

### With multiple Java producers (`--nb-producers`)

If you want multiple java producer (to test schema evolution for example), use the flag `--nb-producers` (or `-n`):, for example 2:

```bash
cd connect/connect-hdfs2-sink
playground repro bootstrap -f hdfs2-sink<tab> -d "123456 testing with avro format" --producer avro --nb-producers 2

19:57:16 ℹ️ ✨ Creating file /Users/vsaboulin/Documents/github/kafka-docker-playground/reproduction-models/connect-connect-hdfs2-sink/docker-compose.plaintext.repro-123456-testing-with-avro-format.yml
19:57:16 ℹ️ ✨ Creating file /Users/vsaboulin/Documents/github/kafka-docker-playground/reproduction-models/connect-connect-hdfs2-sink/hdfs2-sink-repro-123456-testing-with-avro-format.sh

19:57:16 ℹ️ ✨ Adding Java avro producer in /Users/vsaboulin/Documents/github/kafka-docker-playground/reproduction-models/connect-connect-hdfs2-sink/producer-repro-123456-2
19:57:16 ℹ️ ✨ Adding Java avro producer in /Users/vsaboulin/Documents/github/kafka-docker-playground/reproduction-models/connect-connect-hdfs2-sink/producer-repro-123456-1
19:57:16 ℹ️ 📂 The reproduction files are now available in:
/Users/vsaboulin/Documents/github/kafka-docker-playground/reproduction-models/connect-connect-hdfs2-sink
```

### With custom SMT (`--custom-smt`)

If you want to add a custom SMT, just add `--custom-smt` flag.

This will create the following files:

![file structure](./images/custom_smt.jpg)

This is a no-op custom SMT:

```java
    @Override
    public R apply(R record) {
        log.info("Applying no-op MyCustomSMT");
        // add your logic here
        return record.newRecord(
            record.topic(),
            record.kafkaPartition(),
            record.keySchema(),
            record.key(),
            record.valueSchema(),
            record.value(),
            record.timestamp()
        );
    }
```

It will also add the required steps to compile code:

```bash
for component in MyCustomSMT-000000
do
    set +e
    log "🏗 Building jar for ${component}"
    docker run -i --rm -e KAFKA_CLIENT_TAG=$KAFKA_CLIENT_TAG -e TAG=$TAG_BASE -v "${DIR}/${component}":/usr/src/mymaven -v "$HOME/.m2":/root/.m2 -v "${DIR}/${component}/target:/usr/src/mymaven/target" -w /usr/src/mymaven maven:3.6.1-jdk-11 mvn -Dkafka.tag=$TAG -Dkafka.client.tag=$KAFKA_CLIENT_TAG package > /tmp/result.log 2>&1
    if [ $? != 0 ]
    then
        logerror "ERROR: failed to build java component "
        tail -500 /tmp/result.log
        exit 1
    fi
    set -e
done
```

It will copy the jar to the connector lib folder:

```bash
log "📂 Copying custom jar to connector folder /usr/share/confluent-hub-components/debezium-debezium-connector-sqlserver/lib/"
docker cp /home/vsaboulin/kafka-docker-playground/scripts/cli/../../reproduction-models/connect-connect-debezium-sqlserver-source/MyCustomSMT-000000/target/MyCustomSMT-1.0.0-SNAPSHOT-jar-with-dependencies.jar connect:/usr/share/confluent-hub-components/debezium-debezium-connector-sqlserver/lib/
log "📂 Copying custom jar to connector folder /usr/share/confluent-hub-components/confluentinc-connect-transforms/lib/"
docker cp /home/vsaboulin/kafka-docker-playground/scripts/cli/../../reproduction-models/connect-connect-debezium-sqlserver-source/MyCustomSMT-000000/target/MyCustomSMT-1.0.0-SNAPSHOT-jar-with-dependencies.jar connect:/usr/share/confluent-hub-components/confluentinc-connect-transforms/lib/
log "♻️ Restart connect worker to load"
docker restart connect
sleep 45
```

And add the transform config to connector:

```json
  "transforms": "MyCustomSMT",
  "transforms.MyCustomSMT.type": "com.github.vdesabou.kafka.connect.transforms.MyCustomSMT",
```

### With pipeline (`--pipeline`)

All the steps to create a pipeline, i.e an example with source and sink connectors are now automated using `--pipeline`flag.

Example:

```bash
$ playground repro bootstrap -f debezium-postgres-source.sh -d "create a pipeline example" --pipeline ../../connect/connect-jdbc-sqlserver-sink/sqlserver-microsoft-sink.sh 
09:01:11 ℹ️ 📂 Output folder is reproduction-models (set with OUTPUT_FOLDER environment variable)
09:01:11 ℹ️ ✨ Creating file /home/vsaboulin/kafka-docker-playground/scripts/cli/../../reproduction-models/connect-connect-debezium-postgresql-source/docker-compose.plaintext.repro-create-a-pipeline-example.yml
09:01:11 ℹ️ ✨ Creating file /home/vsaboulin/kafka-docker-playground/scripts/cli/../../reproduction-models/connect-connect-debezium-postgresql-source/debezium-postgres-source-repro-create-a-pipeline-example.sh
09:01:12 ℹ️ 💱 Source connector is using key.converter io.confluent.connect.avro.AvroConverter
09:01:12 ℹ️ 💱 Source connector is using value.converter io.confluent.connect.avro.AvroConverter
09:01:12 ℹ️ 💱 Sink connector is using default key.converter, i.e org.apache.kafka.connect.storage.StringConverter
09:01:12 ℹ️ 💱 Sink connector is using default value.converter, i.e io.confluent.connect.avro.AvroConverter
09:01:12 ℹ️ 🧑‍🏭 Changing Sink connector value.converter to use same as source:
                "value.converter" : "io.confluent.connect.avro.AvroConverter",
                "value.converter.schema.registry.url": "http://schema-registry:8081",
09:01:13 ℹ️ 🧑‍🏭 Changing Sink connector key.converter to use same as source:
                "key.converter" : "io.confluent.connect.avro.AvroConverter",
                "key.converter.schema.registry.url": "http://schema-registry:8081",
09:01:13 ℹ️ 📂 The reproduction files are now available in:
/home/vsaboulin/kafka-docker-playground/scripts/cli/../../reproduction-models/connect-connect-debezium-postgresql-source
09:01:13 ℹ️ 🚀 Copy/paste the following to get it right away:

cd /home/vsaboulin/kafka-docker-playground/scripts/cli/../../reproduction-models/connect-connect-debezium-postgresql-source
code debezium-postgres-source-repro-create-a-pipeline-example.sh
./debezium-postgres-source-repro-create-a-pipeline-example.sh
```

It will automatically:

* Add sink example to the end of source example
* Modify sink converters (key and value) to use same as source example
* Use same kafka topic for both connectors
* Add all required containers for both sink and source
* Update `CONNECT_PLUGIN_PATH` to include both connectors

See example there:

<iframe width="100%" height="400" src="https://www.youtube.com/embed/TrWipv6DeX8" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>


> [!TIP]
> A complete example is available in [🧑‍🔧 How to build a pipeline](/reusables?id=%f0%9f%a7%91%f0%9f%94%a7-how-to-build-a-pipeline).


## 👉 Producing data

### ♨️ Java producers

<!-- tabs:start -->

#### **Avro**

If you want to send a complex AVRO message, the easiest way is to use an Avro JAVA producer which creates a Specific Record using Maven plugin and populate it using [j-easy/easy-random](https://github.com/j-easy/easy-random).

> [!TIP]
> A complete example is available [here](https://github.com/vdesabou/kafka-docker-playground/blob/master/other/schema-format-avro).

Here are the steps to follow:

1. Bootstrap your reproduction model by following [🛠 Bootstrap reproduction model](/reusables?id=🛠-bootstrap-reproduction-model) and use `avro` for the `--producer` (or `-p`) flag.

2. *optional*: use `--producer-schema-key` and/or `--producer-schema-value` flag(s) to specify another schema(s) to use, if you use this option, step 3 below is **not** required as it is done automatically

3. *not required if step 2 was done* Update `producer-repro-12345/src/main/resources/avro/customer.avsc` with your AVRO schema but be careful, you need to keep `Customer` for the name and `com.github.vdesabou` for the namespace:

```json
    "name": "Customer",
    "namespace": "com.github.vdesabou",
```

By default, the following environment variables are used in producer container:

```yml
    environment:
      KAFKA_BOOTSTRAP_SERVERS: broker:9092
      TOPIC: "customer_avro"
      REPLICATION_FACTOR: 1
      NUMBER_OF_PARTITIONS: 1
      NB_MESSAGES: 10 # -1 for MAX_VALUE
      MESSAGE_BACKOFF: 100 # Frequency of message injection
      KAFKA_ACKS: "all" # default: "1"
      KAFKA_REQUEST_TIMEOUT_MS: 20000
      KAFKA_RETRY_BACKOFF_MS: 500
      KAFKA_CLIENT_ID: "my-java-producer-repro-123456"
      KAFKA_SCHEMA_REGISTRY_URL: "http://schema-registry:8081"
      JAVA_OPTS: ${GRAFANA_AGENT_PRODUCER}
```

But you can specify any [producer config](https://docs.confluent.io/platform/current/installation/configuration/producer-configs.html) you like by prefixing it with `KAFKA_`.

For example, for [retries](https://docs.confluent.io/platform/current/installation/configuration/producer-configs.html#retries):

```yml
      KAFKA_RETRIES: 10
```

In case this is an example with [ccloud](https://kafka-docker-playground.io/#/content?id=%e2%98%81%ef%b8%8f-confluent-cloud), the producer will be generated with Confluent Cloud security automatically:

```yml
    environment:
      KAFKA_BOOTSTRAP_SERVERS: $BOOTSTRAP_SERVERS
      KAFKA_SSL_ENDPOINT_IDENTIFICATION_ALGORITHM: "https"
      KAFKA_SASL_MECHANISM: "PLAIN"
      KAFKA_SASL_JAAS_CONFIG: $SASL_JAAS_CONFIG
      KAFKA_SECURITY_PROTOCOL: "SASL_SSL"
      TOPIC: "customer_avro"
      REPLICATION_FACTOR: 3
      NUMBER_OF_PARTITIONS: 1
      NB_MESSAGES: 10 # -1 for MAX_VALUE
      MESSAGE_BACKOFF: 100 # Frequency of message injection
      KAFKA_ACKS: "all" # default: "1"
      KAFKA_REQUEST_TIMEOUT_MS: 20000
      KAFKA_RETRY_BACKOFF_MS: 500
      KAFKA_CLIENT_ID: "my-java-producer-repro-123456"
      KAFKA_SCHEMA_REGISTRY_URL: $SCHEMA_REGISTRY_URL
      KAFKA_BASIC_AUTH_CREDENTIALS_SOURCE: $BASIC_AUTH_CREDENTIALS_SOURCE
      KAFKA_SCHEMA_REGISTRY_BASIC_AUTH_USER_INFO: $SCHEMA_REGISTRY_BASIC_AUTH_USER_INFO
```

You can also specify environment variables directly when running the producer by using docker exec option `-e`:

Example:

Send 100 messages to topic called "test-topic":

```bash
docker exec -e NB_MESSAGES=100 -e TOPIC="test-topic" producer-repro-12345 bash -c "java -jar producer-1.0.0-jar-with-dependencies.jar"
```

#### **Protobuf**


If you want to send a complex Protobuf message, the easiest way is to use an Protobuf JAVA producer which creates a Protobuf Record using Maven [plugin](https://github.com/os72/protoc-jar-maven-plugin) and populate it using [j-easy/easy-random](https://github.com/j-easy/easy-random).

> [!TIP]
> A complete example is available [here](https://github.com/vdesabou/kafka-docker-playground/tree/master/other/schema-format-protobuf).

Here are the steps to follow:

1. Bootstrap your reproduction model by following [🛠 Bootstrap reproduction model](/reusables?id=🛠-bootstrap-reproduction-model) and use `protobuf` for the `--producer` (or `-p`) flag.

2. *optional*: use `--producer-schema-key` and/or `--producer-schema-value` flag(s) to specify another schema(s) to use, if you use this option, step 3 below is **not** required as it is done automatically

3. *not required if step 2 was done* Update `producer-repro-12345/src/main/resources/Customer.proto` with your Protobuf schema but be careful, you need to keep `Customer` for the name and `com.github.vdesabou` for the package and `CustomerImpl` for the `java_outer_classname`:

```
package com.github.vdesabou;
option java_outer_classname = "CustomerImpl";
```

👉 Make sure to move it in your script to the right place !

By default, the following environment variables are used in producer container:

```yml
    environment:
      KAFKA_BOOTSTRAP_SERVERS: broker:9092
      TOPIC: "customer_protobuf"
      REPLICATION_FACTOR: 1
      NUMBER_OF_PARTITIONS: 1
      NB_MESSAGES: 10 # -1 for MAX_VALUE
      MESSAGE_BACKOFF: 100 # Frequency of message injection
      KAFKA_ACKS: "all" # default: "1"
      KAFKA_REQUEST_TIMEOUT_MS: 20000
      KAFKA_RETRY_BACKOFF_MS: 500
      KAFKA_CLIENT_ID: "my-java-producer-repro-123456"
      KAFKA_SCHEMA_REGISTRY_URL: "http://schema-registry:8081"
      JAVA_OPTS: ${GRAFANA_AGENT_PRODUCER}
```

But you can specify any [producer config](https://docs.confluent.io/platform/current/installation/configuration/producer-configs.html) you like by prefixing it with `KAFKA_`.

For example, for [retries](https://docs.confluent.io/platform/current/installation/configuration/producer-configs.html#retries):

```yml
      KAFKA_RETRIES: 10
```

In case this is an example with [ccloud](https://kafka-docker-playground.io/#/content?id=%e2%98%81%ef%b8%8f-confluent-cloud), the producer will be generated with Confluent Cloud security automatically:

```yml
    environment:
      KAFKA_BOOTSTRAP_SERVERS: $BOOTSTRAP_SERVERS
      KAFKA_SSL_ENDPOINT_IDENTIFICATION_ALGORITHM: "https"
      KAFKA_SASL_MECHANISM: "PLAIN"
      KAFKA_SASL_JAAS_CONFIG: $SASL_JAAS_CONFIG
      KAFKA_SECURITY_PROTOCOL: "SASL_SSL"
      TOPIC: "customer_protobuf"
      REPLICATION_FACTOR: 3
      NUMBER_OF_PARTITIONS: 1
      NB_MESSAGES: 10 # -1 for MAX_VALUE
      MESSAGE_BACKOFF: 100 # Frequency of message injection
      KAFKA_ACKS: "all" # default: "1"
      KAFKA_REQUEST_TIMEOUT_MS: 20000
      KAFKA_RETRY_BACKOFF_MS: 500
      KAFKA_CLIENT_ID: "my-java-producer-repro-123456"
      KAFKA_SCHEMA_REGISTRY_URL: $SCHEMA_REGISTRY_URL
      KAFKA_BASIC_AUTH_CREDENTIALS_SOURCE: $BASIC_AUTH_CREDENTIALS_SOURCE
      KAFKA_SCHEMA_REGISTRY_BASIC_AUTH_USER_INFO: $SCHEMA_REGISTRY_BASIC_AUTH_USER_INFO
```

You can also specify environment variables directly when running the producer by using docker exec option `-e`:

Example:

Send 100 messages to topic called "test-topic":

```bash
docker exec -e NB_MESSAGES=100 -e TOPIC="test-topic" producer-repro-12345 bash -c "java -jar producer-1.0.0-jar-with-dependencies.jar"
```

#### **JSON Schema**

If you want to send a complex JSON Schema message, the easiest way is to use an JSON Schema JAVA producer which creates a JSON Schema Record using Maven [plugin](https://github.com/joelittlejohn/jsonschema2pojo) and populate it using [j-easy/easy-random](https://github.com/j-easy/easy-random).

> [!TIP]
> A complete example is available [here](https://github.com/vdesabou/kafka-docker-playground/tree/master/other/schema-format-json-schema).

> [!WARNING]
> The pojo maven plugin used ([jsonschema2pojo-maven-plugin](https://github.com/joelittlejohn/jsonschema2pojo)) does not [handle](https://github.com/joelittlejohn/jsonschema2pojo/wiki/Reference) `oneOf` so if your json schema is using this, it will not work.  

Here are the steps to follow:

1. Bootstrap your reproduction model by following [🛠 Bootstrap reproduction model](/reusables?id=🛠-bootstrap-reproduction-model) and use `json-schema` for the `--producer` (or `-p`) flag.

2. *optional*: use `--producer-schema-key` and/or `--producer-schema-value` flag(s) to specify another schema(s) to use, if you use this option, step 3 below is **not** required as it is done automatically

3. *not required if step 2 was done* Update `producer-repro-12345/src/main/resources/schema/Customer.json` with your JSON Schema schema but be careful, you need to keep `Customer` for the title:

```json
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
```

By default, the following environment variables are used in producer container:

```yml
    environment:
      KAFKA_BOOTSTRAP_SERVERS: broker:9092
      TOPIC: "customer_json_schema"
      REPLICATION_FACTOR: 1
      NUMBER_OF_PARTITIONS: 1
      NB_MESSAGES: 10 # -1 for MAX_VALUE
      MESSAGE_BACKOFF: 100 # Frequency of message injection
      KAFKA_ACKS: "all" # default: "1"
      KAFKA_REQUEST_TIMEOUT_MS: 20000
      KAFKA_RETRY_BACKOFF_MS: 500
      KAFKA_CLIENT_ID: "my-java-producer-repro-123456"
      KAFKA_SCHEMA_REGISTRY_URL: "http://schema-registry:8081"
      JAVA_OPTS: ${GRAFANA_AGENT_PRODUCER}
```

But you can specify any [producer config](https://docs.confluent.io/platform/current/installation/configuration/producer-configs.html) you like by prefixing it with `KAFKA_`.

For example, for [retries](https://docs.confluent.io/platform/current/installation/configuration/producer-configs.html#retries):

```yml
      KAFKA_RETRIES: 10
```

In case this is an example with [ccloud](https://kafka-docker-playground.io/#/content?id=%e2%98%81%ef%b8%8f-confluent-cloud), the producer will be generated with Confluent Cloud security automatically:

```yml
    environment:
      KAFKA_BOOTSTRAP_SERVERS: $BOOTSTRAP_SERVERS
      KAFKA_SSL_ENDPOINT_IDENTIFICATION_ALGORITHM: "https"
      KAFKA_SASL_MECHANISM: "PLAIN"
      KAFKA_SASL_JAAS_CONFIG: $SASL_JAAS_CONFIG
      KAFKA_SECURITY_PROTOCOL: "SASL_SSL"
      TOPIC: "customer_json_schema"
      REPLICATION_FACTOR: 3
      NUMBER_OF_PARTITIONS: 1
      NB_MESSAGES: 10 # -1 for MAX_VALUE
      MESSAGE_BACKOFF: 100 # Frequency of message injection
      KAFKA_ACKS: "all" # default: "1"
      KAFKA_REQUEST_TIMEOUT_MS: 20000
      KAFKA_RETRY_BACKOFF_MS: 500
      KAFKA_CLIENT_ID: "my-java-producer-repro-123456"
      KAFKA_SCHEMA_REGISTRY_URL: $SCHEMA_REGISTRY_URL
      KAFKA_BASIC_AUTH_CREDENTIALS_SOURCE: $BASIC_AUTH_CREDENTIALS_SOURCE
      KAFKA_SCHEMA_REGISTRY_BASIC_AUTH_USER_INFO: $SCHEMA_REGISTRY_BASIC_AUTH_USER_INFO
```

You can also specify environment variables directly when running the producer by using docker exec option `-e`:

Example:

Send 100 messages to topic called "test-topic":

```bash
docker exec -e NB_MESSAGES=100 -e TOPIC="test-topic" producer-repro-12345 bash -c "java -jar producer-1.0.0-jar-with-dependencies.jar"
```

<!-- tabs:end -->

### 🔤 kafka-console-producer

<!-- tabs:start -->

#### **seq**

```bash
seq -f "This is a message %g" 10 | docker exec -i broker kafka-console-producer --broker-list broker:9092 --topic a-topic
```

#### **Heredoc**

```bash
docker exec -i broker kafka-console-producer --broker-list broker:9092 --topic a-topic << EOF
This is my message 1
This is my message 2
EOF
```

#### **Heredoc JSON**

```bash
docker exec -i broker kafka-console-producer --broker-list broker:9092 --topic a-topic << EOF
{"u_name": "scissors", "u_price": 2.75, "u_quantity": 3}
{"u_name": "tape", "u_price": 0.99, "u_quantity": 10}
{"u_name": "notebooks", "u_price": 1.99, "u_quantity": 5}
EOF
```

#### **Key**

```bash
docker exec -i broker kafka-console-producer --broker-list broker:9092 --topic a-topic --property parse.key=true --property key.separator=, << EOF
key1,value1
key1,value2
key2,value1
EOF
```

#### **Key and JSON**

```bash
docker exec -i broker kafka-console-producer --broker-list broker:9092 --topic a-topic --property parse.key=true --property key.separator=, << EOF
key1,{"u_name": "scissors", "u_price": 2.75, "u_quantity": 3}
key2,{"u_name": "tape", "u_price": 0.99, "u_quantity": 10}
key3,{"u_name": "notebooks", "u_price": 1.99, "u_quantity": 5}
EOF
```

#### **JSON with schema (and key)**

```bash
docker exec -i broker kafka-console-producer --broker-list broker:9092 --topic a-topic --property parse.key=true --property key.separator=, << EOF
1,{"schema":{"type":"struct","fields":[{"type":"string","optional":false,"field":"record"}]},"payload":{"record":"record1"}}
2,{"schema":{"type":"struct","fields":[{"type":"string","optional":false,"field":"record"}]},"payload":{"record":"record2"}}
3,{"schema":{"type":"struct","fields":[{"type":"string","optional":false,"field":"record"}]},"payload":{"record":"record3"}}
EOF
```

<!-- tabs:end -->

### 🔣 kafka-avro-console-producer

<!-- tabs:start -->

#### **seq**

```
seq -f "{\"f1\": \"value%g\"}" 10 | docker exec -i connect kafka-avro-console-producer --broker-list broker:9092 --property schema.registry.url=http://schema-registry:8081 --topic a-topic --property value.schema='{"type":"record","name":"myrecord","fields":[{"name":"f1","type":"string"}]}'
```

#### **Heredoc**

```bash
docker exec -i connect kafka-avro-console-producer --broker-list broker:9092 --property schema.registry.url=http://schema-registry:8081 --topic a-topic --property value.schema='{"type":"record","name":"myrecord","fields":[{"name":"u_name","type":"string"},
{"name":"u_price", "type": "float"}, {"name":"u_quantity", "type": "int"}]}' << EOF
{"u_name": "scissors", "u_price": 2.75, "u_quantity": 3}
{"u_name": "tape", "u_price": 0.99, "u_quantity": 10}
{"u_name": "notebooks", "u_price": 1.99, "u_quantity": 5}
EOF
```

#### **Key**

```bash
docker exec -i connect kafka-avro-console-producer --broker-list broker:9092 --property schema.registry.url=http://schema-registry:8081 --topic a-topic --property key.schema='{"type":"record","namespace": "io.confluent.connect.avro","name":"myrecordkey","fields":[{"name":"ID","type":"long"}]}' --property value.schema='{"type":"record","name":"myrecordvalue","fields":[{"name":"ID","type":"long"},{"name":"product", "type": "string"}, {"name":"quantity", "type": "int"}, {"name":"price",
"type": "float"}]}'  --property parse.key=true --property key.separator="|" << EOF
{"ID": 111}|{"ID": 111,"product": "foo", "quantity": 100, "price": 50}
{"ID": 222}|{"ID": 222,"product": "bar", "quantity": 100, "price": 50}
EOF
```

#### **String Key**

If the key needs to be a string, you can use `key.serializer` to specify it:

```bash
docker exec -i connect kafka-avro-console-producer --broker-list broker:9092 --property schema.registry.url=http://schema-registry:8081 --topic a-topic --property key.serializer=org.apache.kafka.common.serialization.StringSerializer --property value.schema='{"type":"record","name":"myrecordvalue","fields":[{"name":"ID","type":"long"},{"name":"product", "type": "string"}, {"name":"quantity", "type": "int"}, {"name":"price",
"type": "float"}]}'  --property parse.key=true --property key.separator="|" << EOF
111|{"ID": 111,"product": "foo", "quantity": 100, "price": 50}
222|{"ID": 222,"product": "bar", "quantity": 100, "price": 50}
EOF
```


> [!TIP]
> If AVRO schema is very complex, it is better to use [♨️ Java producer](/reusables?id=♨%EF%B8%8F-java-producers) above.

<!-- tabs:end -->

### 🔣 kafka-protobuf-console-producer

<!-- tabs:start -->

#### **seq**

```
seq -f "{\"f1\": \"value%g\"}" 10 | docker exec -i connect kafka-protobuf-console-producer --broker-list broker:9092 --property schema.registry.url=http://schema-registry:8081 --topic a-topic-proto --property value.schema='syntax = "proto3"; message MyRecord { string f1 = 1; }'
```

#### **Heredoc**

```bash
docker exec -i connect kafka-protobuf-console-producer --broker-list broker:9092 --property schema.registry.url=http://schema-registry:8081 --topic a-topic --property value.schema='syntax = "proto3"; message MyRecord { string f1 = 1; }' << EOF
{"f1":"value1"}
{"f1":"value2"}
{"f1":"value3"}
EOF
```

#### **Key**

```bash
docker exec -i connect kafka-protobuf-console-producer --broker-list broker:9092 --property schema.registry.url=http://schema-registry:8081 --topic a-topic --property key.schema='syntax = "proto3"; message MyRecord { string ID = 1; }' --property value.schema='syntax = "proto3"; message MyRecord { string f1 = 1; }'  --property parse.key=true --property key.separator="|" << EOF
{"ID": 111}|{"f1":"value1"}
{"ID": 222}|{"f1":"value2"}
{"ID": 333}|{"f1":"value3"}
EOF
```

<!-- tabs:end -->

> [!TIP]
> If Protobuf schema is very complex, it is better to use [♨️ Java producer](/reusables?id=♨%EF%B8%8F-java-producers) above.


### 🔣 kafka-json-schema-console-producer

<!-- tabs:start -->

#### **seq**

```
seq -f "{\"f1\": \"value%g\"}" 10 | docker exec -i connect kafka-json-schema-console-producer --broker-list broker:9092 --property schema.registry.url=http://schema-registry:8081 --topic a-topic --property value.schema='{"type":"object","properties":{"f1":{"type":"string"}}}'
```

#### **Heredoc**

```bash
docker exec -i connect kafka-json-schema-console-producer --broker-list broker:9092 --property schema.registry.url=http://schema-registry:8081 --topic a-topic --property value.schema='{"type":"object","properties":{"f1":{"type":"string"}}}' << EOF
{"f1":"value1"}
{"f1":"value2"}
{"f1":"value3"}
EOF
```

#### **Key**

```bash
docker exec -i connect kafka-json-schema-console-producer --broker-list broker:9092 --property schema.registry.url=http://schema-registry:8081 --topic a-topic --property key.schema='{"additionalProperties":false,"title":"ID","description":"ID description","type":"object","properties":{"ID":{"description":"ID","type":"integer"}},"required":["ID"]}' --property value.schema='{"type":"object","properties":{"f1":{"type":"string"}}}'  --property parse.key=true --property key.separator="|" << EOF
{"ID": 111}|{"f1": "value1"}
{"ID": 222}|{"f1": "value2"}
EOF
```

<!-- tabs:end -->

> [!TIP]
> If JSON Schema schema is very complex, it is better to use [♨️ Java producer](/reusables?id=♨%EF%B8%8F-java-producers) above.

### 🌪 kafka-producer-perf-test

```bash
docker exec broker kafka-producer-perf-test --topic a-topic --num-records 200000 --record-size 1000 --throughput 100000 --producer-props bootstrap.servers=broker:9092
```

## 👉 Consuming data

Just use [CLI](/cli?id=%f0%9f%93%a5-consume) `playground topic consume`, it's magic !

It you prefer to use legacy way, see below:

### 🔤 [kafka-console-consumer](https://docs.confluent.io/platform/current/tutorials/examples/clients/docs/kafka-commands.html#consume-records)

<!-- tabs:start -->

#### **Simplest**

```
timeout 60 docker exec broker kafka-console-consumer --bootstrap-server broker:9092 --topic a-topic --from-beginning --max-messages 1
```

#### **Display Key**

```bash
timeout 60 docker exec broker kafka-console-consumer --bootstrap-server broker:9092 --topic a-topic --property print.key=true --property key.separator=, --from-beginning --max-messages 1
```


<!-- tabs:end -->


> [!TIP]
> Using `timeout` command prevents the command to run forever.
> It is [ignored](https://github.com/vdesabou/kafka-docker-playground/blob/c65704df7b66a2c47321d04fb75f43a8bbb4fef1/scripts/utils.sh#L650-L658) if not present on your machine.


### 🔣 [kafka-avro-console-consumer](https://docs.confluent.io/platform/current/tutorials/examples/clients/docs/kafka-commands.html#consume-avro-records)

<!-- tabs:start -->

#### **Simplest**

```
docker exec connect kafka-avro-console-consumer -bootstrap-server broker:9092 --property schema.registry.url=http://schema-registry:8081 --topic a-topic --from-beginning --max-messages 1
```

#### **Display Key**

```
docker exec connect kafka-avro-console-consumer -bootstrap-server broker:9092 --property schema.registry.url=http://schema-registry:8081 --topic a-topic --property print.key=true --property key.separator=, --from-beginning --max-messages 1
```

#### **String Key**

If the key is a string, you can use `key.deserializer` to specify it:

```bash
docker exec connect kafka-avro-console-consumer --bootstrap-server broker:9092 --property schema.registry.url=http://schema-registry:8081 --topic a-topic --property print.key=true --property key.deserializer=org.apache.kafka.common.serialization.StringDeserializer --from-beginning --max-messages 1
```

<!-- tabs:end -->
### 🔣 kafka-protobuf-console-consumer

<!-- tabs:start -->

#### **Simplest**

```
docker exec connect kafka-protobuf-console-consumer -bootstrap-server broker:9092 --property schema.registry.url=http://schema-registry:8081 --topic a-topic --from-beginning --max-messages 1
```

#### **Display Key**

```
docker exec connect kafka-protobuf-console-consumer -bootstrap-server broker:9092 --property schema.registry.url=http://schema-registry:8081 --topic a-topic --property print.key=true --property key.separator=, --from-beginning --max-messages 1
```

<!-- tabs:end -->



### 🔣 kafka-json-schema-console-consumer


<!-- tabs:start -->

#### **Simplest**

```
docker exec connect kafka-json-schema-console-consumer -bootstrap-server broker:9092 --property schema.registry.url=http://schema-registry:8081 --topic a-topic --from-beginning --max-messages 1
```

#### **Display Key**

```
docker exec connect kafka-json-schema-console-consumer -bootstrap-server broker:9092 --property schema.registry.url=http://schema-registry:8081 --topic a-topic --property print.key=true --property key.separator=, --from-beginning --max-messages 1
```

<!-- tabs:end -->

## 🧙 How to install other connectors

To run an example with additional connector (or SMT that you can get from Confluent Hub), simply add it to the list of `CONNECT_PLUGIN_PATH`:

Example with S3 source and S3 sink:

```yml
services:
  connect:
    environment:
      CONNECT_PLUGIN_PATH: /usr/share/confluent-hub-components/confluentinc-kafka-connect-s3-source,/usr/share/confluent-hub-components/confluentinc-kafka-connect-s3
```

Example with [confluentinc/connect-transforms](https://www.confluent.io/hub/confluentinc/connect-transforms) SMT:

```yml
services:
  connect:
    environment:
      CONNECT_PLUGIN_PATH: /usr/share/confluent-hub-components/confluentinc-kafka-connect-s3-source,/usr/share/confluent-hub-components/confluentinc-connect-transforms
```

> [!TIP]
> You can also specify versions when specifying multiple connector/SMT, see [here](https://kafka-docker-playground.io/#/how-to-use?id=%f0%9f%94%97-for-connectors).

## 🧑‍🔧 How to build a pipeline

If you want to create a "pipeline" example with both source and sink connectors, this is very simple. You just need [🛠 Bootstrap reproduction model](/reusables?id=🛠-bootstrap-reproduction-model) with [`--pipeline`)](/reusables?id=with-pipeline-pipeline) flag.

Here are the steps to follow to create a [Debezium CDC Microsoft SQL Server Source](https://github.com/vdesabou/kafka-docker-playground/tree/master/connect/connect-debezium-sqlserver-source) to [JDBC PostGreSQL Sink](https://github.com/vdesabou/kafka-docker-playground/tree/master/connect/connect-jdbc-postgresql-sink):

1. Bootstrap your reproduction model by following [🛠 Bootstrap reproduction model](/reusables?id=🛠-bootstrap-reproduction-model) and use an example from [Debezium CDC Microsoft SQL Server Source](https://github.com/vdesabou/kafka-docker-playground/tree/master/connect/connect-debezium-sqlserver-source) and use it with `pipeline` flag set with example from [JDBC PostGreSQL Sink](https://github.com/vdesabou/kafka-docker-playground/tree/master/connect/connect-jdbc-postgresql-sink).

Example:

```bash
$ playground repro bootstrap --file debezium-sqlserver-source.sh --description "pipeline example" --pipeline ../../connect/connect-jdbc-postgresql-sink/postgres-sink.sh 
08:40:49 ℹ️ 📂 Output folder is academy (set with OUTPUT_FOLDER environment variable)
08:40:49 ℹ️ ✨ Creating file /home/vsaboulin/kafka-docker-playground/scripts/cli/../../academy/connect-connect-debezium-sqlserver-source/docker-compose.plaintext.repro-pipeline-example.yml
08:40:49 ℹ️ ✨ Creating file /home/vsaboulin/kafka-docker-playground/scripts/cli/../../academy/connect-connect-debezium-sqlserver-source/debezium-sqlserver-source-repro-pipeline-example.sh
08:40:50 ℹ️ 💱 Source connector is using default key.converter, i.e org.apache.kafka.connect.storage.StringConverter
08:40:50 ℹ️ 💱 Source connector is using default value.converter, i.e io.confluent.connect.avro.AvroConverter
08:40:50 ℹ️ 💱 Sink connector is using default key.converter, i.e org.apache.kafka.connect.storage.StringConverter
08:40:50 ℹ️ 💱 Sink connector is using default value.converter, i.e io.confluent.connect.avro.AvroConverter
08:40:50 ℹ️ 📂 The reproduction files are now available in:
/home/vsaboulin/kafka-docker-playground/scripts/cli/../../academy/connect-connect-debezium-sqlserver-source
08:40:50 ℹ️ 🚀 Copy/paste the following to get it right away:

cd /home/vsaboulin/kafka-docker-playground/scripts/cli/../../academy/connect-connect-debezium-sqlserver-source
code debezium-sqlserver-source-repro-pipeline-example.sh
./debezium-sqlserver-source-repro-pipeline-example.sh
```

1. Open `debezium-sqlserver-source-repro-pipeline-example.sh` and make adjustments as needed. For example in that case, add Debezium SMT `ExtractNewRecordState` and rename topic to `mytable`:

```json
"transforms": "unwrap,RemoveDots",
"transforms.RemoveDots.type": "org.apache.kafka.connect.transforms.RegexRouter",
"transforms.RemoveDots.regex": "(.*)\\.(.*)\\.(.*)",
"transforms.RemoveDots.replacement": "mytable",
"transforms.unwrap.type": "io.debezium.transforms.ExtractNewRecordState"
```

For JDBC sink, adjust topic name to `mytable` and use Flatten SMT:

```json
"topics": "mytable",
"transforms": "flatten",
"transforms.flatten.type": "org.apache.kafka.connect.transforms.Flatten$Value",
"transforms.flatten.delimiter": "."
```

1. Run the test (it is available [there](https://github.com/vdesabou/kafka-docker-playground/blob/master/academy/connect-connect-debezium-sqlserver-source/debezium-sqlserver-source-repro-pipeline-example.sh))

```bash
./debezium-sqlserver-source-repro-pipeline-example.sh
```

Results:

```bash
17:39:31 ℹ️ Create table
Changed database context to 'testDB'.

(1 rows affected)

(1 rows affected)

(1 rows affected)

(1 rows affected)
Job 'cdc.testDB_capture' started successfully.
Job 'cdc.testDB_cleanup' started successfully.
17:39:38 ℹ️ Creating Debezium SQL Server source connector
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  2242  100   975  100  1267   1660   2158 --:--:-- --:--:-- --:--:--  3812
{
  "name": "debezium-sqlserver-source",
  "config": {
    "connector.class": "io.debezium.connector.sqlserver.SqlServerConnector",
    "tasks.max": "1",
    "database.hostname": "sqlserver",
    "database.port": "1433",
    "database.user": "sa",
    "database.password": "Password!",
    "database.names": "testDB",
    "_comment": "new version since 2.x",
    "database.server.name": "server1",
    "database.history.kafka.bootstrap.servers": "broker:9092",
    "database.history.kafka.topic": "schema-changes.inventory",
    "database.encrypt": "false",
    "topic.prefix": "server1",
    "schema.history.internal.kafka.bootstrap.servers": "broker:9092",
    "schema.history.internal.kafka.topic": "schema-changes.inventory",
    "transforms": "unwrap,RemoveDots",
    "transforms.RemoveDots.type": "org.apache.kafka.connect.transforms.RegexRouter",
    "transforms.RemoveDots.regex": "(.*)\\.(.*)\\.(.*)",
    "transforms.RemoveDots.replacement": "mytable",
    "transforms.unwrap.type": "io.debezium.transforms.ExtractNewRecordState",
    "name": "debezium-sqlserver-source"
  },
  "tasks": [],
  "type": "source"
}
Changed database context to 'testDB'.

(1 rows affected)
17:39:44 ℹ️ Verifying topic mytable
{"id":1001,"first_name":"Sally","last_name":"Thomas","email":"sally.thomas@acme.com"}
{"id":1002,"first_name":"George","last_name":"Bailey","email":"gbailey@foobar.com"}
{"id":1003,"first_name":"Edward","last_name":"Walker","email":"ed@walker.com"}
{"id":1004,"first_name":"Anne","last_name":"Kretchmar","email":"annek@noanswer.org"}
{"id":1005,"first_name":"Pam","last_name":"Thomas","email":"pam@office.com"}
Processed a total of 5 messages
17:39:50 ℹ️ Creating JDBC PostgreSQL sink connector
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   937  100   436  100   501   7785   8946 --:--:-- --:--:-- --:--:-- 16732
{
  "name": "postgres-sink",
  "config": {
    "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
    "tasks.max": "1",
    "connection.url": "jdbc:postgresql://postgres/postgres?user=myuser&password=mypassword&ssl=false",
    "topics": "mytable",
    "auto.create": "true",
    "transforms": "flatten",
    "transforms.flatten.type": "org.apache.kafka.connect.transforms.Flatten$Value",
    "transforms.flatten.delimiter": ".",
    "name": "postgres-sink"
  },
  "tasks": [],
  "type": "sink"
}
17:39:55 ℹ️ Show content of mytable table:
  id  | first_name | last_name |         email         
------+------------+-----------+-----------------------
 1001 | Sally      | Thomas    | sally.thomas@acme.com
 1002 | George     | Bailey    | gbailey@foobar.com
 1003 | Edward     | Walker    | ed@walker.com
 1004 | Anne       | Kretchmar | annek@noanswer.org
 1005 | Pam        | Thomas    | pam@office.com
(5 rows)
```

## 🐛 Debugging tools

### ✨ Remote debugging

Java Remote debugging is the perfect tool for troubleshooting Kafka connectors for example.

> [!TIP]
> Following are instructions for [Visual Studio Code ](https://code.visualstudio.com/docs/java/java-debugging), but it is exactly the same principle for [IntelliJ IDEA](https://www.jetbrains.com/help/idea/tutorial-remote-debug.html#436b3b68).

#### ☑️ Prerequisites

Make sure you have already the required Visual Studio code extensions by following [this](https://code.visualstudio.com/docs/java/java-debugging#_install).

#### 💫 Full example

Here is a full example using [HDFS 2 sink](https://github.com/vdesabou/kafka-docker-playground/tree/master/connect/connect-hdfs2-sink) connector and [Visual Studio Code ](https://code.visualstudio.com/docs/java/java-debugging):

1. Launch the example as usual, i.e start `./hdfs2-sink.sh`.

2. Clone and open [`confluentinc/kafka-connect-hdfs`](https://github.com/confluentinc/kafka-connect-hdfs) repository in Visual Studio Code.

3. Switch to the branch corresponding to the connector version you're going to run. 
 
In my example, the connector version is `10.1.1`, so I'm switching to branch tag `v10.1.1`:

![remote_debugging](./images/remote_debugging2.jpg)

4. Execute [🧠 CLI](/cli) with `enable-remote-debugging` command:

```bash
$ playground debug enable-remote-debugging -c connect
namenode is up-to-date
zookeeper is up-to-date
hive-metastore-postgresql is up-to-date
datanode is up-to-date
presto-coordinator is up-to-date
hive-server is up-to-date
hive-metastore is up-to-date
broker is up-to-date
schema-registry is up-to-date
Recreating connect ... done
control-center is up-to-date
15:34:36 ℹ️ If you use Visual Studio Code:
15:34:36 ℹ️ Edit .vscode/launch.json with
15:34:36 ℹ️ 
{
    "version": "0.2.0",
    "configurations": [
    
        {
            "type": "java",
            "name": "Debug connect container",
            "request": "attach",
            "hostName": "127.0.0.1",
            "port": 5005,
            "timeout": 30000
        }
    ]
}

15:34:36 ℹ️ See https://kafka-docker-playground.io/#/reusables?id=✨-remote-debugging
```
   
5. [Configure](https://code.visualstudio.com/docs/java/java-debugging#_configure) remote debugging by clicking on menu `Run`->`Add Configuration...`:

![remote_debugging](./images/remote_debugging1.jpg)

Then copy/paste the following entry:

```json
{
    "type": "java",
    "name": "Debug connect container",
    "request": "attach",
    "hostName": "127.0.0.1",
    "port": 5005,
    "timeout": 30000
}
```

Note: you can also directly edit file `.vscode/launch.json`:

```json
{
    "version": "0.2.0",
    "configurations": [
    
        {
            "type": "java",
            "name": "Debug connect container",
            "request": "attach",
            "hostName": "127.0.0.1",
            "port": 5005,
            "timeout": 30000
        }
    ]
}
```

*Example:*

![remote_debugging](./images/remote_debugging3.jpg)

5. Go in `Run and Debug` and make sure to select the `Debug Connect container` config:

![remote_debugging](./images/remote_debugging5.jpg)

7. Click on the green play button

![remote_debugging](./images/remote_debugging6.jpg)

8. Add breakpoint(s) where you want, for example [here](https://github.com/confluentinc/kafka-connect-hdfs/blob/9a5e68d7294a79c40050efd7b51d7428c7f7c4d5/src/main/java/io/confluent/connect/hdfs/TopicPartitionWriter.java#L894):

![remote_debugging](./images/remote_debugging4.jpg)

9. Process some messages:

```bash
seq -f "{\"f1\": \"value%g\"}" 10 | docker exec -i connect kafka-avro-console-producer --broker-list broker:9092 --property schema.registry.url=http://schema-registry:8081 --topic test_hdfs --property value.schema='{"type":"record","name":"myrecord","fields":[{"name":"f1","type":"string"}]}'
```

10. See results 🍿:

![remote_debugging](./images/remote_debugging7.jpg)

![remote_debugging](https://github.com/vdesabou/gifs/raw/master/docs/images/remote_debugging.gif)


Note (*for Confluent employees because control center code is proprietary*): for `control-center`, you can use following override (note the `5006` port in order to avoid clash with `connect` port):

```yml
  control-center:
    ports:
      - "9021:9021"
      - "5006:5006"
    environment:
      CONTROL_CENTER_OPTS: "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=0.0.0.0:5006"
```

### 🔗 Connectors

In order to enable `TRACE`(or `DEBUG`) logs for connectors, use the `admin/loggers` endpoint (see docs [here](https://docs.confluent.io/platform/current/connect/logging.html#change-the-log-level-for-a-specific-logger)):

*Example:*

```bash
curl --request PUT \
  --url http://localhost:8083/admin/loggers/io.confluent.connect.oracle.cdc \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --data '{
	"level": "TRACE"
}'
```

> [!WARNING]
> Make sure to update `io.confluent.connect.oracle.cdc` above with the package you want to troubleshoot.

Useful packages:

* `io.confluent.kafka.schemaregistry.client.rest.RestService`: to track schema registry requests
* `org.apache.kafka.connect.runtime.TransformationChain`: to see records before, during and after SMT

### 🔑 SSL debug

Add `-Djavax.net.debug=all` in your `docker-compose` file:

*Example:*

```yml
  connect:
    KAFKA_OPTS: -Djavax.net.debug=all
```

### 🔒 Kerberos debug

Add `-Dsun.security.krb5.debug=true` in your `docker-compose` file:

*Example:*

```yml
  connect:
    KAFKA_OPTS: -Dsun.security.krb5.debug=true
```

### 🔬 Class loading

Add `-verbose:class` in your `docker-compose` file to troubleshoot a `ClassNotFoundException` for example:

*Example:*

```yml
  connect:
    environment:
      KAFKA_OPTS: -verbose:class
```

In logs, you'll see:

```log
[Loaded org.apache.kafka.connect.runtime.isolation.DelegatingClassLoader$$Lambda$20/1007251739 from org.apache.kafka.connect.runtime.isolation.DelegatingClassLoader]
[Loaded java.lang.invoke.LambdaForm$MH/1556595366 from java.lang.invoke.LambdaForm]
[Loaded org.reflections.util.ConfigurationBuilder from file:/usr/share/java/kafka/reflections-0.9.12.jar]
[Loaded org.reflections.serializers.Serializer from file:/usr/share/java/kafka/reflections-0.9.12.jar]
[Loaded org.reflections.adapters.MetadataAdapter from file:/usr/share/java/kafka/reflections-0.9.12.jar]
[Loaded org.reflections.scanners.Scanner from file:/usr/share/java/kafka/reflections-0.9.12.jar]
[Loaded org.reflections.scanners.AbstractScanner from file:/usr/share/java/kafka/reflections-0.9.12.jar]
[Loaded org.reflections.scanners.TypeAnnotationsScanner from file:/usr/share/java/kafka/reflections-0.9.12.jar]
[Loaded org.reflections.scanners.AbstractScanner$$Lambda$21/1725097945 from org.reflections.scanners.AbstractScanner]
[Loaded org.reflections.scanners.SubTypesScanner from file:/usr/share/java/kafka/reflections-0.9.12.jar]
[Loaded org.reflections.util.FilterBuilder from file:/usr/share/java/kafka/reflections-0.9.12.jar]
[Loaded org.reflections.util.FilterBuilder$Matcher from file:/usr/share/java/kafka/reflections-0.9.12.jar]
```

### 🕸️ Debug ServiceNow or Salesforce

Those connectors use low level [com.google.api.client.http](https://developers.google.com/api-client-library/java) library.

In order to activate debug logs to see requests/responses, you can just add the `volumes` mount with existing `../../connect/connect-servicenow-source/nginx-proxy/logging.properties` file and add `KAFKA_OPTS: -Djava.util.logging.config.file=/tmp/logging.properties`:

Example:

```yml
  connect:
    volumes:
      - ../../connect/connect-servicenow-source/nginx-proxy/logging.properties:/tmp/logging.properties
    environment:
      KAFKA_OPTS: -Djava.util.logging.config.file=/tmp/logging.properties
```

This is how the `logging.properties` looks like:

```bash
$ cat /tmp/logging.properties
handlers=java.util.logging.ConsoleHandler
java.util.logging.ConsoleHandler.level=ALL
com.google.api.client.http.level=ALL
```

### 🌍 Debug HTTP sink

This connector use low level [Apache HTTP client](https://hc.apache.org/httpcomponents-client-5.2.x/) library.

In order to activate debug logs to see requests/responses, you can use `jcl-over-slf4j-2.0.7.jar` (wget https://repo1.maven.org/maven2/org/slf4j/jcl-over-slf4j/2.0.7/jcl-over-slf4j-2.0.7.jar):

Example:

```yml
  connect:
    volumes:
      - ../../connect/connect-http-sink/jcl-over-slf4j-2.0.7.jar:/usr/share/confluent-hub-components/confluentinc-kafka-connect-http/lib/jcl-over-slf4j-2.0.7.jar
```

> [!NOTE]
> It is already set in all HTTP sink examples.

Then you can enable TRACE logs on `org.apache.http`:

```bash
$ playground debug log-level set --package "org.apache.http" --level TRACE
```

or legacy way:

```bash
curl --request PUT \
  --url http://localhost:8083/admin/loggers/org.apache.http \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --data '{
 "level": "TRACE"
}'
```

### 🕵 TCP Dump

It is sometime necessary to sniff the network in order to better understand what's going on.

Just use [CLI](/cli?id=%f0%9f%8e%af-thread-dump) `playground debug tcp-dump`.

```bash
playground debug tcp-dump --help
playground debug tcp-dump - 🕵️‍♂️ Take a tcp dump (sniffing network)

== Usage ==
  playground debug tcp-dump [OPTIONS]
  playground debug tcp-dump --help | -h

== Options ==
  --container, -c CONTAINER
    🐳 Container name
    Default: connect

  --port PORT
    Port on which tcp dump should be done, if not set sniffing is done on every
    port

  --duration DURATION
    Duration of the dump (default is 30 seconds).
    Default: 30

  --help, -h
    Show this help

Examples
  playground debug tcp-dump --container control-center --port 9021 --duration 60
```

### 👻 Heap Dump

It is sometime necessary to get a [heap dump](https://www.baeldung.com/java-heap-dump-capture).

Just use [CLI](/cli?id=%f0%9f%8e%af-thread-dump) `playground debug heap-dump`.

```bash
$ playground debug heap-dump --help  
playground debug heap-dump

  👻 Take a heap dump
  
  🔖 It will save output to a .hprof file. VisualVM (https://visualvm.github.io/)
  or MAT (https://www.eclipse.org/mat/) can be used to read the file.

== Usage ==
  playground debug heap-dump [OPTIONS]
  playground debug heap-dump --help | -h

== Options ==
  --container, -c CONTAINER
    🐳 Container name
    Default: connect

  --help, -h
    Show this help

Examples
  playground debug heap-dump
  playground debug heap-dump --container broker
```

You can also set `-XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/tmp` to generate heap dump automatically when hitting OOM:

Example:

```yml
  connect:
    environment:
      KAFKA_OPTS: -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/tmp
      KAFKA_HEAP_OPTS: " -Xms2G -Xmx4G"
```

### 🎯 Thread Dump

It is sometime necessary to get a [Java thread dump](https://www.baeldung.com/java-thread-dump).

Just use [CLI](/cli?id=%f0%9f%8e%af-thread-dump) `playground debug thread-dump`.

```bash
$ playground debug thread-dump --help
playground debug thread-dump

  🎯 Take a java thread dump
  
  🔖 It will save output to a file and open with text editor set with config.ini
  (default is code)

== Usage ==
  playground debug thread-dump [OPTIONS]
  playground debug thread-dump --help | -h

== Options ==
  --container, -c CONTAINER
    🐳 Container name
    Default: connect

  --help, -h
    Show this help

Examples
  playground debug thread-dump
  playground debug thread-dump --container broker
```
You can use [Thread Dump Analyzer](http://the-babel-tower.github.io/tda.html) for example to analyze results.

### 🛩️ Flight Recorder

It is sometime necessary to monitor with [Flight Recorder](https://www.baeldung.com/java-flight-recorder-monitoring).

Just use [CLI](/cli?id=%f0%9f%8e%af-thread-dump) `playground debug flight-recorder`.

```bash
$ playground debug flight-recorder --help 
playground debug flight-recorder

  🛩️ Record flight recorder
  
  Read more about it at https://www.baeldung.com/java-flight-recorder-monitoring
  
  Open the jfr file with JDK Mission Control JMC(https://jdk.java.net/jmc/)

== Usage ==
  playground debug flight-recorder [OPTIONS]
  playground debug flight-recorder --help | -h

== Options ==
  --container, -c CONTAINER
    🐳 Container name
    Default: connect

  --action ACTION (required)
    🟢 start or stop
    Allowed: start, stop

  --help, -h
    Show this help

Examples
  playground debug flight-recorder --action start
  playground debug flight-recorder --action stop
```

## 🚫 Blocking traffic

It is sometime necessary for a reproduction model to simulate network issues like blocking incoming or outgoing traffic.

Just use [CLI](/cli?id=%f0%9f%8e%af-thread-dump) `playground debug block-traffic`.

```bash
$ playground debug block-traffic --help
playground debug block-traffic - 🚫 Blocking traffic using iptables

== Usage ==
  playground debug block-traffic [OPTIONS]
  playground debug block-traffic --help | -h

== Options ==
  --container, -c CONTAINER
    🐳 Container name
    Default: connect

  --destination DESTINATION (required)
    Destination: it could be an ip address, a container name or a hostname

  --port PORT
    Port on which tcp traffic should be blocked

  --action ACTION (required)
    🟢 start or stop
    Allowed: start, stop

  --help, -h
    Show this help

Examples
  playground debug block-traffic --destination google.com --action start
  playground debug block-traffic --container broker --destination zookeeper
  --action start
```

## 🐌 Add latency

It is sometime necessary for a reproduction model to simulate latency between components.

The [connect image](/how-it-works?id=🔗-connect-image-used) used by the playground contains [`tc`](https://man7.org/linux/man-pages/man8/tc.8.html) tool, and most importantly contains functions [`add_latency()`](https://github.com/vdesabou/kafka-docker-playground/blob/495578d413ff6b9db1d612ee8b1ebdf695f7ab51/scripts/utils.sh#L1062-L1095), [`get_latency()`](https://github.com/vdesabou/kafka-docker-playground/blob/495578d413ff6b9db1d612ee8b1ebdf695f7ab51/scripts/utils.sh#L1052-L1059)` and `[clear_traffic_control()](https://github.com/vdesabou/kafka-docker-playground/blob/495578d413ff6b9db1d612ee8b1ebdf695f7ab51/scripts/utils.sh#L1039-L1050)`:

> [!TIP]
> A complete example is available [here](https://github.com/vdesabou/kafka-docker-playground/blob/master/connect/connect-servicenow-source/servicenow-source-repro-read-timeout.sh).

*Example:*

Adding latency from `nginx_proxy` to `connect`:

```bash
add_latency nginx_proxy connect 25000ms

latency_put=$(get_latency nginx_proxy connect)
log "Latency from nginx_proxy to connect AFTER traffic control: $latency_put ms"

log "Clear traffic control"
clear_traffic_control nginx_proxy
```

`connect` image has `tc` installed but if you want to use it with broker for example, you need to install it, for example:

```bash
docker exec --privileged --user root -i broker bash -c 'yum install -y libmnl && wget http://vault.centos.org/8.1.1911/BaseOS/x86_64/os/Packages/iproute-tc-4.18.0-15.el8.x86_64.rpm && rpm -i --nodeps --nosignature http://vault.centos.org/8.1.1911/BaseOS/x86_64/os/Packages/iproute-tc-4.18.0-15.el8.x86_64.rpm'
```

## 🏚 Simulate TCP connections problems

[emicklei/zazkia](https://github.com/emicklei/zazkia) is a nice tool to simulate a TCP connection issues (reset,delay,throttle,corrupt).

Here is an example with HDFS 2 sink connector:

1. Create a folder `zazkia`and put the config file `zazkia-routes.json` in there, with the config you want:

```json
[
    {
        "label": "hdfs",
        "service-hostname": "namenode",
        "service-port": 8020,
        "listen-port": 49998,
        "transport": {
            "accept-connections": true,
            "throttle-service-response": 0,
            "delay-service-response": 0,
            "break-service-response": 0,
            "service-response-corrupt-method": "",
            "sending-to-client": true,
            "receiving-from-client": true,
            "sending-to-service": true,
            "receiving-from-service": true,
            "verbose": true
        }
    }
]
```

2. In docker-compose, add the following:

```yml
  zazkia:
    hostname: zazkia
    container_name: zazkia
    image: emicklei/zazkia
    ports:
      - "9191:9191"
    volumes:
      - ../../connect/connect-azure-blob-storage-sink/zazkia:/data
```

3. In connector config, update `store.url`with `hdfs://zazkia:49998`:

```bash
curl -X PUT \
     -H "Content-Type: application/json" \
     --data '{
               "connector.class":"io.confluent.connect.hdfs.HdfsSinkConnector",
               "tasks.max":"1",
               "topics":"test_hdfs",
               "store.url":"hdfs://zazkia:49998",
               "flush.size":"3",
               "hadoop.conf.dir":"/etc/hadoop/",
               "partitioner.class":"io.confluent.connect.hdfs.partitioner.FieldPartitioner",
               "partition.field.name":"f1",
               "rotate.interval.ms":"120000",
               "logs.dir":"/tmp",
               "hive.integration": "true",
               "hive.metastore.uris": "thrift://hive-metastore:9083",
               "hive.database": "testhive",
               "confluent.license": "",
               "confluent.topic.bootstrap.servers": "broker:9092",
               "confluent.topic.replication.factor": "1",
               "key.converter":"org.apache.kafka.connect.storage.StringConverter",
               "value.converter":"io.confluent.connect.avro.AvroConverter",
               "value.converter.schema.registry.url":"http://schema-registry:8081",
               "schema.compatibility":"BACKWARD"
          }' \
     http://localhost:8083/connectors/hdfs-sink/config | jq .
```

4. zazkia UI is available on [http://localhost:9191](http://localhost:9191)

## 🌐 Using HTTPS proxy

There are several connector examples which include HTTPS proxy (check for `also with 🌐 proxy` in the **[Content](/content.md)** section).

> [!TIP]
> A complete example is available [here](https://github.com/vdesabou/kafka-docker-playground/blob/master/connect/connect-aws-s3-sink/s3-sink-proxy.sh). 

Here are the steps to follow:

1. Copy [`connect/connect-aws-s3-sink/nginx-proxy`](https://github.com/vdesabou/kafka-docker-playground/tree/master/connect/connect-aws-s3-sink/nginx-proxy) directory into your test directory.

2. Update [`connect/connect-aws-s3-sink/nginx-proxy/nginx_whitelist.conf`](https://github.com/vdesabou/kafka-docker-playground/blob/master/connect/connect-aws-s3-sink/nginx-proxy/nginx_whitelist.conf) with the domain name required for your needs.

*Example:*

```conf
        server_name  service-now.com;
        server_name  *.service-now.com;
```

> [!TIP]
> If you need a proxy to reach another docker container, as opposed to a domain, use following example, where `schema-registry` is the name of the container:
> 

```
http {
    access_log /var/log/nginx_access.log;
    error_log /var/log/nginx_errors.log;

    upstream docker-schema-registry {
        server schema-registry:8081;
    }

    server {
        listen       8888;
        location / {
            proxy_pass         http://docker-schema-registry;
            proxy_redirect     off;
            proxy_set_header   Host $host;
            proxy_set_header   X-Real-IP $remote_addr;
            proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header   X-Forwarded-Host $server_name;
        }
    }
}
```

3. Add this in your `docker-compose` file:

```yml
  nginx-proxy:
    image: reiz/nginx_proxy:latest
    hostname: nginx-proxy
    container_name: nginx-proxy
    ports:
      - "8888:8888"
    volumes:
      - ../../connect/connect-aws-s3-sink/nginx-proxy/nginx_whitelist.conf:/usr/local/nginx/conf/nginx.conf
```

> [!WARNING]
> Make sure to update `../../connect/connect-aws-s3-sink` above with the right path.

4. [Optional] In order to make sure the proxy is used, you can set `dns: 0.0.0.0` in the connect instance, so that there is no internet connectivity.

```yml
  connect:
    <snip>
    environment:
      <snip>
    dns: 0.0.0.0
```

5. In you connector configuration, update the proxy configuration parameter with `https://nginx-proxy:8888`.

*Example:*

```json
"s3.proxy.url": "https://nginx-proxy:8888"
```

> [!NOTE]
> If your proxy requires HTTP2 support, there is a full example available in this example: [GCP Pub/Sub Source connector](https://github.com/vdesabou/kafka-docker-playground/blob/master/connect/connect-gcp-pubsub-source/gcp-pubsub-nginx-proxy.sh)

### 🔐 Proxy with BASIC authentication

If you want to setup BASIC authentication, you can use [ubuntu/squid](https://hub.docker.com/r/ubuntu/squid) image.

> [!TIP]
> Some complete examples are available [here](https://github.com/vdesabou/kafka-docker-playground/blob/master/connect/connect-aws-s3-sink/s3-sink-proxy-basic-auth.sh) and [there](https://github.com/vdesabou/kafka-docker-playground/blob/master/connect/connect-salesforce-platform-events-sink/salesforce-platform-events-sink-proxy-basic-auth.sh)

* in your `docker-compose`, add `squid` as below:


```yml
  squid:
    image: ubuntu/squid
    hostname: squid
    container_name: squid
    ports:
      - "8888:8888"
    volumes:
      - ../../connect/connect-aws-s3-sink/squid/passwords:/etc/squid/passwords
      - ../../connect/connect-aws-s3-sink/squid/squid.conf:/etc/squid/squid.conf
```

Proxy details:

* container: squid
* port: 8888
* user: admin
* password: 1234

Example with S3 sink:

```json
  "s3.proxy.url": "https://squid:8888",
  "s3.proxy.user": "admin",
  "s3.proxy.password": "1234",
```

Example with Salesforce:

```json
  "http.proxy": "squid:8888",
  "http.proxy.auth.scheme": "BASIC",
  "http.proxy.user": "admin",
  "http.proxy.password": "1234",
```

## ♨️ Using specific JDK

It is sometime necessary for an investigation to replace JDK installed on connect image for example.

Here are some examples:

### 🌀 Azul Zulu JDK

Here are the steps to follow:

1. Get the JDK `.rpm` version link you want to install from the [website](https://www.azul.com/downloads). In our example, that will be `https://cdn.azul.com/zulu/bin/zulu11.48.21-ca-jdk11.0.11-linux.x86_64.rpm`

2. Add this in your `docker-compose` file:

```yml
  connect:
    build:
      context: ../../connect/connect-filestream-sink/
      args:
        CP_CONNECT_IMAGE: ${CP_CONNECT_IMAGE}
        CONNECT_TAG: ${CONNECT_TAG}
```
> [!WARNING]
> Make sure to update `context` above with the right path.

3. Create a `Dockerfile` file in `context` directory above (`../../connect/connect-filestream-sink/`).

Example with JDK 11:

```yml
ARG CP_CONNECT_IMAGE
ARG CONNECT_TAG
FROM ${CP_CONNECT_IMAGE}:${CONNECT_TAG}
USER root
RUN wget https://cdn.azul.com/zulu/bin/zulu11.48.21-ca-jdk11.0.11-linux.x86_64.rpm && yum install -y zulu11.48.21-ca-jdk11.0.11-linux.x86_64.rpm && alternatives --set java /usr/lib/jvm/zulu-11/bin/java
USER appuser
```

Another example with JDK 8:

```yml
ARG CP_CONNECT_IMAGE
ARG CONNECT_TAG
FROM ${CP_CONNECT_IMAGE}:${CONNECT_TAG}
USER root
RUN wget https://cdn.azul.com/zulu/bin/zulu8.60.0.21-ca-jdk8.0.322-linux.x86_64.rpm && yum install -y zulu8.60.0.21-ca-jdk8.0.322-linux.x86_64.rpm && alternatives --set java /usr/lib/jvm/zulu-8/jre/bin/java
USER appuser
```


> [!WARNING]
> Make sure to update `alternatives --set java` above with the right path.

4. Verify the correct JDK version is installed once your test is started:

```bash
docker exec connect java -version
openjdk version "11.0.11" 2021-04-20 LTS
OpenJDK Runtime Environment Zulu11.48+21-CA (build 11.0.11+9-LTS)
OpenJDK 64-Bit Server VM Zulu11.48+21-CA (build 11.0.11+9-LTS, mixed mode)
```

### ⭕️ Oracle JDK

Here are the steps to follow:

1. Get the Oracle JDK `.rpm` version link you want to install from the [website](https://www.oracle.com/java/technologies/downloads/). In our example, that will be `jdk-8u201-linux-x64.rpm`

2. Add this in your `docker-compose` file:

```yml
  connect:
    build:
      context: ../../connect/connect-filestream-sink/
      args:
        CP_CONNECT_IMAGE: ${CP_CONNECT_IMAGE}
        CONNECT_TAG: ${CONNECT_TAG}
```
> [!WARNING]
> Make sure to update `context` above with the right path.

3. Create a `Dockerfile` file in `context` directory above (`../../connect/connect-filestream-sink/`).

```yml
ARG CONNECT_TAG
FROM ${CP_CONNECT_IMAGE}:${TAG}
COPY jdk-8u201-linux-x64.rpm /tmp/
USER root
RUN yum -y install /tmp/jdk-8u201-linux-x64.rpm && alternatives --set java /usr/java/jdk1.8.0_201-amd64/jre/bin/java && rm /tmp/jdk-8u201-linux-x64.rpm
USER appuser
```

> [!WARNING]
> Make sure to update `alternatives --set java` above with the right path.

4. Verify the correct JDK version is installed once your test is started:

```bash
docker exec connect java -version
java version "1.8.0_201"
Java(TM) SE Runtime Environment (build 1.8.0_201-b09)
Java HotSpot(TM) 64-Bit Server VM (build 25.201-b09, mixed mode)
```

## 🏎️ Performance testing

Here are some tips and tricks to create reproduction models that require high volume of data.

> [!TIP]
> It is highly recommended to enable [JMX Grafana](https://kafka-docker-playground.io/#/how-to-use?id=%f0%9f%93%8a-enabling-jmx-grafana) when you're doing performance testing, to see CPU/Memory and all JMX metrics.

### 👈 All sink connectors

Injecting lot of records into topic(s) is really easy using [🛠 Bootstrap reproduction model](https://kafka-docker-playground.io/#/reusables?id=%f0%9f%9b%a0-bootstrap-reproduction-model) with [♨️ Java producers](https://kafka-docker-playground.io/#/reusables?id=%e2%99%a8%ef%b8%8f-java-producers) option.

To inject infinite number of requests as fast as possible, use `NB_MESSAGES=-1` and `MESSAGE_BACKOFF=0` and use `-d` to run the injection in the background:

```bash
docker exec -e NB_MESSAGES=-1 -e MESSAGE_BACKOFF=0 -e TOPIC="test-topic" -d producer-repro-12345 bash -c "java -jar producer-1.0.0-jar-with-dependencies.jar"
```

If load is not enough, you can start multiple producers in parallel:

```bash
docker exec -e NB_MESSAGES=-1 -e MESSAGE_BACKOFF=0 -e TOPIC="test-topic" -d producer-repro-12345 bash -c "java -jar producer-1.0.0-jar-with-dependencies.jar"
docker exec -e NB_MESSAGES=-1 -e MESSAGE_BACKOFF=0 -e TOPIC="test-topic" -d producer-repro-12345 bash -c "java -jar producer-1.0.0-jar-with-dependencies.jar"
docker exec -e NB_MESSAGES=-1 -e MESSAGE_BACKOFF=0 -e TOPIC="test-topic" -d producer-repro-12345 bash -c "java -jar producer-1.0.0-jar-with-dependencies.jar"
docker exec -e NB_MESSAGES=-1 -e MESSAGE_BACKOFF=0 -e TOPIC="test-topic" -d producer-repro-12345 bash -c "java -jar producer-1.0.0-jar-with-dependencies.jar"
docker exec -e NB_MESSAGES=-1 -e MESSAGE_BACKOFF=0 -e TOPIC="test-topic" -d producer-repro-12345 bash -c "java -jar producer-1.0.0-jar-with-dependencies.jar"

docker exec -e NB_MESSAGES=-1 -e MESSAGE_BACKOFF=0 -e TOPIC="test-topic2" -d producer-repro-12345 bash -c "java -jar producer-1.0.0-jar-with-dependencies.jar"
docker exec -e NB_MESSAGES=-1 -e MESSAGE_BACKOFF=0 -e TOPIC="test-topic2" -d producer-repro-12345 bash -c "java -jar producer-1.0.0-jar-with-dependencies.jar"
docker exec -e NB_MESSAGES=-1 -e MESSAGE_BACKOFF=0 -e TOPIC="test-topic2" -d producer-repro-12345 bash -c "java -jar producer-1.0.0-jar-with-dependencies.jar"
docker exec -e NB_MESSAGES=-1 -e MESSAGE_BACKOFF=0 -e TOPIC="test-topic2" -d producer-repro-12345 bash -c "java -jar producer-1.0.0-jar-with-dependencies.jar"
docker exec -e NB_MESSAGES=-1 -e MESSAGE_BACKOFF=0 -e TOPIC="test-topic2" -d producer-repro-12345 bash -c "java -jar producer-1.0.0-jar-with-dependencies.jar"
```

### 👉 Oracle

For all Oracle CDC and JDBC source connector with Oracle examples, you can easily inject load in table using, the following steps.

You can enable this by setting flag `--enable-sql-datagen`, it will start inserting rows at the end of the example for a duration that you can configure:

Example:

```bash
DURATION=10
log "Injecting data for $DURATION minutes"
docker exec -d oracle-datagen bash -c "java ${JAVA_OPTS} -jar oracle-datagen-1.0-SNAPSHOT-jar-with-dependencies.jar --host oracle --username C##MYUSER --password mypassword --sidOrServerName sid --sidOrServerNameVal ORCLCDB --maxPoolSize 10 --durationTimeMin $DURATION"
```

> [!TIP]
> You can increase throughtput with `maxPoolSize`.

### 👉 Microsoft SQL Server

For all Debezium and JDBC source connector with Microsoft SQL Server examples, you can easily inject load in table using, the following steps.

You can enable this by setting flag `enable-sql-datagen`, it will start inserting rows at the end of the example for a duration that you can configure:

Example:

```bash
DURATION=10
log "Injecting data for $DURATION minutes"
docker exec -d sql-datagen bash -c "java ${JAVA_OPTS} -jar sql-datagen-1.0-SNAPSHOT-jar-with-dependencies.jar --username sa --password 'Password!' --connectionUrl 'jdbc:sqlserver://sqlserver:1433;databaseName=testDB;encrypt=false' --maxPoolSize 10 --durationTimeMin $DURATION"
```

> [!TIP]
> You can increase throughtput with `maxPoolSize`.

### 👉 PostgreSQL

For all Debezium and JDBC source connector with PostgreSQL examples, you can easily inject load in table using, the following steps.

You can enable this by setting flag `enable-sql-datagen`, it will start inserting rows at the end of the example for a duration that you can configure:

Example:

```bash
DURATION=10
log "Injecting data for $DURATION minutes"
docker exec -d sql-datagen bash -c "java ${JAVA_OPTS} -jar sql-datagen-1.0-SNAPSHOT-jar-with-dependencies.jar --connectionUrl 'jdbc:postgresql://postgres/postgres?user=myuser&password=mypassword&ssl=false' --maxPoolSize 10 --durationTimeMin $DURATION"
```

> [!TIP]
> You can increase throughtput with `maxPoolSize`.

### 👉 MySQL

For all Debezium and JDBC source connector with MySQL examples, you can easily inject load in table using, the following steps.

You can enable this by setting flag `enable-sql-datagen`, it will start inserting rows at the end of the example for a duration that you can configure:

Example:

```bash
DURATION=10
log "Injecting data for $DURATION minutes"
docker exec -d sql-datagen bash -c "java ${JAVA_OPTS} -jar sql-datagen-1.0-SNAPSHOT-jar-with-dependencies.jar --connectionUrl 'jdbc:mysql://mysql:3306/mydb?user=user&password=password&useSSL=false' --maxPoolSize 10 --durationTimeMin $DURATION"
```

> [!TIP]
> You can increase throughtput with `maxPoolSize`.

### 👉 MongoDB

Here is an example that I used to setup a reproduction environment where I inject 250 (`REQ`) req/s on 13 (`NB_COLLECTIONS`) collections. 
It is sending 50000 (`TOTAL_REQ`) records per collection.
The size of the record can be ajusted by changing the payload `{ _id : "Document " + j + "_" + i, first_name : 'john', last_name : 'hope', email : 'john@email/com', timestamp: new Date().getTime() }`

```bash
function inject () {
docker exec -i mongodb mongosh << EOF
use kafka
var counter = 0;
var j = 0;
while(counter < $TOTAL_REQ) {
var bulk = db.collection$i.initializeUnorderedBulkOp();
for (var i = 0; i < $REQ; i++) {
    bulk.insert({ _id : "Document " + j + "_" + i, first_name : 'john', last_name : 'hope', email : 'john@email/com', timestamp: new Date().getTime() });
}
bulk.execute();
j++;
counter+=$REQ;
sleep(1000);
}
EOF
date > end_collection$i.txt
}

REQ=250
NB_COLLECTIONS=13
TOTAL_REQ=50000
for((i=1;i<=$NB_COLLECTIONS;i++)); do
  log "Inserting $TOTAL_REQ documents ($REQ req/second) on collection$i"
  inject > /dev/null 2>&1 &
done

log "Wait for $TOTAL_REQ records to be processed"
playground topic consume --topic myprefix.kafka.collection1 --min-expected-messages $TOTAL_REQ --timeout 80000

log "mongo injection ended at"
cat end_collection1.txt
```

Then you can use [MongoDB source](https://github.com/vdesabou/kafka-docker-playground/tree/master/connect/connect-mongodb-source) connector:

```bash
playground connector create-or-update --connector mongodb-source << EOF
{
  "connector.class" : "com.mongodb.kafka.connect.MongoSourceConnector",
  "tasks.max" : "1",
  "connection.uri" : "mongodb://myuser:mypassword@mongodb:27017",
  "database": "kafka",
  "mongo.errors.log.enable": "true",
  "topic.prefix":"myprefix",

  "output.format.key":"json",
  "output.format.value":"json",
  "output.json.formatter":"com.mongodb.kafka.connect.source.json.formatter.SimplifiedJson",
  "output.schema.infer.value":"false",
  "value.converter": "org.apache.kafka.connect.storage.StringConverter",

  "poll.await.time.ms": "10000",
  "poll.max.batch.size": "50",

  "batch.size":"50",
  "publish.full.document.only":"true",
  "change.stream.full.document":"updateLookup",

  "heartbeat.interval.ms": "5000",

  "_producer.override.linger.ms":"500",
  "_producer.override.batch.size":"2000000",
  "producer.override.client.id":"mongo-producer",
  "_producer.override.compression.type": "lz4"
}
EOF
```

### 👉 MQTT

In order to generate perf injection, you can use [Solace SDKPerf tool](https://docs.solace.com/API/SDKPerf/SDKPerf.htm), [download](https://solace.com/downloads/?fwp_downloads_types=other) it first.

(optional) Add in your docker-compose file a EQMX MQTT broker:

```yml
  emqx:
    image: emqx/emqx:latest
    hostname: emqx
    container_name: emqx
    environment:
    - "EMQX_NAME=emqx"
    - "EMQX_HOST=emqx"
    - "MQTT_SESSION_MAX_INFLIGHT=64" 
    ports:
      - 1883:1883
      - 18083:18083
```

Note: EQMX dashboard is available on http://localhost:18083/ (`admin`/`public`)

Send MQTT messages at 3000 messages/sec with QOS 1 (`"mqtt.topics":"test_mqtt"`):

```bash
./sdkperf-mqtt-8.4.10.6/sdkperf_mqtt.sh -cip=localhost:1883 -ptl=test_mqtt -msa=100 -mn=5000000 -mr=3000 -mpq=1
```

Then you can use [MQTT source](https://github.com/vdesabou/kafka-docker-playground/tree/master/connect/connect-mqtt-source) connector:

```bash
log "Creating MQTT Source connector"
curl -X PUT \
     -H "Content-Type: application/json" \
     --data '{
               "connector.class": "io.confluent.connect.mqtt.MqttSourceConnector",
               "tasks.max": "1",
               "mqtt.server.uri": "tcp://emqx:1883",
               "mqtt.topics":"test_mqtt",
               "kafka.topic":"mqtt-source-1",
               "mqtt.qos": "1",
               "confluent.license": "",
               "confluent.topic.bootstrap.servers": "broker:9092",
               "confluent.topic.replication.factor": "1",

               "records.buffer.queue.size": "10000",
               "records.buffer.queue.max.batch.size": "100",
               "records.buffer.queue.empty.timeout": "10" 
          }' \
     http://localhost:8083/connectors/source-mqtt/config | jq .
```