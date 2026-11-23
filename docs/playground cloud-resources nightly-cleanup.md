# playground cloud-resources nightly-cleanup

🌙 Delete what your examples left running in Confluent Cloud (and AWS, GCP, Azure with `--resource`), every night, automatically

- **enable**: schedule it (default 02:00), then show what tonight's run would delete
- **disable**: remove the schedule
- **status**: is it scheduled, when, and what the last runs did

Every night it runs 'playground cloud-resources cleanup `--resource` ccloud  
`--force`', limited to what costs money or clutters a shared cluster:

🤖 connectors named \*_`<user>`, on any cluster of the organization, with  
their dlq, success and error topics  
🌐 environments pg-`<user>`-sa-\* (the stacks the playground created when  
no `CLUSTER_NAME` was set), with their clusters  
📝 on shared clusters, the topics recorded as created by your own runs

It keeps your own clusters and their topics (playground account ccloud setup),  
and never deletes service accounts or API keys: the secrets store may be  
locked at night, so the keys in use can't be told apart. Run  
`playground cloud-resources cleanup --resource ccloud` yourself for those.

☁️ 'enable `--resource` aws `--resource` gcp `--resource` azure' adds what  
`playground cloud-resources cleanup` deletes in those clouds (Kinesis  
streams, SQS queues, Redshift clusters, DynamoDB tables, Azure resource  
groups, GCS buckets, BigQuery datasets, Spanner and Bigtable instances…,  
named pg…`<user>`…). Nothing interactive at night: a cloud whose  
credentials can't be read without a prompt is skipped, with a  
notification, and the others still run:  
aws      ~/.aws/credentials, or `AWS_ACCESS_KEY_ID` and  
`AWS_SECRET_ACCESS_KEY` in the secrets store  
azure    `AZ_CLIENT_ID`, `AZ_CLIENT_SECRET` and `AZ_TENANT_ID` (service  
principal) in the secrets store, or a saved 'az login'  
session; `AZURE_SUBSCRIPTION_NAME` for a confluent.io account  
gcp      `GCP_PROJECT` and `GCP_KEYFILE_CONTENT` in the secrets store, and  
Docker running  
The secrets store is read at night unless it is 1Password without a  
service account token (it would wait for Touch ID).  
⚠️ Like the connectors in Confluent Cloud, the resources of an example  
still running at that time are deleted too: pick a time you don't use.

macOS: a launchd agent (~/Library/LaunchAgents), which also runs when the  
Mac wakes up if it was asleep at that time. Linux: a crontab line. The  
`confluent CLI must stay logged in: 'confluent login --save'.`

🏗️ Works best with your own clusters, set up once: 'playground ccloud  
setup'. `playground cloud-resources ccloud list` shows what is left.

## Usage

```bash
playground cloud-resources nightly-cleanup COMMAND
```

## Commands

- [disable](playground%20cloud-resources%20nightly-cleanup%20disable) - 🛑 Remove the nightly cleanup schedule
- [enable](playground%20cloud-resources%20nightly-cleanup%20enable) - 🌙 Schedule the nightly cleanup, then show what tonight's run would delete
- [status](playground%20cloud-resources%20nightly-cleanup%20status) - 🔎 Is the nightly cleanup scheduled, at what time, and what did its last runs do


