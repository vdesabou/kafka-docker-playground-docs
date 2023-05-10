# Change Log

## May 2023

- Added 🔍 [ksqlDB Schema Inference with ID](https://github.com/vdesabou/kafka-docker-playground/tree/master/ksqldb/schema-inference-with-id) (🙏 @danielpetisme)

## April 2023

- Added 🖇️ [Monitoring cluster linking](https://github.com/vdesabou/kafka-docker-playground/tree/master/other/monitoring-cluster-linking) (🙏 @danielpetisme)
- Added 🤿 [Anonymous SR-example with RBAC](https://github.com/vdesabou/kafka-docker-playground/tree/master/other/rbac-with-anonymous-sr) (🙏 @Schm1tz1)
- Added 🧢 [RBAC with SR Basic Auth and ACLs](https://github.com/vdesabou/kafka-docker-playground/tree/master/other/rbac-with-sr-basic-auth-acl) (🙏 @Schm1tz1)
- Added `--producer-schema-key` and `--producer-schema-value` to `playground bootstrap-reproduction-model`
- Added 🌪️ SQL Datagen tool for [PostgreSQL](/reusables?id=%f0%9f%91%89-postgresql) examples
- Added 🌪️ SQL Datagen tool for [MySql](/reusables?id=%f0%9f%91%89-mysql) examples
- Added 🌪️ SQL Datagen tool for [Microsoft Sql Server](/reusables?id=%f0%9f%91%89-microsoft-sql-server) examples
- Added 📛 [Pyroscope](https://pyroscope.io/docs/) to JMX Grafana
- Added CLI command `playground get-all-schemas` to get all schemas versions for all subjects.
- Added CLI command `playground topic consume` to consume automatically topic from currently running connect example
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
- Added `--pipeline` flag option to `playground bootstrap-reproduction-model` command: [🧑‍ How to build a pipeline](/reusables?id=%f0%9f%94%9b-how-to-build-a-pipeline) is now fully automated !
- Added `--custom-smt` flag option to `playground bootstrap-reproduction-model` command.
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