# playground cloud-resources cleanup

🧹 Cleanup cloud resources that were created by running examples from the playground

❗it will remove all resources created by the playground, including topics, connectors, clusters, buckets, redshift cluster, etc...

Examples that talk to a real cloud create real, billable resources, and an  
interrupted run leaves them behind. This sweeps them, scoped to the ones  
whose name contains pg and your username (as is, or lowercased without

- . _ like the examples write it), across AWS, GCP and Azure. Restrict the

scope with `--resource`, and run it regularly.

Salesforce: the accounts of the playground are dedicated test orgs, every  
Lead, Contact and PushTopic of them is deleted.

Confluent Cloud: every environment and cluster of the organization your  
confluent CLI is logged into is scanned, like 'playground cloud-resources  
ccloud list' (no cluster needed, none is ever created):

- connectors named \*_`<user>`, on any cluster, with their dlq, success

and error topics

- environments pg-`<user>`-sa-\* (the stacks the playground created), with

their clusters

- all topics of your other clusters named pg-`<user>`-\* (the cluster is

kept)

- on any other cluster, which may be shared with your team, only the

topics recorded as created by your own runs (local file  
playground-ccloud-created-topics): topics created with playground  
topic create / produce, and topics your fully managed source  
connectors write to, as set in their config (kafka.topic,  
api1.topics, topic.prefix...)

- service accounts pg-`<user>`-conn-\* (`--ccloud-service-account`), and

pg-`<user>`-app-\* with their API keys, plus the Schema Registry keys  
created for you, unless one of these keys is used on this machine  
(\*_CLUSTER_CREDS, `SCHEMA_REGISTRY_CREDS`, exported or in the secrets  
store, playground.ini, .ccloud/)

In CI, the clusters of `CLUSTER_NAME` and AWS_ / GCP_ / AZURE_ /  
`AWS_DATABRICKS_CLUSTER_NAME` are cleaned up one by one instead, and the  
service accounts created by the playground (pg-`<user>`-\*) and the subjects  
of the deleted topics (`<topic>`-key, `<topic>`-value) are deleted too.

You are asked to confirm every deletion, unless `--force` is given. Use  
`--dry-run` first to see what would be deleted.

☢️ Deletions are permanent. Use a dedicated cloud account for the  
playground rather than one that also hosts resources you care about.

## Usage

```bash
playground cloud-resources cleanup [OPTIONS]
```

## Dependencies

#### *confluent*

visit https://docs.confluent.io/confluent-cli/current/overview.html to install

## Environment Variables

#### `AZ_USER`

Azure user

#### `GCP_PROJECT`

GCP project

#### `AWS_ACCESS_KEY_ID`

AWS access key id

#### `AWS_SECRET_ACCESS_KEY`

AWS secret access key

#### `GCP_KEYFILE_CONTENT`

GCP keyfile (generated with "cat keyfile.json | jq -aRs .")

## Options

#### `--force`

☢️ do not ask for confirmation

❗use with caution

#### `--resource RESOURCE`

🛁 resource to cleanup

If not provided, all of them are cleaned up

🎓 Tip: you can pass multiple resources by specifying `--resource` multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | `aws`, `gcp`, `azure`, `ccloud`, `salesforce`
| Allowed Values: | `aws`, `gcp`, `azure`, `ccloud`, `salesforce`

#### `--dry-run`

🔎 List what would be deleted (the commands), without deleting anything nor asking

In CI, the Confluent Cloud part is skipped when no cluster is known (`CLUSTER_NAME`, or a previous ccloud run):  
finding one would create it.

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--recorded-topics-only`

## Examples

```bash
playground cloud-resources cleanup --dry-run
```

```bash
playground cloud-resources cleanup --resource aws --dry-run
```

```bash
playground cloud-resources cleanup --resource aws --resource gcp
```


