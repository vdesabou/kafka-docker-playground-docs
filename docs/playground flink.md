# playground flink

🐿️ Flink commands

Run Flink SQL and manage the jobs of the Flink cluster started with  
`playground run --enable-flink` (jobmanager REST API on port 18081), or  
the statements of a Confluent Cloud Flink compute pool (`--environment` ccloud,  
the default after a ccloud example).

- **sql**: run Flink SQL statements (stdin or `--file`) with the SQL client
- **table-ddl**: CREATE TABLE of a topic, columns from its Avro schema in Schema Registry
- **ui**: open the Flink UI (jobs, operators, checkpoints) in the browser
- **list-jobs**: jobs of the cluster with their state, start time and duration
- **cancel**: cancel a job, or all running jobs

🎓 Tip: the Flink UI is served on the same port as the REST API:  
http://localhost:18081 (`playground flink ui` opens it). See the flink/flink-sql-kafka example, and  
ccloud/flink-sql-kafka for Confluent Cloud.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-flink

## Usage

```bash
playground flink COMMAND
```

## Environment Variables

#### `PLAYGROUND_FLINK_ENVIRONMENT`

🌍 local or ccloud, when `--environment` is not set (default: ccloud when the last example ran on Confluent Cloud)

#### `FLINK_COMPUTE_POOL`

🧮 Confluent Cloud: id of the Flink compute pool (lfcp-xxx). Default: the pool stored by ccloud/flink-sql-kafka  
(ccloud.`FLINK_COMPUTE_POOL` in playground.ini), else the first provisioned pool of the environment in the region  
of the cluster

#### `FLINK_API_KEY`

🔑 Confluent Cloud: Flink API key used to read the results of the queries (with `FLINK_API_SECRET`). Default: a key  
created once for the environment and region, kept in the playground secrets store (playground secrets)

#### `FLINK_API_SECRET`

🔐 Confluent Cloud: secret of `FLINK_API_KEY`

## Flink commands

- [cancel](playground%20flink%20cancel) - 🛑 Cancel a Flink job
- [list-jobs](playground%20flink%20list-jobs) - 📋 List the jobs of the Flink cluster
- [sql](playground%20flink%20sql) - 🐿️ Run Flink SQL statements with the SQL client
- [table-ddl](playground%20flink%20table-ddl) - 🧱 Print the Flink SQL CREATE TABLE of a Kafka topic, its columns read from the Avro value schema in Schema Registry
- [ui](playground%20flink%20ui) - 🌐 Open the Flink UI of the local Flink cluster in the browser


