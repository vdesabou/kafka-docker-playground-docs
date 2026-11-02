# playground cleanup-cloud-resources

🧹 Cleanup cloud resources that were created by running examples from the playground

❗it will remove all resources created by the playground, including topics, connectors, clusters, buckets, redshift cluster, etc...

Examples that talk to a real cloud create real, billable resources, and an  
interrupted run leaves them behind. This sweeps them, scoped to the ones  
whose name contains pg and your username (as is, or lowercased without

- . _ like the examples write it), across AWS, GCP and Azure. Restrict the

scope with `--resource`, and run it regularly.

Salesforce: the accounts of the playground are dedicated test orgs, every  
Lead, Contact and PushTopic of them is deleted.

Confluent Cloud: connectors whose name contains your username are deleted,  
with their dlq, success and error topics. All topics of the cluster are  
deleted only when the cluster was created by the playground for you  
(pg-`<user>`-\*). On a cluster you provided with `CLUSTER_NAME`, which may be  
shared with your team, only the topics recorded as created by your own  
runs are deleted (local file playground-ccloud-created-topics): topics  
created with playground topic create / produce, and topics your fully  
managed source connectors write to, as set in their config (kafka.topic,  
api1.topics, topic.prefix...).

In CI, the service accounts created by the playground (pg-`<user>`-\*) and the  
subjects of the deleted topics (`<topic>`-key, `<topic>`-value) are deleted too.

You are asked to confirm every deletion, unless `--force` is given.

☢️ Deletions are permanent. Use a dedicated cloud account for the  
playground rather than one that also hosts resources you care about.

## Usage

```bash
playground cleanup-cloud-resources [OPTIONS]
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


