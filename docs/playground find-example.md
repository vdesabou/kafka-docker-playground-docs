# playground find-example

🔎 Find examples matching a free-text query, without the interactive picker

Searches every runnable example script (connect/, ccloud/, ksqldb/,  
flink/, reproduction-models/, ...) by path, connector class, README title  
and script body. Every word of the query must match somewhere; matches in  
the path and connector class rank higher than matches in the body.

Prints the ready-to-paste `playground run -f` command for each hit, best  
first. Use `playground run` instead to browse examples interactively.  
Use `playground find-command` to find a command instead.

## Usage

```bash
playground find-example [QUERY] [OPTIONS] [--] [MORE QUERY WORDS...]
```

## Arguments

#### `QUERY`

🔤 Free-text query, e.g. "oracle cdc ssl", "fully managed s3 sink" or "jdbc source proxy"

Optional with `--category`: every example of the category is listed.

#### *MORE QUERY WORDS...*

extra words are appended to the query, so quoting it is optional

## Options

#### `--category CATEGORY`

📂 Restrict the search to one top-level folder, or to one topic across all folders

Topics, matched on the path, README title, default environment and  
playground commands of the examples:

- security: RBAC, LDAP, Kerberos, SASL, SSL / mTLS, OAuth, ACLs,

audit logs, secrets, CSFLE, examples defaulting to a secured environment  
or using playground rbac / tools cert

- broker: brokers, topics, transactions, KRaft, tiered storage, quotas,

reassignment, replication between clusters (multi-data-center/,  
Cluster Linking, MirrorMaker 2, Replicator), examples using  
playground broker

- cfk: Confluent for Kubernetes, examples defaulting to the cfk or

cfk-rbac environment (every connect/ example also runs with  
`--environment` cfk)

- client: producer / consumer and client examples (Java, .NET,

JavaScript, Python, Go, JMS, kcat)

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `connect`, `ccloud`, `ksqldb`, `flink`, `schema-registry`, `rest-proxy`, `multi-data-center`, `other`, `operator`, `academy`, `environment`, `reproduction-models`, `security`, `broker`, `cfk`, `client`

#### `--limit LIMIT`

🔢 Maximum number of hits (default 10)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `10`

#### `--json`

📗 Print the hits as a JSON array, best first, and nothing else

Each hit has script (absolute path), path (relative to the repository),  
title (README), connector_classes, environment, score and run_command.  
No hit prints [] and exits with code 1.

🎓 Tip: use it in scripts and from AI agents, for example with  
jq -r '.[0].script'

## Examples

```bash
playground find-example "s3 sink proxy"
```

```bash
playground find-example debezium postgres fully managed
```

```bash
playground find-example "oracle cdc ssl" --category connect --limit 3
```

```bash
playground find-example --category security --limit 50
```

```bash
playground find-example oauth --category security
```

```bash
playground find-example "http sink oauth" --json --limit 3 | jq -r '.[].script'
```

## Example output

```text
$ playground find-example "oracle cdc ssl" --limit 2
17:22:22 ℹ️ 🔎 examples matching "oracle cdc ssl", best first
playground run -f ~/kafka-docker-playground/connect/connect-cdc-xstream-oracle19-source/cdc-xstream-oracle19-ssl.sh
    Oracle XStream CDC Source (Oracle 19c) Source connector · io.confluent.connect.oracle.xstream.cdc.OracleXStreamSourceConnector · plaintext
playground run -f ~/kafka-docker-playground/connect/connect-cdc-oracle19-source/cdc-oracle19-cdb-table-ssl.sh
    Oracle CDC Source (Oracle 19c) Source connector · io.confluent.connect.oracle.cdc.OracleCdcSourceConnector · plaintext
```

```text
$ playground find-example "s3 sink" --limit 1 --json
[
  {
    "script": "~/kafka-docker-playground/connect/connect-aws-s3-sink/s3-sink.sh",
    "path": "connect/connect-aws-s3-sink/s3-sink.sh",
    "title": "S3 Sink connector",
    "connector_classes": [
      "io.confluent.connect.s3.S3SinkConnector"
    ],
    "environment": "plaintext",
    "score": 41.8,
    "run_command": "playground run -f ~/kafka-docker-playground/connect/connect-aws-s3-sink/s3-sink.sh"
  }
]
```


