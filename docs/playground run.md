# playground run

🕹️ Run any example, except for Confluent Cloud (in this case use run-ccloud command)

## Usage

```bash
playground run [OPTIONS] [ARGUMENTS...]
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

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--open, -o*

📖 Opening example file with text editor set with playground config editor \<editor\> (default is code)

#### *--tag TAG*

🎯 Confluent Platform (CP) version to use  
  
Must be greater or equal to 5.0.0

#### *--connector-tag CONNECTOR_TAG*

🔗 Connector version to use  
  
By default, for each connector, the latest available version on Confluent Hub is used

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

#### *--enable-sr-maven-plugin-app*

🔰 Enable Schema Registry Maven plugin App

#### *--enable-sql-datagen*

🌪️ Enable SQL Datagen injection  
  
This only works for Oracle, MySql, Postgres and Microsoft Sql Server source connector examples with JDBC and Debezium

## Examples

```bash
playground run -f zendesk-source<tab> --tag 7.2.1 --enable-control-center <ZENDESK_URL> <ZENDESK_USERNAME> <ZENDESK_PASSWORD>
```

```bash
playground run -f jdbc<tab> --connector-tag 10.6.0 --enable-jmx-grafana --open
```


