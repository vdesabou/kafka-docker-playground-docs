# playground start-environment

🔐 Simply start an environment listed in https://kafka-docker-playground.io/#/content?id=%f0%9f%94%90-environments:  
  
- ccloud  
- 2way-ssl  
- kerberos  
- kraft-external-plaintext  
- kraft-plaintext  
- ldap-authorizer-sasl-plain  
- ldap-sasl-plain  
- mdc-kerberos  
- mdc-plaintext  
- mdc-sasl-plain  
- plaintext  
- rbac-sasl-plain  
- sasl-plain  
- sasl-scram  
- sasl-ssl  
- ssl_kerberos  
  
Note: when running an example with \<playground run\> or \<playground run-ccloud\>, it is already automatically done

## Usage

```bash
playground start-environment [OPTIONS]
```

## Options

#### *--environment ENVIRONMENT*

🔐 The environment to start .   
  
- ccloud  
- 2way-ssl  
- kerberos  
- kraft-external-plaintext  
- kraft-plaintext  
- ldap-authorizer-sasl-plain  
- ldap-sasl-plain  
- mdc-kerberos  
- mdc-plaintext  
- mdc-sasl-plain  
- plaintext  
- rbac-sasl-plain  
- sasl-plain  
- sasl-scram  
- sasl-ssl  
- ssl_kerberos  
  
Default is plaintext

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | plaintext
| Allowed Values: | ccloud, 2way-ssl, kerberos, kraft-external-plaintext, kraft-plaintext, ldap-authorizer-sasl-plain, ldap-sasl-plain, mdc-kerberos, mdc-plaintext, mdc-sasl-plain, plaintext, rbac-sasl-plain, sasl-plain, sasl-scram, sasl-ssl, ssl_kerberos

#### *--docker-compose-override-file, -f DOCKER-COMPOSE-OVERRIDE-FILE*

🔖 docker-compose override file  
  
❕ It must be absolute full path

#### *--tag TAG*

🎯 Confluent Platform (CP) version to use  
  
Must be greater or equal to 5.0.0

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

## Examples

```bash
playground start-environment
```

```bash
playground start-environment --environment rbac-sasl-plain
```


