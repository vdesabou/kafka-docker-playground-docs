# playground connector upgrade-check

🔼 What changes for this connector config when the plugin is upgraded (no environment needed)

"Can we upgrade the S3 sink from 10.5.7 to the latest (and to CP 8)?"  
in one call, for the customer's config, with a verdict. The  
configuration of the connector class is read in both versions (the  
same download and cache as 'connector-plugin config-diff'), then  
checked against the config:

- **❌ breaking**: a key the config sets is removed, its value is no longer valid (valid values, range), a new required key without default, the target version is below the minimum supported on `--cp-version` (CP 8)
- **⚠️ review**: a default changed on a key the config does not set (it runs with the old default without knowing it), a set key whose type or value rule changed, release notes that name a set key or say default, behavior, removed, deprecated, breaking..., a major change of a shared library (Jackson, Avro, Protobuf, AWS SDK v1 → v2, Netty, Kafka clients...) that custom classes (credentials providers, SMTs) depend on
- **ℹ️ info**: versions behind, new keys, CVEs (`--with-cve`)

A release note line is never breaking: it is printed for a human to  
judge. Release notes exist only for the Confluent self-managed plugins  
documented on docs.confluent.io (the output says when there are none).  
The CP 8 minimum versions come from the guards of the connect/ examples  
("minimal supported connector version is X for CP 8.0").

The config is read from stdin, in the same formats as 'connector  
validate' and 'connector lint' (json, CFK, Strimzi, terraform,  
.properties, a dump of GET /connectors?expand=info). Without stdin,  
`--connector` checks that running connector, and `--from` is the version of  
its plugin in the worker.

Exits with 0 when it is safe, 1 when there is something to review or  
a breaking change, 2 when it could not check.

☁️ Fully managed: not supported (Confluent upgrades them: playground connector-plugin fm-versions)

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-connector-plugin

## Usage

```bash
playground connector upgrade-check [JSON] [OPTIONS]
```

## Arguments

#### `JSON`

json (reads from stdin if empty)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `-`

## Options

#### `--verbose, -v`

🐞 Show command being ran.

#### `--connector, -c CONNECTOR`

🔗 Connector name

With a config on stdin: the name shown, or the connector to pick in a dump that has several. Without stdin, the  
running connector to check (its plugin version in the worker is `--from`).

#### `--connector-plugin CONNECTOR-PLUGIN`

🔌 Connector plugin (owner/name)

Default: the plugin of the connector.class of the config, found in the examples

#### `--from FROM`

🔢 Version in use (the customer's)

Default: the version of the plugin in the worker, for a running connector

#### `--to TO`

🎯 Target version (default: the latest on Confluent Hub)

#### `--cp-version CP-VERSION`

🎯 Target CP version: checks the minimum plugin version supported on CP 8

#### `--with-cve`

🛡️ Also compare the CVEs of both versions (connector-plugin cve-scan, slow the first time)

#### `--json`

🤖 Print the result as JSON on stdout, and nothing else (the log lines go to stderr)

## Examples

```bash
playground connector upgrade-check --connector s3-sink
```

```bash
playground connector upgrade-check --from 10.5.7 --cp-version 8.0.3 < customer-s3-sink.json
```

```bash
playground connector upgrade-check --from 10.7.4 --to 10.8.4 --with-cve < jdbc-sink.properties
```

## Example output

```text
$ playground connector upgrade-check --from 10.5.7 --cp-version 8.0.3 < s3-sink.json
13:48:17 ℹ️ 🔌 connector class io.confluent.connect.s3.S3SinkConnector is in plugin confluentinc/kafka-connect-s3
13:48:18 ℹ️ 🔼 Checking confluentinc/kafka-connect-s3 10.5.7 → 12.1.16 for this config (nothing is created)
13:48:18 ℹ️ 📜 Reading the release notes, the libraries and the versions
🔼 confluentinc/kafka-connect-s3 10.5.7 → 12.1.16 on CP 8.0.3, S3SinkConnector
   11 key(s) of the plugin set in the config, 60 key(s) in 10.5.7, 68 in 12.1.16

⚠️  REVIEW
   s3.credentials.provider.class  not set: default changes com.amazonaws.auth.DefaultAWSCredentialsProviderChain → software.amazon.awssdk.auth.credentials.DefaultCredential…
   changelog 12.1.12              PR-964 - Removed logging of file names and exceptions with sensitive content. (removed)
   changelog 12.0.0               CC-37115: Added support for specifying dot-separated path as a partition key in field partitioner. This update may be breaking for customers currently using the FieldPartitioner with top-level fields that contain a literal dot (.) in their name. (breaking)
   changelog 11.0.3               PR-876 - CC-36817 Added default URL scheme to store.url endpoint (default)
   changelog 11.0.0               CC-35568 - Migrated the connector to use AWS SDK V2 (migrated)
   AWS SDK v1                     aws-java-sdk-core 1.12.524 removed, aws-java-sdk-kms 1.12.524 removed, aws-java-sdk-s3 1.12.524 removed …: custom classes built against it (credentials providers, SMTs, converters) must be rebuilt and tested
   AWS SDK v2                     added: annotations 2.28.23, apache-client 2.28.23, arns 2.28.23 …
   Protobuf                       protobuf-java 3.19.6 removed: custom classes built against it (credentials providers, SMTs, converters) must be rebuilt and tested

ℹ️  INFO
   CP 8.0.3  12.1.16 ≥ 10.6.0, the minimum version of confluentinc/kafka-connect-s3 for CP 8
   versions  95 version(s) behind the latest (12.1.16, 2026-11-16)
   new keys  8 key(s) added (defaults apply): enable.conditional.writes, max.files.scan.limit, max.write.duration.ms, partitioner.max.open.files, report.null.values.to.dlq, rotate.file.on.partition.change …

Verdict: ⚠️  review: behaviour changes to check, the config still validates
13:48:25 ℹ️ 🎓 try it: playground run -f <example of confluentinc/kafka-connect-s3> --connector-tag 12.1.16, or playground repro bisect --from 10.5.7 --to 12.1.16 on a repro model
```

```text
$ playground connector upgrade-check --from 10.7.4 --to 10.7.12 --cp-version 8.0.3 < jdbc-sink.properties
13:48:26 ℹ️ 📦 detected: connect-standalone .properties file
13:48:26 ℹ️ 🔌 connector class io.confluent.connect.jdbc.JdbcSinkConnector is in plugin confluentinc/kafka-connect-jdbc
13:48:26 ℹ️ 🔼 Checking confluentinc/kafka-connect-jdbc 10.7.4 → 10.7.12 for connector jdbc-sink (nothing is created)
13:48:27 ℹ️ 📜 Reading the release notes, the libraries and the versions
🔼 confluentinc/kafka-connect-jdbc 10.7.4 → 10.7.12 on CP 8.0.3, connector jdbc-sink, JdbcSinkConnector
   8 key(s) of the plugin set in the config, 22 key(s) in 10.7.4, 23 in 10.7.12

❌ BREAKING
   CP 8.0.3  10.7.12 is below 10.8.0, the minimum version of confluentinc/kafka-connect-jdbc supported on CP 8

⚠️  REVIEW
   changelog 10.7.7  PR-1422 - Support default array values from schema to Postgres JDBC Sink Connector (default)

ℹ️  INFO
   versions  34 version(s) behind the latest (10.9.10, 2026-11-03)
   new keys  1 key(s) added (defaults apply): date.timezone

Verdict: ❌ breaking: the config needs changes before the upgrade
13:48:37 ℹ️ 🎓 try it: playground run -f <example of confluentinc/kafka-connect-jdbc> --connector-tag 10.7.12, or playground repro bisect --from 10.7.4 --to 10.7.12 on a repro model
```


