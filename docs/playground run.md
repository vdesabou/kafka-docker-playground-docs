# playground run

🕹️ Run any example !  
  
🔥 It start an interactive mode where you'll be fully guided !  
  
  
⛅ When running Confluent Cloud (ccloud) example:  
  
  All you have to do is to be already logged in with confluent CLI.  
  
  By default, a new Confluent Cloud environment with a Cluster will be created.  
  
  You can configure the new cluster by setting:  
  
  --cluster-type (or CLUSTER_TYPE environment variable): The type of cluster (possible values: basic, standard and dedicated, default basic)  
  --cluster-cloud (or CLUSTER_CLOUD environment variable): The Cloud provider (possible values: aws, gcp and azure, default aws)  
  --cluster-region (or CLUSTER_REGION environment variable): The Cloud region (use confluent kafka region list to get the list, default eu-west-2 for aws, westeurope for azure and europe-west2 for gcp)  
  --cluster-environment (or ENVIRONMENT environment variable) (optional): The environment id where want your new cluster (example: txxxxx)   
  
  In case you want to use your own existing cluster, you need to setup, in addition to previous ones:  
  
  --cluster-name (or CLUSTER_NAME environment variable): The cluster name  
  --cluster-creds (or CLUSTER_CREDS environment variable): The Kafka api key and secret to use, it should be separated with colon (example: \<API_KEY\>:\<API_KEY_SECRET\>)  
  --cluster-schema-registry-creds (or SCHEMA_REGISTRY_CREDS environment variable) (optional, if not set, new one will be created): The Schema Registry api key and secret to use, it should be separated with colon (example: \<SR_API_KEY\>:\<SR_API_KEY_SECRET\>)

## Usage

```bash
playground run [OPTIONS]
```

## Dependencies

#### *fzf*

visit https://github.com/junegunn/fzf#installation to install

## Options

#### *--environment ENVIRONMENT*

🔐 The environment to start when running a connector example   
  
- plaintext  
- ccloud  
- 2way-ssl  
- kerberos  
- kraft-external-plaintext  
- kraft-plaintext  
- ldap-authorizer-sasl-plain  
- ldap-sasl-plain  
- rbac-sasl-plain  
- sasl-plain  
- sasl-scram  
- sasl-ssl  
- ssl_kerberos  
  
Default is plaintext.  
This is only supported when example is a connector example

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | plaintext
| Allowed Values: | ccloud, plaintext, sasl-ssl, sasl-plain, 2way-ssl, sasl-scram, kraft-external-plaintext, kraft-plaintext, kerberos, ssl_kerberos, ldap-authorizer-sasl-plain, ldap-sasl-plain, rbac-sasl-plain

#### *--file, -f FILE*

🔖 Example file to run  
  
❕ It must be absolute full path  
  
🎓 Tip: use \<tab\> completion to trigger fzf completion

#### *--open, -o*

📖 Opening example file with text editor set with playground config editor \<editor\> (default is code)

#### *--tag TAG*

🎯 Confluent Platform (CP) version to use  
  
Must be greater or equal to 5.3.0  
  
🎓 Tip: use \<tab\> completion to trigger fzf completion

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

🤎 Connector jar to use  
  
❕ It must be absolute full path  
  
🎓 Tip: use \<tab\> completion to trigger fzf completion   
        use playground config folder_zip_or_jar \<folder1\> \<folder2\>... (default is home folder and current folder is always included) to configure where to search the files

#### *--enable-ksqldb*

🚀 Enable ksqlDB   
  
❗ not supported with ccloud examples  
  
By default, ksqldb-server and ksqldb-cli containers are not started for every test

#### *--enable-rest-proxy*

🧲 Enable Rest Proxy  
  
❗ not supported with ccloud examples  
  
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

🥉 Enable multiple connect worker node  
  
By default, there is only one connect worker node enabled

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

#### *--cluster-cloud CLUSTER-CLOUD*

🌤 The cloud provider: aws, gcp or azure. Default is aws  
  
🎓 Tip: you can also use CLUSTER_CLOUD environment variable

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | aws, gcp, azure

#### *--cluster-type CLUSTER-TYPE*

🔋 The cluster type: basic, standard or dedicated. Default is basic  
  
🎓 Tip: you can also use CLUSTER_TYPE environment variable

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | basic, standard, dedicated

#### *--cluster-region CLUSTER-REGION*

🗺 The Cloud region.   
  
🎓 Tip: you can also use CLUSTER_REGION environment variable  
🎓 Tip: use \<tab\> completion to trigger fzf completion

#### *--cluster-environment CLUSTER-ENVIRONMENT*

🌐 The environment id where want your new cluster (example: txxxxx)  
  
ℹ️ Optional, if not set, new environment will be created  
  
🎓 Tip: you can also use ENVIRONMENT environment variable  
🎓 Tip: use \<tab\> completion to trigger fzf completion

#### *--cluster-name CLUSTER-NAME*

🎰 The cluster name.   
  
❣️ Only required if you want to use your own existing cluster  
  
🎓 Tip: you can also use CLUSTER_NAME environment variable  
🎓 Tip: use \<tab\> completion to trigger fzf completion

#### *--cluster-creds CLUSTER-CREDS*

🔒 The Kafka api key and secret to use, it should be separated with colon (example: \<API_KEY\>:\<API_KEY_SECRET\>)  
  
❣️ Only required if you want to use your own existing cluster  
  
🎓 Tip: you can also use CLUSTER_CREDS environment variable

#### *--cluster-schema-registry-creds CLUSTER-SCHEMA-REGISTRY-CREDS*

🔒 The Schema Registry api key and secret to use, it should be separated with colon (example: \<SR_API_KEY\>:\<SR_API_KEY_SECRET\>)  
  
ℹ️ Optional, if not set, new credentials will be created  
  
❣️ Only required if you want to use your own existing cluster  
  
🎓 Tip: you can also use SCHEMA_REGISTRY_CREDS environment variable

## Examples

```bash
playground run (interactive mode)
```


