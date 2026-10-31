# playground connector-plugin search-jar

☕ List jars for a connector plugin from confluent hub https://www.confluent.io/hub/

Downloads the plugin and lists the jars it ships. With `--class` it also  
finds which jar contains that class and prints its method signatures  
with javap.

That answers the two questions a NoClassDefFoundError or a  
NoSuchMethodError raises: is the class actually shipped, and does the  
bundled version have the signature the code is calling. Run it again  
with another `--connector-tag` to see when a dependency changed.

With `--with-worker`, the classes of the worker classpath (Kafka, Connect,  
Confluent libraries of the connect image) are compared with the plugin:  
a class of the plugin that Connect always loads from the worker  
(org.apache.kafka.\*, org.slf4j.\*, java\*…: the plugin isolation rules of  
that worker) is flagged, its copy in the plugin is ignored. So is a  
class on both sides in a package that the worker config hands to the  
Kafka clients of the tasks (io.confluent.telemetry.\* of metric.reporters,  
interceptors, RBAC login handlers): the client mixes both copies, "class  
X is not an instance of Y" / ClassCastException.

The jars are kept in /tmp/connector-plugin-jars, one folder per plugin  
version, and reused on the next call (`--force-refresh`).

## Usage

```bash
playground connector-plugin search-jar [OPTIONS]
```

## Dependencies

#### *python3*

visit https://www.python.org/downloads/ to install

## Environment Variables

#### `PG_JAVAP_IMAGE`

☕ JDK image used for javap when there is no local JDK (default eclipse-temurin:21-jdk)

## Options

#### `--connector-plugin, -c CONNECTOR-PLUGIN`

🔌 Connector plugin name (or `--connector-zip`)

owner/name, a connector class (io.confluent.connect.jdbc.JdbcSinkConnector: its plugin is found in the examples)  
or a fully managed type (`S3_SINK`)

🎓 Tip: use `<tab>` completion to trigger fzf completion

#### `--connector-tag CONNECTOR_TAG`

🔗 Connector version to use

By default, for each connector, the latest available version on Confluent Hub is used

🎓 Tip: set to " " in order to select the version dynamically (for Confluent plugins, the preview shows the release notes of each version)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--connector-zip`

#### `--connector-zip CONNECTOR_ZIP`

🤐 Connector zip to use

❕ It must be absolute full path

🎓 Tip: use `<tab>` completion to trigger fzf completion  
use playground config folder_zip_or_jar `<folder1>` `<folder2>`... (default is home folder and current folder is always included) to configure where to search the files  
use `<option+enter>` to use the value you typed manually

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--connector-tag`

#### `--class CLASS`

☕ Java class to search for in all jars

A simple name (WebIdentityTokenCredentialsProvider) or a fully qualified  
name finds the classes with exactly that name; when there is none, the  
classes containing it (case insensitive) are listed. Method signatures  
(javap) are shown for 5 classes at most.

#### `--with-worker`

🧱 Also look at the worker classpath of the connect image

Flags the classes of the plugin that Connect loads from the worker  
instead (their copy in the plugin is ignored), and the ones the worker  
config puts in the clients of the tasks (💥: metric.reporters,  
interceptors…, two copies mixed), and with `--class` shows the worker's  
copy of the class, with its signatures. The image is the one of  
the running connect container, else the default one (`--tag` of the run).

#### `--json`

🤖 Print the result as JSON

#### `--force-refresh`

☢️ Force refresh.

## Examples

```bash
playground connector-plugin search-jar --connector-plugin confluentinc/kafka-connect-s3 --class WebIdentityTokenCredentialsProvider
playground connector-plugin search-jar --connector-plugin confluentinc/kafka-connect-jdbc --connector-tag 10.8.4 --class io.confluent.connect.jdbc.dialect.PostgreSqlDatabaseDialect
playground connector-plugin search-jar --connector-plugin confluentinc/kafka-connect-hdfs --with-worker
playground connector-plugin search-jar --connector-zip /path/to/customer-plugin.zip --class Producer --with-worker
playground connector-plugin search-jar --connector-plugin confluentinc/kafka-connect-s3 --json

```

## Example output

```text
$ playground connector-plugin search-jar --connector-plugin confluentinc/kafka-connect-s3 --class WebIdentityTokenCredentialsProvider
17:23:33 ℹ️ 🔌 Downloading connector plugin confluentinc/kafka-connect-s3:12.1.13
17:23:49 ℹ️ 🤎 158 jar(s), 41250 classes in /tmp/connector-plugin-jars/confluentinc-kafka-connect-s3-12.1.13/confluentinc-kafka-connect-s3-12.1.13/lib
accessors-smart-2.4.9.jar
aircompressor-2.0.3.jar
...
17:23:51 ℹ️ 🔎 1 class(es) named WebIdentityTokenCredentialsProvider in the jars of confluentinc/kafka-connect-s3:12.1.13
   👉 software.amazon.awssdk.auth.credentials.WebIdentityTokenCredentialsProvider in auth-2.28.23.jar
```


