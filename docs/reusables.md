# 👷‍♂️ How to build your own examples or reproduction models with reusables

Below is a collection of *how to* that you can re-use when you build your own examples or reproduction models.

## 🛠 Bootstrap reproduction model

Execute [🧠 CLI](/cli) with `playground repro bootstrap` [command](/playground%20repro%20bootstrap). It will start in interactive mode.

Examples:

### Basic

<script async id="asciicast-646555" src="https://asciinema.org/a/646555.js"></script>

### Deprecated: Java producer (`--producer`)

> [!WARNING]
> Most of times, it's much simpler to use `playground topic produce` [CLI](/playground%20topic%20produce)
> 
> Use java producer only if you have very specific requirements such as specifying record timestamp
> See [here](/legacy-java-producer) for instructions


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
    build_java_component_with_retry "${component}" docker run -i --rm -e KAFKA_CLIENT_TAG=$KAFKA_CLIENT_TAG -e TAG=$TAG_BASE -v "${DIR}/${component}":/usr/src/mymaven -v "$HOME/.m2":/root/.m2 -v "$PWD/../../scripts/settings.xml:/tmp/settings.xml" -v "${DIR}/${component}/target:/usr/src/mymaven/target" -w /usr/src/mymaven maven:3.9.11-eclipse-temurin-17 mvn -s /tmp/settings.xml -Dkafka.tag=$TAG -Dkafka.client.tag=$KAFKA_CLIENT_TAG package
    set -e
done
```

It will copy the jar to the connector lib folder:

```bash
log "📂 Copying custom jar to connector folder /usr/share/confluent-hub-components/debezium-debezium-connector-sqlserver/lib/"
playground container cp --source /path/to/kafka-docker-playground/reproduction-models/connect-connect-debezium-sqlserver-source/MyCustomSMT-000000/target/MyCustomSMT-1.0.0-SNAPSHOT-jar-with-dependencies.jar --destination connect:/usr/share/confluent-hub-components/debezium-debezium-connector-sqlserver/lib/
log "📂 Copying custom jar to connector folder /usr/share/confluent-hub-components/confluentinc-connect-transforms/lib/"
playground container cp --source /path/to/kafka-docker-playground/reproduction-models/connect-connect-debezium-sqlserver-source/MyCustomSMT-000000/target/MyCustomSMT-1.0.0-SNAPSHOT-jar-with-dependencies.jar --destination connect:/usr/share/confluent-hub-components/confluentinc-connect-transforms/lib/
log "♻️ Restart connect worker to load"
playground container restart --container connect
```

And add the transform config to connector:

```json
  "transforms": "MyCustomSMT",
  "transforms.MyCustomSMT.type": "com.github.vdesabou.kafka.connect.transforms.MyCustomSMT",
```

### With pipeline (`--pipeline`)

All the steps to create a pipeline, i.e an example with source and sink connectors are automated:

Example:

<script async id="asciicast-646556" src="https://asciinema.org/a/646556.js"></script>

It will automatically:

* Add sink example(s) (you can select multiple !) at the end of source example
* Modify sink converters (key and value) to use same as source example
* Use same kafka topic for all connectors
* Add all required containers for all sink and source
* Update `CONNECT_PLUGIN_PATH` to include all connectors

## 👉 Producing data

Use [playground topic produce](/playground%20topic%20produce): it creates the topic if needed, registers the schema (avro, json schema or protobuf) and generates realistic random data matching it. See the [command page](/playground%20topic%20produce) for all options.

> [!TIP]
> Pipe the schema or the payload with a quoted heredoc, `<< 'EOF'`, so that the `%g` placeholders survive the shell.

<!-- tabs:start -->

#### **String**

```bash
playground topic produce -t a-topic --nb-messages 10 --forced-value "This is a message %g"
```

#### **JSON**

```bash
playground topic produce -t a-topic --nb-messages 3 << 'EOF'
{"u_name": "scissors", "u_price": 2.75, "u_quantity": 3}
{"u_name": "tape", "u_price": 0.99, "u_quantity": 10}
{"u_name": "notebooks", "u_price": 1.99, "u_quantity": 5}
EOF
```

#### **Key and headers**

```bash
# key1, key2, etc.. (%g can also be used)
playground topic produce -t a-topic --nb-messages 3 --key "key1" --headers "header1:value1,header2:value2" << 'EOF'
{"u_name": "scissors", "u_price": 2.75, "u_quantity": 3}
{"u_name": "tape", "u_price": 0.99, "u_quantity": 10}
{"u_name": "notebooks", "u_price": 1.99, "u_quantity": 5}
EOF
```

#### **Avro**

```bash
playground topic produce -t a-topic --nb-messages 10 << 'EOF'
{
  "type": "record",
  "name": "myrecord",
  "fields": [
    {"name": "u_name", "type": "string"},
    {"name": "u_price", "type": "float"},
    {"name": "u_quantity", "type": "int"}
  ]
}
EOF
```

#### **Avro with key**

```bash
playground topic produce -t a-topic --nb-messages 10 --key '
{
  "type": "record",
  "name": "myrecordkey",
  "fields": [
    {"name": "ID", "type": "long"}
  ]
}
' << 'EOF'
{
  "type": "record",
  "name": "myrecordvalue",
  "fields": [
    {"name": "ID", "type": "long"},
    {"name": "product", "type": "string"},
    {"name": "quantity", "type": "int"},
    {"name": "price", "type": "float"}
  ]
}
EOF
```

#### **Protobuf**

```bash
playground topic produce -t a-topic --nb-messages 10 << 'EOF'
syntax = "proto3";

message MyRecord {
    string f1 = 1;
}
EOF
```

#### **JSON Schema**

```bash
playground topic produce -t a-topic --nb-messages 10 << 'EOF'
{
  "type": "object",
  "properties": {
    "f1": {"type": "string"}
  }
}
EOF
```

#### **Exact payload**

Use `--generate-only` first to get the skeleton of a message, then `--forced-value` to send exactly the record you need:

```bash
playground topic produce -t a-topic --nb-messages 1 --forced-value '{"f1": "value1"}' << 'EOF'
{
  "type": "record",
  "name": "myrecord",
  "fields": [
    {"name": "f1", "type": "string"}
  ]
}
EOF
```

#### **Schema file**

```bash
playground topic produce -t a-topic --nb-messages 10 < schema.avsc
```

#### **Tombstone**

```bash
playground topic produce -t a-topic --tombstone --key "mykey1"
```

#### **High volume**

```bash
playground topic produce -t a-topic --nb-messages 200000 --record-size 1000
```

<!-- tabs:end -->

> [!NOTE]
> The [Java producers](/legacy-java-producer) are deprecated: use them only if you have very specific requirements, such as setting the record timestamp.

## 👉 Consuming data

Use [playground topic consume](/playground%20topic%20consume): it reads the topic from the beginning and detects the format (avro, protobuf, json schema or plain) on its own. Every record is displayed with its timestamp, partition, offset, headers, key and schema ID.

<!-- tabs:start -->

#### **Simplest**

```bash
playground topic consume --topic a-topic
```

#### **All topics**

```bash
playground topic consume
```

#### **Assert content**

Wait up to `--timeout` seconds for at least 10 records containing `value1`, and fail otherwise (this is how examples verify that data flowed):

```bash
playground topic consume --topic a-topic --min-expected-messages 10 --grep "value1" --timeout 60
```

#### **Tail**

```bash
playground topic consume --topic a-topic --tail
```

#### **Open in editor**

```bash
playground topic consume --topic a-topic --open
```

<!-- tabs:end -->

## 🧙 How to install other connectors

Simplest option is to create a reproduction model with `playground repro bootstrap` [command](/playground%20repro%20bootstrap) and then select "🔌 Add connector plugin" (you can call it multiple times to add multiple connector plugins/SMT) 

<img width="774" height="285" alt="CleanShot 2026-01-13 at 14 42 46" src="https://github.com/user-attachments/assets/e1489b80-8d01-48c2-906a-b359230104e8" />

it has interactive selection from confluent hub:

<img width="966" height="512" alt="CleanShot 2026-01-13 at 14 43 09" src="https://github.com/user-attachments/assets/a36e909a-4104-47c7-9637-31a902976141" />

It will automatically add the plugin(s) to the list of `CONNECT_PLUGIN_PATH`:

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

It can also be done non-interactively with `--connector-plugin` (repeatable):

```bash
playground repro bootstrap -f s3-sink<tab> --description "s3 sink with transforms" --connector-plugin confluentinc/connect-transforms
```

> [!TIP]
> You can also specify versions when specifying multiple connector/SMT, see [here](https://kafka-docker-playground.io/#/how-to-use?id=%f0%9f%94%97-for-connectors).


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
 
In this example, the connector version is `10.1.1`, so switch to branch tag `v10.1.1` (use the version you are actually running, see `playground connector versions`):

![remote_debugging](./images/remote_debugging2.jpg)

4. Remote debugging is enabled by default on the `connect` container (port `5005`), so there is nothing to do for connectors.

For other containers (for example `broker` or `schema-registry`), use [🧠 CLI](/cli) with `enable-remote-debugging` [command](/playground%20debug%20enable-remote-debugging):

```bash
$ playground debug enable-remote-debugging -c broker
```

It sets `KAFKA_DEBUG` and `JAVA_DEBUG_OPTS` environment variables on the container (using `playground container set-environment-variables`) and displays the configuration to add in `.vscode/launch.json`.

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

6. Go in `Run and Debug` and make sure to select the `Debug connect container` config:

![remote_debugging](./images/remote_debugging5.jpg)

7. Click on the green play button

![remote_debugging](./images/remote_debugging6.jpg)

8. Add breakpoint(s) where you want, for example [here](https://github.com/confluentinc/kafka-connect-hdfs/blob/9a5e68d7294a79c40050efd7b51d7428c7f7c4d5/src/main/java/io/confluent/connect/hdfs/TopicPartitionWriter.java#L894):

![remote_debugging](./images/remote_debugging4.jpg)

9. Process some messages:

```bash
playground topic produce -t test_hdfs --nb-messages 10 << 'EOF'
{
  "type": "record",
  "name": "myrecord",
  "fields": [
    {"name": "f1", "type": "string"}
  ]
}
EOF
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

Or just use [CLI](/playground%20connector%20log-level) `playground connector log-level` 

To have the levels set before the example creates its connector (so that the first lines are already at `TRACE`), use `--connect-log-level` option of [playground run](/playground%20run), with the same syntax as `CONNECT_LOG4J_LOGGERS` (levels `INFO`, `WARN`, `DEBUG` or `TRACE`). In the menu, 🔊 Connect log level(s) suggests the packages of the example's connector:

```bash
playground run -f s3-sink<tab> --connect-log-level "io.confluent.connect.s3=TRACE,org.apache.kafka.connect.runtime.WorkerSinkTask=DEBUG"
```

Example:

```bash
playground connector log-level --level TRACE
```

### 🔑 SSL debug

> [!NOTE]
> The default `connect` service already sets `KAFKA_OPTS: -Ddynamic.worker.config.file=/dev/null` (see [`environment/plaintext/docker-compose.yml`](https://github.com/vdesabou/kafka-docker-playground/blob/master/environment/plaintext/docker-compose.yml)), so keep it when you override `KAFKA_OPTS` in the snippets below.

Add `-Djavax.net.debug=all` in your `docker-compose` file:

*Example:*

```yml
  connect:
    environment:
      KAFKA_OPTS: -Ddynamic.worker.config.file=/dev/null -Djavax.net.debug=all
```

Use `-Djavax.net.debug=ssl:handshake` instead of `-Djavax.net.debug=all` to only see the handshake.

Or just use [CLI](/playground%20debug%20java-debug) `playground debug java-debug` with `--type ssl_all` or `--type ssl_handshake`.

### 🔒 Kerberos debug

Add `-Dsun.security.krb5.debug=true` in your `docker-compose` file:

*Example:*

```yml
  connect:
    environment:
      KAFKA_OPTS: -Ddynamic.worker.config.file=/dev/null -Dsun.security.krb5.debug=true
```

Or just use [CLI](/playground%20debug%20java-debug) `playground debug java-debug` with `--type kerberos`.

### 🔬 Class loading

Add `-verbose:class` in your `docker-compose` file to troubleshoot a `ClassNotFoundException` for example:

*Example:*

```yml
  connect:
    environment:
      KAFKA_OPTS: -Ddynamic.worker.config.file=/dev/null -verbose:class
```

Or just use [CLI](/playground%20debug%20java-debug) `playground debug java-debug` with `--type class_loading`.

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
      KAFKA_OPTS: -Ddynamic.worker.config.file=/dev/null -Djava.util.logging.config.file=/tmp/logging.properties
```

This is how the `logging.properties` looks like:

```bash
$ cat /tmp/logging.properties
handlers=java.util.logging.ConsoleHandler
java.util.logging.ConsoleHandler.level=ALL
com.google.api.client.http.level=ALL
```

### 🌍 Debug HTTP sink

This connector uses low level [Apache HTTP client](https://hc.apache.org/httpcomponents-client-5.2.x/) library.

In order to activate debug logs to see requests/responses, you can add `jcl-over-slf4j-2.0.7.jar` to the connector `lib` folder before starting the environment.

Example (from [`http_basic_auth.sh`](https://github.com/vdesabou/kafka-docker-playground/blob/master/connect/connect-http-sink/http_basic_auth.sh)):

```bash
cd ../../connect/connect-http-sink/
if [ ! -f jcl-over-slf4j-2.0.7.jar ]
then
     wget -q https://repo1.maven.org/maven2/org/slf4j/jcl-over-slf4j/2.0.7/jcl-over-slf4j-2.0.7.jar
fi
mkdir -p ../../confluent-hub/confluentinc-kafka-connect-http/lib/
cp jcl-over-slf4j-2.0.7.jar ../../confluent-hub/confluentinc-kafka-connect-http/lib/jcl-over-slf4j-2.0.7.jar
cd -
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

### 🕵️‍♂️ See TLS traffic with mitmproxy

[mitmproxy](https://github.com/mitmproxy/mitmproxy) 

1. Add `mitmproxy` container in your `docker-compose` file:

```yml
  mitmproxy:
    image: mitmproxy/mitmproxy
    hostname: mitmproxy
    container_name: mitmproxy
    command: mitmdump --flow-detail 4
    ports:
      - "8080:8080"
    volumes:
      - $HOME/.mitmproxy:/home/mitmproxy/.mitmproxy
```

2. Add in your script after all containers are started:

```bash
playground container cp --source $HOME/.mitmproxy/mitmproxy-ca-cert.pem --destination connect:/tmp/mitmproxy-ca-cert.pem
playground container exec -c connect --root --command "cat /tmp/mitmproxy-ca-cert.pem >> /etc/ssl/certs/ca-bundle.crt"
playground container exec -c connect --root --command "keytool -importcert --cacerts -storepass changeit -noprompt -alias mitmproxy -file /tmp/mitmproxy-ca-cert.pem"
```

3. Use mitmproxy proxy in your connector config:

Example:

```json
"proxy.url": "mitmproxy:8080"
```

4. Check TLS traffic in clear text by checking logs of `mitmproxy` container

```bash
playground container logs -c mitmproxy

or

playground container logs --open --container mitmproxy
```

### 🕵 TCP Dump

When logs are not enough to understand a connectivity problem (connection resets, timeouts, TLS handshake failures, a client talking to the wrong host or port, unexpected retries…), capturing the network traffic of a container shows exactly what goes over the wire.

Just use [CLI](/playground%20debug%20tcp-dump) `playground debug tcp-dump`. It installs `tcpdump` in the container if needed, captures the traffic for `--duration` seconds (default 30, all ports unless `--port` is set), copies the resulting `.pcap` file to the current directory and opens it with [Wireshark](https://www.wireshark.org/) if it is installed. Start it, then reproduce the issue while the capture is running.

> [!NOTE]
> On an encrypted listener (SSL, SASL_SSL) you will see the TCP connections and the TLS handshake, but not the content of the requests. To read HTTPS traffic in clear text, use [mitmproxy](/reusables?id=%f0%9f%95%b5%ef%b8%8f%e2%80%8d%e2%99%82%ef%b8%8f-see-tls-traffic-with-mitmproxy) instead.

```bash
playground debug tcp-dump --container control-center --port 9021 --duration 60
```

### 👻 Heap Dump

A [heap dump](https://www.baeldung.com/java-heap-dump-capture) is a snapshot of all the objects in the JVM memory. Take one when a component uses more and more memory, spends its time in garbage collection or fails with `java.lang.OutOfMemoryError`, to find which objects (and which connector, task or client) hold the memory.

Just use [CLI](/playground%20debug%20heap-dump) `playground debug heap-dump`. It saves output to a `.hprof` file that can be read with [VisualVM](https://visualvm.github.io/) or [MAT](https://www.eclipse.org/mat/), or analyzed with [`playground analyze heap-dump`](/playground%20analyze%20heap-dump) (Eclipse MAT leak suspects, see [Analyze what you collected](/reusables?id=%f0%9f%94%8e-analyze-what-you-collected)).

```bash
playground debug heap-dump
playground debug heap-dump -c connect -c broker
playground debug heap-dump --container schema-registry --live
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

A [Java thread dump](https://www.baeldung.com/java-thread-dump) shows what every thread of the JVM is doing at that moment, with its stack trace and the locks it holds or waits for. Take one when a connector or task looks stuck (no progress, no error in the logs), when a rebalance or shutdown never completes, or when a container uses a lot of CPU. Take several a few seconds apart: a thread that stays on the same stack is the one to look at.

Just use [CLI](/playground%20debug%20thread-dump) `playground debug thread-dump`. It saves output to a file and opens it with the editor set with `playground config editor`.

```bash
playground debug thread-dump
playground debug thread-dump -c connect -c broker
```
Analyze the dumps with [`playground analyze thread-dump`](/playground%20analyze%20thread-dump): deadlocks, lock contention, stuck and CPU-hungry threads (it can also take the dumps itself with `--container`).

### 🛩️ Flight Recorder

[Java Flight Recorder](https://www.baeldung.com/java-flight-recorder-monitoring) (JFR) records what happens in the JVM over a period of time with a low overhead: CPU usage per method, memory allocations, garbage collections, lock contention, file and socket I/O. Use it for performance problems (slow throughput, latency spikes, high CPU) where a single thread or heap dump is not enough.

Just use [CLI](/playground%20debug%20flight-recorder) `playground debug flight-recorder`: start the recording, reproduce the issue, then stop it. Stopping copies the `.jfr` file to the current directory; open it with [JDK Mission Control](https://jdk.java.net/jmc/).

> [!NOTE]
> The command needs `jcmd`: if the image only has a JRE, it installs JDK 17 with `playground container change-jdk`, which restarts the container.

```bash
playground debug flight-recorder --action start
playground debug flight-recorder --action stop
```

### 🧰 More debug commands

| Command | Description |
|---|---|
| [`playground debug java-debug`](/playground%20debug%20java-debug) | 🤎 JVM arguments for SSL, Kerberos or Class Loading |
| [`playground debug generate-diagnostics`](/playground%20debug%20generate-diagnostics) | ⛑️ Generate a diagnostic bundle with Diagnostics Bundle Tool |
| [`playground debug jscissors`](/playground%20debug%20jscissors) | ✂️ Instrumentation framework to analyse control flow and perform specific logging |
| [`playground debug testssl`](/playground%20debug%20testssl) | 🔐 Test TLS/SSL encryption using [testssl.sh](https://testssl.sh/) |
| [`playground debug disable-remote-debugging`](/playground%20debug%20disable-remote-debugging) | Disable java remote debugging for a container |

## 🔎 Analyze what you collected

The [`playground analyze`](/playground%20analyze) commands turn a dump, a log, a bundle or a report (yours, or one a
customer sent) into findings: what is wrong, with the evidence, and what to do. They all work offline, and
**`--sample <name>`** runs them on the samples shipped with the playground, to see what they report before using them on
real data.

| Command | Analyzes | Try it |
|---|---|---|
| [`playground analyze thread-dump`](/playground%20analyze%20thread-dump) | 🧵 thread dumps: deadlocks, lock contention, stuck and CPU-hungry threads | `--sample deadlock_jdk21` |
| [`playground analyze gc-logs`](/playground%20analyze%20gc-logs) | 📈 GC logs: pauses, failures, live set, leak trend | `--sample jdk21_g1_kafka_real` |
| [`playground analyze heap-dump`](/playground%20analyze%20heap-dump) | 🔬 heap dumps with Eclipse MAT: leak suspects, retained sizes, growth between two dumps | `--sample leak_growth` |
| [`playground analyze logs`](/playground%20analyze%20logs) | 🔥 ERROR/FATAL digest of log files, folders, zip / tar bundles | `--sample support_bundle` |
| [`playground analyze oracle-xstream-report`](/playground%20analyze%20oracle-xstream-report) | 🅾️ Oracle XStream CDC diagnostics reports (`orclcdc_diag.sql`) | `--sample synthetic_failures` |
| [`playground analyze cfk-bundle`](/playground%20analyze%20cfk-bundle) | 📦 CFK support bundles: pods, events, custom resources, logs | `--sample synthetic` |

```bash
playground analyze thread-dump --sample deadlock_jdk21
playground analyze thread-dump --container connect                 # 3 dumps of the running connect worker
playground analyze logs --file ./customer-logs.zip
playground analyze heap-dump --file heap-dump-connect-2026-10-14.hprof
```

Besides the text digest, they write a self-contained HTML report to share in a case (opened in your browser), and most
of them accept `--json` for scripts and agents.

## 🚫 Blocking traffic

To reproduce what happens when a component cannot reach another one (a broker, Schema Registry, a database or an external API going down, a firewall dropping packets), a reproduction model can block the traffic between containers or to an external host, then unblock it to check how the connector or client recovers.

Just use [CLI](/playground%20debug%20block-traffic) `playground debug block-traffic`. It uses `iptables` (installed in the container if needed) to drop the traffic from one or more containers to a destination (container name, host name or IP address), optionally on a single `--port`. Run it again with `--action stop` to restore the traffic.

```bash
playground debug block-traffic --destination google.com --action start
playground debug block-traffic --container schema-registry --destination broker --port 9092 --action start
playground debug block-traffic -c connect -c ksqldb-server --destination schema-registry --action stop
```

## 🐌 Add latency, packet loss or corruption

Some issues only happen on a slow or unreliable network: request timeouts, retries, rebalances, producer or consumer errors. A reproduction model can simulate them by adding latency, packet loss or packet corruption between two containers.

The playground provides functions (in [`scripts/cli/src/lib/utils_function.sh`](https://github.com/vdesabou/kafka-docker-playground/blob/master/scripts/cli/src/lib/utils_function.sh)) based on [`tc`](https://man7.org/linux/man-pages/man8/tc.8.html):

| Function | Usage |
|---|---|
| `add_latency` | `add_latency <src_container> <dst_container or ip> <latency>`, e.g. `add_latency connect broker 100ms` |
| `add_packet_loss` | `add_packet_loss <src_container> <dst_container or ip> <loss>`, e.g. `add_packet_loss connect broker 1%` |
| `add_packet_corruption` | `add_packet_corruption <src_container> <dst_container or ip> <corruption>`, e.g. `add_packet_corruption connect broker 1%` |
| `get_latency` | `get_latency <src_container> <dst_container>`: average ping time in ms |
| `clear_traffic_control` | `clear_traffic_control <src_container>`: removes all `tc` settings |

> [!TIP]
> A complete example is available [here](https://github.com/vdesabou/kafka-docker-playground/blob/master/other/monitoring-sink-latency/start.sh).

*Example:*

```bash
latency=$(get_latency connect broker)
log "Latency from connect to broker BEFORE traffic control: $latency ms"

add_latency connect broker 100ms

latency=$(get_latency connect broker)
log "Latency from connect to broker AFTER traffic control: $latency ms"

log "Clear traffic control"
clear_traffic_control connect
```

> [!NOTE]
> The source container needs the `tc` tool (`iproute-tc` package). The `connect` image used by the playground has it installed.

## 🧰 Useful functions for reproduction models

All examples source [`scripts/utils.sh`](https://github.com/vdesabou/kafka-docker-playground/blob/master/scripts/utils.sh), which loads the functions from [`scripts/cli/src/lib/utils_function.sh`](https://github.com/vdesabou/kafka-docker-playground/blob/master/scripts/cli/src/lib/utils_function.sh). The most useful ones:

| Function | Usage |
|---|---|
| `wait_for_log` | `wait_for_log "<message>" [container, default connect] [max wait in seconds, default 600]`: wait until a message appears in container logs. Prefer this over `sleep`. CLI equivalent: `playground container logs -c connect --wait-for-log "<message>" --max-wait 120` |
| `playground connector create-or-update --wait` | not a function but a flag: wait until the connector and all its tasks are RUNNING after creating it, and fail with the stack trace otherwise. Prefer this over `sleep` after creating a connector. Also `playground connector wait --connector <c>` and `playground topic wait-for-records --topic <t> --min-expected-messages N` |
| `wait_for_datagen_connector_to_inject_data` | `wait_for_datagen_connector_to_inject_data <connector name> <nb tasks>`: wait until a datagen connector has produced its configured number of messages |
| `retrycmd` | `retrycmd <max attempts> <sleep interval in seconds> <command>`: run a command until it succeeds, e.g. `retrycmd 10 5 check_my_condition` |
| `block_host` / `remove_partition` | `block_host <container> <ip>...` drops all traffic from a container to the given IPs, `remove_partition <container>...` removes it |
| `version_gt` | `if version_gt $TAG_BASE "7.9.99"; then ... fi`: compare versions |
| `connect_cp_version_greater_than_8` | `if connect_cp_version_greater_than_8; then ... fi`: true when the Connect image is CP 8.x or later |
| `get_3rdparty_file` | `get_3rdparty_file <file>`: download a third-party file (driver, jar...) if it is not already present |
| `install_connector_with_retry` | `install_connector_with_retry "<install command>"`: install a connector, with retries (`CONNECTOR_INSTALL_MAX_RETRIES`, default 5) |
| `create_topic` / `delete_topic` | `create_topic <topic>`: create or delete a topic on Confluent Cloud (uses the `confluent` CLI, for `ccloud` examples) |

## 🏚 Simulate TCP connections problems

[emicklei/zazkia](https://github.com/emicklei/zazkia) is a nice tool to simulate a TCP connection issues (reset,delay,throttle,corrupt).

Just use [CLI](/playground%20tcp-proxy) `playground tcp-proxy`.

Main commands (see [CLI](/playground%20tcp-proxy) for the full list):

| Command | Description |
|---|---|
| [`start`](/playground%20tcp-proxy%20start) | 💗 Start the TCP proxy and automatically replace connector config with zazkia hostname and port 49998 |
| [`open-ui`](/playground%20tcp-proxy%20open-ui) | 🌐 Open the Zazkia UI |
| [`get-connections`](/playground%20tcp-proxy%20get-connections) | 🧲 Get Zazkia active TCP connections config and stats |
| [`delay`](/playground%20tcp-proxy%20delay) | ⏲️ Add milliseconds delay to service response |
| [`break`](/playground%20tcp-proxy%20break) | 💔 Break sending the response to the client |
| [`close-connection`](/playground%20tcp-proxy%20close-connection) | ❌ Close the Zazkia active TCP connections |
| [`close-all-connection-with-error`](/playground%20tcp-proxy%20close-all-connection-with-error) | 🧹 Close all Zazkia TCP connections which are in error state |
| [`toggle-accept-connections`](/playground%20tcp-proxy%20toggle-accept-connections) | 🙅‍♂️ Change whether new connections can be accepted |
| [`toggle-reads-client`](/playground%20tcp-proxy%20toggle-reads-client) / [`toggle-reads-service`](/playground%20tcp-proxy%20toggle-reads-service) | ✅ Change whether reading data from the client / service is enabled |
| [`toggle-writes-client`](/playground%20tcp-proxy%20toggle-writes-client) / [`toggle-writes-service`](/playground%20tcp-proxy%20toggle-writes-service) | ✅ Change whether writing data to the client / service is enabled |

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

```nginx
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

5. In your connector configuration, update the proxy configuration parameter with `http://nginx-proxy:8888`.

*Example:*

```json
"s3.proxy.url": "http://nginx-proxy:8888"
```

> [!NOTE]
> If your proxy requires HTTP2 support, there is a full example available in this example: [GCP Pub/Sub Source connector](https://github.com/vdesabou/kafka-docker-playground/blob/master/connect/connect-gcp-pubsub-source/gcp-pubsub-source-nginx-proxy.sh)

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
  "s3.proxy.url": "http://squid:8888",
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

Some issues depend on the Java version or vendor (TLS protocols and cipher suites, a JVM bug, a library that needs a more recent Java, a difference seen only with the customer's JDK). To reproduce them, you can replace the JDK installed in a container image (connect, broker, control-center…) with another version or vendor.

Here are some examples:

### 🌀 Azul Zulu JDK

Just use [playground container change-jdk](/playground%20container%20change-jdk) CLI command !

Example:

```bash
$ playground container change-jdk --version 21 --container control-center 
17:03:25 ℹ️ 🤎 Installing Azul JDK 21 on container control-center /usr/lib/jvm/java-11-zulu-openjdk/bin/java
17:03:25 ℹ️ Executing command as root in container control-center with bash
Last metadata expiration check: 0:26:16 ago on Fri May 24 14:37:10 2024.
zulu-repo-1.0.0-1.noarch.rpm                    4.4 kB/s | 3.0 kB     00:00    
Package zulu-repo-1.0.0-1.noarch is already installed.
Dependencies resolved.
Nothing to do.
Complete!
Last metadata expiration check: 0:26:17 ago on Fri May 24 14:37:10 2024.
Dependencies resolved.
================================================================================
 Package                     Architecture Version       Repository         Size
================================================================================
Installing:
 zulu21-jdk                  aarch64      21.0.3-1      zulu-openjdk      4.3 k
Installing dependencies:
 zulu21-ca-doc               aarch64      21.0.3-1      zulu-openjdk      232 k
 zulu21-ca-jdk               aarch64      21.0.3-1      zulu-openjdk       23 k
 zulu21-ca-jdk-headless      aarch64      21.0.3-1      zulu-openjdk       81 M
 zulu21-ca-jre               aarch64      21.0.3-1      zulu-openjdk      354 k
 zulu21-ca-jre-headless      aarch64      21.0.3-1      zulu-openjdk       47 M
 zulu21-doc                  aarch64      21.0.3-1      zulu-openjdk      4.2 k
 zulu21-jdk-headless         aarch64      21.0.3-1      zulu-openjdk      4.3 k
 zulu21-jre                  aarch64      21.0.3-1      zulu-openjdk      4.2 k
 zulu21-jre-headless         aarch64      21.0.3-1      zulu-openjdk      4.2 k

Transaction Summary
================================================================================
Install  10 Packages

Total download size: 128 M
Installed size: 295 M
Downloading Packages:
(1/10): zulu21-ca-jdk-21.0.3-1.aarch64.rpm      180 kB/s |  23 kB     00:00    
(2/10): zulu21-ca-doc-21.0.3-1.aarch64.rpm      1.2 MB/s | 232 kB     00:00    
(3/10): zulu21-ca-jre-21.0.3-1.aarch64.rpm      1.5 MB/s | 354 kB     00:00    
(4/10): zulu21-doc-21.0.3-1.aarch64.rpm          36 kB/s | 4.2 kB     00:00    
(5/10): zulu21-jdk-21.0.3-1.aarch64.rpm          66 kB/s | 4.3 kB     00:00    
(6/10): zulu21-jdk-headless-21.0.3-1.aarch64.rp  36 kB/s | 4.3 kB     00:00    
(7/10): zulu21-jre-21.0.3-1.aarch64.rpm          76 kB/s | 4.2 kB     00:00    
(8/10): zulu21-jre-headless-21.0.3-1.aarch64.rp 100 kB/s | 4.2 kB     00:00    
(9/10): zulu21-ca-jre-headless-21.0.3-1.aarch64 3.2 MB/s |  47 MB     00:14    
(10/10): zulu21-ca-jdk-headless-21.0.3-1.aarch6 5.3 MB/s |  81 MB     00:15    
--------------------------------------------------------------------------------
Total                                           8.4 MB/s | 128 MB     00:15     
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Running scriptlet: zulu21-ca-jre-headless-21.0.3-1.aarch64                1/1 
  Running scriptlet: zulu21-ca-jdk-headless-21.0.3-1.aarch64                1/1 
  Running scriptlet: zulu21-ca-jre-21.0.3-1.aarch64                         1/1 
  Running scriptlet: zulu21-jre-headless-21.0.3-1.aarch64                   1/1 
  Running scriptlet: zulu21-ca-doc-21.0.3-1.aarch64                         1/1 
  Running scriptlet: zulu21-ca-jdk-21.0.3-1.aarch64                         1/1 
  Running scriptlet: zulu21-doc-21.0.3-1.aarch64                            1/1 
  Running scriptlet: zulu21-jdk-headless-21.0.3-1.aarch64                   1/1 
  Running scriptlet: zulu21-jre-21.0.3-1.aarch64                            1/1 
  Running scriptlet: zulu21-jdk-21.0.3-1.aarch64                            1/1 
  Preparing        :                                                        1/1 
  Installing       : zulu21-ca-jre-headless-21.0.3-1.aarch64               1/10 
  Running scriptlet: zulu21-ca-jre-headless-21.0.3-1.aarch64               1/10 
  Installing       : zulu21-ca-jdk-headless-21.0.3-1.aarch64               2/10 
  Running scriptlet: zulu21-ca-jdk-headless-21.0.3-1.aarch64               2/10 
  Installing       : zulu21-ca-jre-21.0.3-1.aarch64                        3/10 
  Running scriptlet: zulu21-ca-jre-21.0.3-1.aarch64                        3/10 
  Installing       : zulu21-jre-headless-21.0.3-1.aarch64                  4/10 
  Running scriptlet: zulu21-jre-headless-21.0.3-1.aarch64                  4/10 
  Installing       : zulu21-ca-doc-21.0.3-1.aarch64                        5/10 
  Running scriptlet: zulu21-ca-doc-21.0.3-1.aarch64                        5/10 
  Installing       : zulu21-ca-jdk-21.0.3-1.aarch64                        6/10 
  Running scriptlet: zulu21-ca-jdk-21.0.3-1.aarch64                        6/10 
  Installing       : zulu21-doc-21.0.3-1.aarch64                           7/10 
  Running scriptlet: zulu21-doc-21.0.3-1.aarch64                           7/10 
  Installing       : zulu21-jdk-headless-21.0.3-1.aarch64                  8/10 
  Running scriptlet: zulu21-jdk-headless-21.0.3-1.aarch64                  8/10 
  Installing       : zulu21-jre-21.0.3-1.aarch64                           9/10 
  Running scriptlet: zulu21-jre-21.0.3-1.aarch64                           9/10 
  Installing       : zulu21-jdk-21.0.3-1.aarch64                          10/10 
  Running scriptlet: zulu21-jdk-21.0.3-1.aarch64                          10/10 
  Running scriptlet: zulu21-ca-jre-headless-21.0.3-1.aarch64              10/10 
  Running scriptlet: zulu21-ca-jdk-headless-21.0.3-1.aarch64              10/10 
  Running scriptlet: zulu21-ca-jre-21.0.3-1.aarch64                       10/10 
  Running scriptlet: zulu21-jre-headless-21.0.3-1.aarch64                 10/10 
  Running scriptlet: zulu21-ca-doc-21.0.3-1.aarch64                       10/10 
  Running scriptlet: zulu21-ca-jdk-21.0.3-1.aarch64                       10/10 
  Running scriptlet: zulu21-doc-21.0.3-1.aarch64                          10/10 
  Running scriptlet: zulu21-jdk-headless-21.0.3-1.aarch64                 10/10 
  Running scriptlet: zulu21-jre-21.0.3-1.aarch64                          10/10 
  Running scriptlet: zulu21-jdk-21.0.3-1.aarch64                          10/10 
  Verifying        : zulu21-ca-doc-21.0.3-1.aarch64                        1/10 
  Verifying        : zulu21-ca-jdk-21.0.3-1.aarch64                        2/10 
  Verifying        : zulu21-ca-jdk-headless-21.0.3-1.aarch64               3/10 
  Verifying        : zulu21-ca-jre-21.0.3-1.aarch64                        4/10 
  Verifying        : zulu21-ca-jre-headless-21.0.3-1.aarch64               5/10 
  Verifying        : zulu21-doc-21.0.3-1.aarch64                           6/10 
  Verifying        : zulu21-jdk-21.0.3-1.aarch64                           7/10 
  Verifying        : zulu21-jdk-headless-21.0.3-1.aarch64                  8/10 
  Verifying        : zulu21-jre-21.0.3-1.aarch64                           9/10 
  Verifying        : zulu21-jre-headless-21.0.3-1.aarch64                 10/10 

Installed:
  zulu21-ca-doc-21.0.3-1.aarch64           zulu21-ca-jdk-21.0.3-1.aarch64       
  zulu21-ca-jdk-headless-21.0.3-1.aarch64  zulu21-ca-jre-21.0.3-1.aarch64       
  zulu21-ca-jre-headless-21.0.3-1.aarch64  zulu21-doc-21.0.3-1.aarch64          
  zulu21-jdk-21.0.3-1.aarch64              zulu21-jdk-headless-21.0.3-1.aarch64 
  zulu21-jre-21.0.3-1.aarch64              zulu21-jre-headless-21.0.3-1.aarch64 

Complete!
17:03:54 ℹ️ Executing command as root in container control-center with bash
17:03:54 ℹ️ Restarting docker container control-center
control-center
17:04:02 ℹ️ Executing command in container control-center with bash
openjdk version "21.0.3" 2024-04-16 LTS
OpenJDK Runtime Environment Zulu21.34+19-CA (build 21.0.3+9-LTS)
OpenJDK 64-Bit Server VM Zulu21.34+19-CA (build 21.0.3+9-LTS, mixed mode, sharing)
```

### ⭕️ Oracle JDK

Here are the steps to follow:

1. Get the Oracle JDK `.rpm` version link you want to install from the [website](https://www.oracle.com/java/technologies/downloads/). In our example, that will be `jdk-21_linux-x64_bin.rpm`

> [!NOTE]
> CP 8.x requires Java 17 or later, so pick a JDK 17+ build. CP images are based on UBI minimal, which ships `microdnf` and not `yum`: the `Dockerfile` below installs `yum` first.

2. Add this in your `docker-compose` file:

```yml
  connect:
    build:
      context: ../../connect/connect-filestream-sink/
      args:
        CP_CONNECT_IMAGE: ${CP_CONNECT_IMAGE}
        CP_CONNECT_TAG: ${CP_CONNECT_TAG}
```
> [!WARNING]
> Make sure to update `context` above with the right path.

3. Create a `Dockerfile` file in `context` directory above (`../../connect/connect-filestream-sink/`).

```dockerfile
ARG CP_CONNECT_IMAGE
ARG CP_CONNECT_TAG
FROM ${CP_CONNECT_IMAGE}:${CP_CONNECT_TAG}
COPY jdk-21_linux-x64_bin.rpm /tmp/
USER root
RUN if command -v microdnf >/dev/null 2>&1; then microdnf -y install yum; fi \
 && yum -y install /tmp/jdk-21_linux-x64_bin.rpm \
 && alternatives --set java /usr/lib/jvm/jdk-21-oracle-x64/bin/java \
 && rm /tmp/jdk-21_linux-x64_bin.rpm
USER appuser
```

> [!WARNING]
> Make sure to update `alternatives --set java` above with the right path.

4. Verify the correct JDK version is installed once your test is started:

```bash
playground container exec -c connect --command "java -version"
```

## 🏎️ Performance testing

Here are some tips and tricks to create reproduction models that require high volume of data.

> [!TIP]
> It is highly recommended to enable [JMX Grafana](https://kafka-docker-playground.io/#/how-to-use?id=%f0%9f%93%8a-enabling-jmx-grafana) when you're doing performance testing, to see CPU/Memory and all JMX metrics.

### ⏱️ Benchmark a connector

[playground connector benchmark](https://kafka-docker-playground.io/#/playground%20connector%20benchmark) measures the throughput of a running self managed connector, so that you can compare two runs: another `--connector-tag`, another config, another number of tasks, or the numbers of a customer.

By default (`--mode drain`), it pauses the connector, loads a backlog of `--nb-records`, resumes the connector and measures the time it takes to process it. This is the most reproducible number, since it does not depend on how fast the load is generated. `--mode steady` measures the throughput during `--duration` while a load runs in the background.

```bash
# sink: the 'playground topic produce' of the example script is replayed with 3M records
playground connector benchmark --nb-records 3000000

# source: rows inserted in the source database by the benchmark-load.bash of the example
playground connector benchmark --nb-records 1000000 --shape bulk
playground connector benchmark --nb-records 100000 --shape small-txn
playground connector benchmark --nb-records 1000000 --shape update

# throughput during 5 minutes, with a load running in the background
playground connector benchmark --mode steady --duration 5m
```

The load comes from the example:

* **sink connectors**: the `playground topic produce` of the example script that feeds the connector is replayed with `--nb-messages <n>` (same schema, key and headers), so it works with almost every sink example
* **source connectors**: `benchmark-load.bash` next to the example script, shipped with the JDBC and Debezium PostgreSQL, Debezium MySQL, JDBC and Debezium SQL Server, Oracle CDC, Oracle XStream, Debezium Oracle and JDBC Oracle examples. It loads rows in the `CUSTOMERS` table (`dbo.customers` for SQL Server), in one transaction (`--shape bulk`), one transaction per row (`--shape small-txn`) or as updates (`--shape update`, refused for a JDBC source in `incrementing` mode, which does not capture updates)
* or your own command with `--load-command` (drain) / `--stream-load-command` (steady), for example in a reproduction model (see below)

#### Your own load

Both commands run with `bash -c`, from the current directory. Give the schema of the records on stdin (`--value @file` only looks in the predefined schemas of the CLI).

**Drain** (`--load-command`): the command runs while the connector is paused, creates the records and returns. `--nb-records` is the number of records the connector should then process, unless the command prints a line `BENCHMARK_RECORDS=<n>`:

```bash
# sink: 1M records in the topic of the connector, with the schema of its records
playground connector benchmark --nb-records 1000000 \
  --load-command "playground topic produce -t my-topic --nb-messages 1000000 < my-schema.avsc"

# source: your own script, which inserts the rows and prints BENCHMARK_RECORDS=<n>
playground connector benchmark --load-command "./load-my-table.sh 500000"
```

**Steady** (`--stream-load-command`): the command runs in the background. At the end of the measure, the file named by the `BENCHMARK_STOP_FILE` environment variable is created: stop at the end of the current batch when it exists. The command is killed after 120s otherwise, and killing a producer in the middle of a batch can send a truncated record to the topic. Print `BENCHMARK_BATCH=<records> <epoch seconds>` after each batch, so that the summary can tell when the connector only kept up with the load:

```bash
playground connector benchmark --mode steady --duration 2m \
  --stream-load-command 'while [ ! -f "$BENCHMARK_STOP_FILE" ]; do playground topic produce -t my-topic --nb-messages 10000 < my-schema.avsc; echo "BENCHMARK_BATCH=10000 $(date +%s)"; done'
```

#### Is the connector the bottleneck?

A benchmark is only meaningful when the connector is what limits the throughput. The summary and the report warn when it isn't:

| Warning | Meaning |
| --- | --- |
| the connector kept up with the load | steady mode: the load generated about as many records as the connector processed (or the consumer lag of a sink stayed below one sample of records). This is the speed of the load: use `--mode drain` |
| the connector or its tasks were not RUNNING at N status checks | paused, restarting or rebalancing during the measure |
| the connect worker is CPU bound / spent X% of the time in gc pauses | ≥ 90% of the CPUs available to the worker, or > 10% of the time in GC pauses: the result reflects the docker host or the heap size (`KAFKA_HEAP_OPTS`) |
| the records are not spread across the tasks | an idle task, or one task doing most of the work: `tasks.max` greater than the number of partitions, key skew, or a connector that does not parallelize this load |
| N records went to the dead letter queue / were dropped by errors.tolerance=all | failing records are counted in the throughput |

At the end, it prints a summary (throughput with p50 / p95 / min per sample, put or poll batch time, running ratio, connect CPU), writes the samples (csv) and the result (json, also with `--json`) to `--output-dir`, and opens an HTML report with the charts. Each result is appended to a `benchmark-history` file, and compared with the previous benchmark of the same connector in the same example, mode and shape.

> [!NOTE]
> Everything runs on one docker host: the numbers are relative, compare runs on the same machine only. When the backlog is processed before the first sample, the throughput is only a lower bound (`≥`): increase `--nb-records` 10x. Fully managed connectors and the cfk environment are not supported yet.

### 👈 All sink connectors

Injecting lot of records into topic(s) is really easy using [playground topic produce](https://kafka-docker-playground.io/#/playground%20topic%20produce) CLI:

Example:

```bash
$ playground topic produce -t mytopic --value @predefined-schemas/avro/customer.avsc --nb-messages -1 --max-nb-messages-per-batch 300000  --sleep-time-between-batch 1  --record-size 1024
```

### 👉 Oracle

For all Oracle CDC and JDBC source connector with Oracle examples, you can easily inject load in table using, the following steps.

You can enable this by setting flag `--enable-sql-datagen`, it will start inserting rows at the end of the example for a duration that you can configure:

Example:

```bash
DURATION=10
log "Injecting data for $DURATION minutes"
playground container exec --container sql-datagen --command "bash -c \"java ${JAVA_OPTS} -jar sql-datagen-1.0-SNAPSHOT-jar-with-dependencies.jar --host oracle --username C##MYUSER --password mypassword --sidOrServerName sid --sidOrServerNameVal ORCLCDB --maxPoolSize 10 --durationTimeMin $DURATION\""
```

For PDB examples, use `--sidOrServerName service_name --sidOrServerNameVal ORCLPDB1` instead.

> [!TIP]
> You can increase throughput with `maxPoolSize`.

### 👉 Microsoft SQL Server

For all Debezium and JDBC source connector with Microsoft SQL Server examples, you can easily inject load in table using, the following steps.

You can enable this by setting flag `--enable-sql-datagen`, it will start inserting rows at the end of the example for a duration that you can configure:

Example:

```bash
DURATION=10
log "Injecting data for $DURATION minutes"
playground container exec --container sql-datagen --command "bash -c \"java ${JAVA_OPTS} -jar sql-datagen-1.0-SNAPSHOT-jar-with-dependencies.jar --username sa --password 'Password!' --connectionUrl 'jdbc:sqlserver://sqlserver:1433;databaseName=testDB;encrypt=false' --maxPoolSize 10 --durationTimeMin $DURATION\""
```

> [!TIP]
> You can increase throughput with `maxPoolSize`.

### 👉 PostgreSQL

For all Debezium and JDBC source connector with PostgreSQL examples, you can easily inject load in table using, the following steps.

You can enable this by setting flag `--enable-sql-datagen`, it will start inserting rows at the end of the example for a duration that you can configure:

Example:

```bash
DURATION=10
log "Injecting data for $DURATION minutes"
playground container exec --container sql-datagen --command "bash -c \"java ${JAVA_OPTS} -jar sql-datagen-1.0-SNAPSHOT-jar-with-dependencies.jar --connectionUrl 'jdbc:postgresql://postgres/postgres?user=myuser&password=mypassword&ssl=false' --maxPoolSize 10 --durationTimeMin $DURATION\""
```

> [!TIP]
> You can increase throughput with `maxPoolSize`.

### 👉 MySQL

For all Debezium and JDBC source connector with MySQL examples, you can easily inject load in table using, the following steps.

You can enable this by setting flag `--enable-sql-datagen`, it will start inserting rows at the end of the example for a duration that you can configure:

Example:

```bash
DURATION=10
log "Injecting data for $DURATION minutes"
playground container exec --container sql-datagen --command "bash -c \"java ${JAVA_OPTS} -jar sql-datagen-1.0-SNAPSHOT-jar-with-dependencies.jar --connectionUrl 'jdbc:mysql://mysql:3306/mydb?user=user&password=password&useSSL=false&allowPublicKeyRetrieval=true' --maxPoolSize 10 --durationTimeMin $DURATION\""
```

> [!TIP]
> You can increase throughput with `maxPoolSize`.

### 👉 MongoDB

Here is an example that I used to setup a reproduction environment where I inject 250 (`REQ`) req/s on 13 (`NB_COLLECTIONS`) collections. 
It is sending 50000 (`TOTAL_REQ`) records per collection.
The size of the record can be adjusted by changing the payload `{ _id : "Document " + j + "_" + i, first_name : 'john', last_name : 'hope', email : 'john@email/com', timestamp: new Date().getTime() }`

```bash
function inject () {
playground container exec -c mongodb --command "mongosh" << EOF
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

(optional) Add in your docker-compose file a EMQX MQTT broker:

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

Note: EMQX dashboard is available on http://localhost:18083/ (`admin`/`public`)

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
