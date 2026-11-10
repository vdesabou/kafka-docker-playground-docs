# playground cloud-resources ccloud list

📋 List what the playground left running for you in Confluent Cloud, across the whole organization

Read-only. Walks every environment and Kafka cluster of the  
organization your confluent CLI is logged into (in parallel), which  
matters in an org shared by a whole team, and shows:

🤖 connectors named \*_`<user>`, with their status, type, cluster and  
age (from the local run records, ? when created elsewhere)  
🌐 environments and 🎰 clusters named pg-`<user>`-\*  
🤖 service accounts named pg-`<user>`-\*, and 🔑 the API keys they own,  
plus the Schema Registry keys created for you when  
`SCHEMA_REGISTRY_CREDS` is not set  
📝 topics recorded by your runs (playground-ccloud-created-topics),  
and whether they still exist

A running connector is what costs the most (billed per task-hour),  
then a cluster: those are summed up at the end. The 🧹 column tells  
what `playground cloud-resources cleanup --resource ccloud` deletes:  
it scans the same way, and never deletes a service account or an API  
key in use on this machine (\*_CLUSTER_CREDS, `SCHEMA_REGISTRY_CREDS`,  
exported or in the secrets store, playground.ini, .ccloud/).

🎓 Tip: in a shared org, run it before leaving for the day.

## Usage

```bash
playground cloud-resources ccloud list [OPTIONS]
```

## Dependencies

#### *confluent*

visit https://docs.confluent.io/confluent-cli/current/overview.html to install

## Options

#### `--json`

📗 Print everything as one JSON object, and nothing else

Keys: user, scanned (number of environments and clusters),  
connectors, environments, clusters, service_accounts, api_keys and  
recorded_topics.

## Examples

```bash
playground cloud-resources ccloud list
```

```bash
playground cloud-resources ccloud list --json | jq '.connectors[] | select(.status == "RUNNING")'
```


