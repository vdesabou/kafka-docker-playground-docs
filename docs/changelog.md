# Change Log

## November 2023

- CLI:
  * `--nb-messages` for [playground topic produce](https://kafka-docker-playground.io/#/playground%20topic%20produce): if you set it to -1, an infinite number of records will be sent by batches of 300000 records
  * `--key` for [playground topic produce](https://kafka-docker-playground.io/#/playground%20topic%20produce) can now use same input parameters as `--value`:

```bash
–key KEY
🗝️ Key to use. If not set, no key is used.

🔥 You can either:

Set your own schema (avro, json-schema, protobuf) within single quotes (see examples)

You can also generate json data using json or sql format using syntax from https://github.com/MaterializeInc/datagen

Directly set payload (“%g” can be used to generate a counter)

In case of ‘raw’ data (i.e not using schema):

If the key contain a number, it will be used as starting point and incremented for each record.

Example: key1 will start with key1, then key2, etc..
Example: mykey-10-suffix will start with mykey-10-suffix then mykey-11-suffix, etc..

“%g” can also be used to generate a counter

Example: key%g will start with key1, then key2, etc..

Otherwise, the key will be same for all records.
```

  example:

```bash
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
16:57:04 ℹ️ 🔮 key schema was identified as avro
16:57:04 ℹ️ 🔮 value schema was identified as avro
16:57:04 ℹ️ ✨ generating data...
16:57:12 ℹ️ ✨ 10 records were generated (only showing first 10), took: 0min 8sec
{"id":1}|{"count":1,"first_name":"Judge","last_name":"Bennett"}
{"id":2}|{"count":2,"first_name":"Haylie","last_name":"Demario"}
{"id":3}|{"count":3,"first_name":"Nicklaus","last_name":"Sabina"}
{"id":4}|{"count":4,"first_name":"Concepcion","last_name":"Avery"}
{"id":5}|{"count":5,"first_name":"Nico","last_name":"Mohamed"}
{"id":6}|{"count":6,"first_name":"Dedric","last_name":"Vernon"}
{"id":7}|{"count":7,"first_name":"Dejuan","last_name":"Giuseppe"}
{"id":8}|{"count":8,"first_name":"Cordie","last_name":"Ned"}
{"id":9}|{"count":9,"first_name":"Josie","last_name":"Dewayne"}
{"id":10}|{"count":10,"first_name":"Jasper","last_name":"Cristal"}
16:57:16 ℹ️ ✨ topic topic-avro-with-key does not exist, it will be created..
16:57:16 ℹ️ ⛅ creating topic in confluent cloud
16:57:19 ℹ️ 🆕 Creating topic topic-avro-with-key
Created topic topic-avro-with-key.
16:57:22 ℹ️ 📤 producing 10 records to topic topic-avro-with-key
16:57:25 ℹ️ 📤 produced 10 records to topic topic-avro-with-key, took: 0min 3sec
16:57:25 ℹ️ 💯 Get number of records in topic topic-avro-with-key
10
```

  * Added [playground start-environment](https://kafka-docker-playground.io/#/playground%20start-environment) command
  * `--pipeline` flag for `playground repro boostrap` command is now repeatable, meaning you can create a pipeline from one source connector to multiple sink connectors !

## October 2023

* Added JDBC MariaDB [Source](https://github.com/vdesabou/kafka-docker-playground/tree/master/connect/connect-jdbc-mariadb-source) and [Sink](https://github.com/vdesabou/kafka-docker-playground/tree/master/connect/connect-jdbc-mariadb-sink) examples (🙏 @pulkitnt)
* HTTP sink examples ([no-auth](https://github.com/vdesabou/kafka-docker-playground/blob/master/connect/connect-http-sink/http_no_auth.sh) and [Oauth2](https://github.com/vdesabou/kafka-docker-playground/blob/master/connect/connect-http-sink/http_oauth2_auth.sh)) have endpoints to set response error code, add delay and set response body:

```bash
log "Set webserver to reply with 503"
curl -X PUT -H "Content-Type: application/json" --data '{"errorCode": 503}' http://localhost:9006/set-response-error-code
```

You can also adjust response time to add delay:

```bash
log "Set webserver to reply with 2 seconds delay"
curl -X PUT -H "Content-Type: application/json" --data '{"delay": 2000}' http://localhost:9006/set-response-time
```

And also set json response to send back:

```bash
log "Set webserver to reply with {"message":"Hello, World!"} json body"
curl -X PUT -H "Content-Type: application/json" --data '{"message":"Hello, World!"}' http://localhost:9006/set-response-body
```

* Added [Shell Script Command Completion Visual Studio Code extension](/cli?id=%f0%9f%aa%84-setup-shell-script-command-completion-visual-studio-code-extension)

![vscode-extension](./images/vscode-extension.gif)

* Added [🎏 KSQL examples](/content?id=%f0%9f%8e%8f-ksql) (🙏 @jocelyndrean and @SamiShaikh)
* Improved JMX Grafana [dashboard](/how-to-use?id=grafana-dashboards):
  * List of provided dashboards:
     - Confluent Platform overview 🆕
     - Zookeeper cluster 🆕
     - Kafka cluster
     - Kafka topics 🆕
     - Kafka quotas 🆕
     - Schema Registry cluster 🆕
     - Kafka Connect cluster
     - ksqlDB cluster 🆕
     - Kafka Clients 🆕
     - Kafka lag exporter
     - Cluster Linking 🆕
     - Kafka streams RocksDB 🆕
     - Oracle CDC source Connector 🆕
- CLI:
  * Added `--subject` flag to `playground topic consume` command (useful when data was produced with --value-subject-name-strategy other than TopicNameStrategy)
  * Added `playground topic list` command
  * Displaying schema with `playground topic consume` command
  * Added `--max-characters` flag to `playground topic consume` command
  * 🔥 Added [playground update-version](/playground%20update-version): you can now change cp version and/or connector(s) version(s) while running an example
  * Added [playground status](/playground%20status) command


## September 2023

* Added [Debezium CDC example with Oracle 19c](https://github.com/vdesabou/kafka-docker-playground/tree/master/connect/connect-debezium-oracle19-source)
* Added [How to write connect logs to a kafka topic](https://github.com/vdesabou/kafka-docker-playground/tree/master/other/write-logs-to-topic)
* Added [MQTT Proxy example](https://github.com/vdesabou/kafka-docker-playground/tree/master/other/mqtt-proxy) with SASL_PLAINTEXT
- CLI:
  * Added `repro export` and `repro import`
  * Added `--validate` flag to `playground topic produce` command
  * Added `--producer-property` (can be set multiple times) to `playground topic produce` command
  * Added `--record-size` to `playground topic produce` command
  * Added `alter topic` command
  * Added `debug generate-diagnostics` command

## August 2023

* Added [MQTT Proxy example](https://github.com/vdesabou/kafka-docker-playground/tree/master/other/mqtt-proxy)
* Oracle 19 examples are now supported on M1 chip (ARM64) Mac
- CLI:
  * Added `connector show-config` and `ccloud-connector show-config`
  * Renamed `playground bootstrap-reproduction-model` to `playground repro bootstrap`


## July 2023

- Added ssl examples for mongo source and sink
- Added [JDBC Google BigQuery Source](https://github.com/vdesabou/kafka-docker-playground/tree/master/connect/connect-jdbc-gcp-bigquery-source)
- CLI:
  * Added `--compatibility` to `topic produce` [command](/cli?id=%f0%9f%93%a5-produce)
  * Only show fzf preview when terminal is wide enough
  * Added `debug flight-recorder`
  * Added `wait-for-zero-lag` to `connector show-lag` command
  * Added `connector show-config-parameters` and `ccloud-connector show-config-parameters` commands
  * Added `open-docs` command
  * Added `debug block-traffic`
  * Added `debug testssl`
  * Added `--generate-only` and `--force-value` to `topic produce` [command](/cli?id=%f0%9f%93%a5-produce)
  * Added `--headers` to `topic produce` [command](/cli?id=%f0%9f%93%a5-produce)

## June 2023

- Added [Lenses JMS source for ActiveMQ](https://github.com/vdesabou/kafka-docker-playground/tree/master/connect/connect-lenses-active-mq-source)
- Add [Oracle CDC JMX metrics](https://docs.confluent.io/kafka-connectors/oracle-cdc/current/oracle-metrics.html) to JMX Grafana dashboard
- CLI: 
  * Added `debug thread-dump`
  * Added `--tail` option to `topic consume`
  * Added `ccloud-connector` command to interact with [fully-managed connectors](/content?id=%f0%9f%a4%96-fully-managed-connectors)
  * 🔥 Added `topic produce` [command](/cli?id=%f0%9f%93%a5-produce)
  * Added `topic create` and `topic delete` commands
  * Added `--verbose` flag for produce and consume
- Added [SSL example](https://github.com/vdesabou/kafka-docker-playground/blob/master/connect/connect-rabbitmq-source/rabbitmq-source-ssl.sh) for RabbitMQ source

## May 2023

- Use `playground topic consume` in all examples (bash version 4 or higher is now required to use playground)
- ACADEMY:
  * Avro Converter: Unknown magic byte
  * InsertField SMT: DataException: Only Struct objects supported (sink connector)
  * InsertField SMT: DataException: Only Struct objects supported (source connector)
  * InsertField SMT: adding topic, offset and partition not working
- CLI: 
  * Add latest version from hub in `playground connector versions` command 
  * Added `--expected-messages` to `topic consume`
  * `repro bootstrap`: `--producer-schema-key` and `--producer-schema-value` will now open text editor: Copy and paste the schema you want to use for the key/value, save and close the file to continue, it will automatically make required changes
  * `--topic` is now optional for all [Topics commands](/cli?id=%f0%9f%97%b3-topics-commands) ! By default it will loop on all non-internal topics
- [🧠 CLI](/cli) is now version 1.0.0
- Added 🔍 [ksqlDB Schema Inference with ID](https://github.com/vdesabou/kafka-docker-playground/tree/master/ksqldb/schema-inference-with-id) (🙏 @danielpetisme)

## April 2023

- Added 🖇️ [Monitoring cluster linking](https://github.com/vdesabou/kafka-docker-playground/tree/master/other/monitoring-cluster-linking) (🙏 @danielpetisme)
- Added 🤿 [Anonymous SR-example with RBAC](https://github.com/vdesabou/kafka-docker-playground/tree/master/other/rbac-with-anonymous-sr) (🙏 @Schm1tz1)
- Added 🧢 [RBAC with SR Basic Auth and ACLs](https://github.com/vdesabou/kafka-docker-playground/tree/master/other/rbac-with-sr-basic-auth-acl) (🙏 @Schm1tz1)
- Added `--producer-schema-key` and `--producer-schema-value` to `playground repro bootstrap`
- Added 🌪️ SQL Datagen tool for [PostgreSQL](/reusables?id=%f0%9f%91%89-postgresql) examples
- Added 🌪️ SQL Datagen tool for [MySql](/reusables?id=%f0%9f%91%89-mysql) examples
- Added 🌪️ SQL Datagen tool for [Microsoft Sql Server](/reusables?id=%f0%9f%91%89-microsoft-sql-server) examples
- Added 📛 [Pyroscope](https://pyroscope.io/docs/) to JMX Grafana
- Added CLI command `playground get-all-schemas` to get all schemas versions for all subjects.
- Added CLI command `playground topic consume` to consume topic without even needing to specify any config.
- Added CLI command `re-run` to re-run last example
- Added [Recovery from schema hard deletion](https://github.com/vdesabou/kafka-docker-playground/tree/master/other/recover-from-schema-hard-deletion) (🙏 @danielpetisme)
- Added AWS Lambda sink [with custom STS credentials provider](https://github.com/vdesabou/kafka-docker-playground/blob/master/connect/connect-aws-lambda-sink/lambda-sink-assuming-iam-role-with-custom-aws-credential-provider.sh)
- Added [Fully Managed SFTP source](https://github.com/vdesabou/kafka-docker-playground/tree/master/ccloud/fully-managed-connect-sftp-source) example
- Added [JDBC Amazon Redshift Sink](https://github.com/vdesabou/kafka-docker-playground/tree/master/connect/connect-jdbc-aws-redshift-sink) example
- Added [🏎️ Start an example with CLI](/#/how-to-use?id=%f0%9f%a7%a0-with-cli) using `playground run` command
- Added [👉 MQTT](/#/reusables?id=%f0%9f%91%89-mqtt) performances injection tool
- Added [🌍 Debug HTTP sink](/#/reusables?id=%f0%9f%8c%8d-debug-http-sink)

## March 2023

- No more using `vdesabou/kafka-docker-playground-connect` image [#3564](https://github.com/vdesabou/kafka-docker-playground/issues/3564)
- Added Google Cloud Pub/Sub Group Kafka Connector [Source](https://github.com/vdesabou/kafka-docker-playground/tree/master/connect/connect-gcp-google-pubsub-source) and [Sink](https://github.com/vdesabou/kafka-docker-playground/tree/master/connect/connect-gcp-google-pubsub-sink) connectors examples
- Added `--pipeline` flag option to `playground repro bootstrap` command: [🧑‍ How to build a pipeline](/reusables?id=%f0%9f%94%9b-how-to-build-a-pipeline) is now fully automated !
- Added `--custom-smt` flag option to `playground repro bootstrap` command.
- Added [🔂 Standalone connector examples](/content)
- Added [🧑‍💻 M1 chip (ARM64) Mac Support](/how-to-use?id=%f0%9f%a7%91%f0%9f%92%bb-m1-chip-arm64-mac-support) section
- Added [🧑‍🎓 Academy](/examples) section

## February 2023

- Added [🧠 CLI](//cli)
- Changed [🔐 Proxy with BASIC authentication](/reusables?id=%f0%9f%94%90-proxy-with-basic-authentication) to use [ubuntu/squid](https://hub.docker.com/r/ubuntu/squid) as nginx example was broken

## January 2023

- Added [🏎️ Performance testing](/reusables?id=%f0%9f%8f%8e%ef%b8%8f-performance-testing)
- Added [🕸️ Debug ServiceNow or Salesforce](/reusables?id=%f0%9f%95%b8%ef%b8%8f-debug-servicenow-or-salesforce)
- Added [↔️ Default Connect converter used](/how-it-works?id=%e2%86%94%ef%b8%8f-default-connect-converter-used)
- Added [🧙 How to install other connectors](/reusables?id=%f0%9f%a7%99-how-to-install-other-connector)
- Added [🧑‍ How to build a pipeline](/reusables?id=%f0%9f%94%9b-how-to-build-a-pipeline)

## December 2022

- Improved [♨️ Java producers](/reusables?id=%e2%99%a8%ef%b8%8f-java-producers) section with more explanations on environment variables that can be used.
- Added [🎁 Tips & Tricks](/tips-and-tricks)

## November 2022

- Added [🛩️ Flight Recorder](/reusables?id=%f0%9f%9b%a9%ef%b8%8f-flight-recorder)
- Added [👻 Heap Dump](/reusables?id=%f0%9f%91%bb-heap-dump)
- Added [🎯 Thread Dump](/reusables?id=%f0%9f%8e%af-thread-dump)

## January 2022

- Added [🛠 Bootstrap reproduction model](/reusables?id=%F0%9F%9B%A0-bootstrap-reproduction-model)

## October 2021

- Initial release 🥳