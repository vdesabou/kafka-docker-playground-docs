# playground re-run

⚡ Simply re-run last example you ran with \<playground run\>

## Usage

```bash
playground re-run [OPTIONS] [ARGUMENTS...]
```

## Dependencies

#### *fzf*

visit https://github.com/junegunn/fzf#installation to install

## Options

#### *--clear*

🧼 Clear any previous flags

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

## Examples

```bash
playground re-run
```

```bash
playground re-run --tag 6.2.1
```


