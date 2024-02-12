# playground repro bootstrap

🛠  Bootstrap reproduction model  
  
👉 Check documentation https://kafka-docker-playground.io/#/reusables?id=%f0%9f%9b%a0-bootstrap-reproduction-model

## Usage

```bash
playground repro bootstrap [OPTIONS] [ARGUMENTS...]
```

## Options

#### *--tag TAG*

🎯 Confluent Platform (CP) version to use  
  
Must be greater or equal to 5.0.0

#### *--connector-tag CONNECTOR_TAG*

🔗 Connector version to use  
  
By default, for each connector, the latest available version on Confluent Hub is used  
  
🎓 Tip: set to " " in order to select the version dynamically

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--connector-zip*

#### *--connector-zip CONNECTOR_ZIP*

🤐 Connector zip to use  
  
❕ It must be absolute full path  
  
🎓 Tip: use \<tab\> completion to trigger fzf completion   
        use playground config folder_zip_or_jar \<folder1\> \<folder2\>... (default is home folder and current folder is always included) to configure where to search the files

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--connector-tag*

#### *--connector-jar CONNECTOR_JAR*

♨️ Connector jar to use  
  
❕ It must be absolute full path  
  
🎓 Tip: use \<tab\> completion to trigger fzf completion   
        use playground config folder_zip_or_jar \<folder1\> \<folder2\>... (default is home folder and current folder is always included) to configure where to search the files

#### *--enable-ksqldb*

🚀 Enable ksqlDB  
  
By default, ksqldb-server and ksqldb-cli containers are not started for every test

#### *--enable-rest-proxy*

🧲 Enable Rest Proxy  
  
By default, rest-proxy container is not started for every test

#### *--enable-control-center*

💠 Enable Control Center  
  
By default, control-center container is not started for every test  
  
Control Center is reachable at http://127.0.0.1:9021

#### *--enable-conduktor*

🐺 Enable Conduktor Platform  
  
By default, Conduktor Platform container is not started for every test  
  
Conduktor is reachable at http://127.0.0.1:8080/console (admin/admin)

#### *--enable-multiple-brokers*

3️⃣ Enable multiple brokers  
  
By default, there is only one broker node enabled

#### *--enable-multiple-connect-workers*

🥉 Enable multiple connect node  
  
By default, there is only one connect node enabled  
  
It only works when plaintext environment is used

#### *--enable-jmx-grafana*

Enable Grafana, Prometheus and Pyroscope  
  
📊 Grafana is reachable at http://127.0.0.1:3000 (login/password is admin/password)  
  
🛡️ Prometheus is reachable at http://127.0.0.1:9090  
  
📛 Pyroscope is reachable at http://127.0.0.1:4040

#### *--enable-kcat*

🐈‍⬛ Enable kcat  
  
You can use it with:  
  
$ docker exec kcat kcat -b broker:9092 -L

#### *--enable-sql-datagen*

🌪️ Enable SQL Datagen injection  
  
This only works for Oracle, MySql, Postgres and Microsoft Sql Server source connector examples with JDBC and Debezium

#### *--cluster-type CLUSTER-TYPE*

🔋 The cluster type: basic, standard or dedicated. Default is basic  
  
🎓 Tip: you can also use CLUSTER_TYPE environment variable

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | basic, standard, dedicated

#### *--cluster-region CLUSTER-REGION*

🗺 The Cloud region.   
  
🎓 Tip: you can also use CLUSTER_REGION environment variable

#### *--cluster-environment CLUSTER-ENVIRONMENT*

🌐 The environment id where want your new cluster (example: env-xxxxx)  
  
ℹ️ Optional, if not set, new environment will be created  
  
🎓 Tip: you can also use ENVIRONMENT environment variable

#### *--cluster-name CLUSTER-NAME*

🎰 The cluster name.   
  
❣️ Only required if you want to use your own existing cluster  
  
🎓 Tip: you can also use CLUSTER_NAME environment variable

#### *--cluster-creds CLUSTER-CREDS*

🔒 The Kafka api key and secret to use, it should be separated with semi-colon (example: \<API_KEY\>:\<API_KEY_SECRET\>)  
  
❣️ Only required if you want to use your own existing cluster  
  
🎓 Tip: you can also use CLUSTER_CREDS environment variable

#### *--cluster-schema-registry-creds CLUSTER-SCHEMA-REGISTRY-CREDS*

🔒 The Schema Registry api key and secret to use, it should be separated with semi-colon (example: \<SR_API_KEY\>:\<SR_API_KEY_SECRET\>)  
  
ℹ️ Optional, if not set, new credentials will be created  
  
❣️ Only required if you want to use your own existing cluster  
  
🎓 Tip: you can also use SCHEMA_REGISTRY_CREDS environment variable

#### *--file, -f FILE*

🔖 Example file to use as basis, if not set, currently running example is used  
  
❕ It must be absolute full path  
  
🎓 Tip: use \<tab\> completion to trigger fzf completion

#### *--description, -d DESCRIPTION*

💭 Description for the reproduction model

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--custom-smt*

⚙️ Add a custom SMT (which is a no-op)

#### *--pipeline SINK_FILE*

🔖 Sink example file to use for creating a pipeline. multiple --pipeline flags can be used to create a pipeline with multiple sinks.  
  
❕ It must be absolute full path.   
  
🎓 Tip: use \<tab\> completion to trigger fzf completion

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Conflicts With: | *--producer*

## Examples

```bash
playground repro bootstrap -f hdfs2<tab> -d "simple test"
```

```bash
playground repro bootstrap -f /full/path/hdfs2-sink.sh -d "testing with avro producer" --producer avro --producer-schema-value myschema<tab>
```

```bash
playground repro bootstrap -f hdfs2<tab> -d "testing with 2 protobuf producers" --producer protobuf --nb-producers 2
```

```bash
playground repro bootstrap -f hdfs2<tab> -d "testing custom smt" --custom-smt
```

```bash
playground repro bootstrap -f debeziumpostgres<tab> -d "create pipeline" --pipeline jdbcsink<tab>
```


