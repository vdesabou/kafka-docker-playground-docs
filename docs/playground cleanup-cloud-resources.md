# playground cleanup-cloud-resources

🧹 Cleanup cloud resources that were created by running examples from the playground  
  
❗it will remove all resources created by the playground, including topics, connectors, clusters, buckets, redshift cluster, etc...  
  
Examples that talk to a real cloud create real, billable resources, and an  
interrupted run leaves them behind. This sweeps them, scoped to the ones  
whose name contains your username, across AWS, GCP, Azure, Confluent Cloud  
and Salesforce. Restrict the scope with --resource, and run it regularly.  
  
You are asked to confirm every deletion, unless --force is given.  
  
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

#### *AZ_USER*

Azure user

#### *GCP_PROJECT*

GCP project

#### *AWS_ACCESS_KEY_ID*

AWS access key id

#### *AWS_SECRET_ACCESS_KEY*

AWS secret access key

#### *GCP_KEYFILE_CONTENT*

GCP keyfile (generated with "cat keyfile.json | jq -aRs .")

## Options

#### *--force*

☢️ do not ask for confirmation  
  
❗use with caution

#### *--resource RESOURCE*

🛁 resource to cleanup  
  
If not provided, all of them are cleaned up  
  
🎓 Tip: you can pass multiple resources by specifying --resource multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | ["aws", "gcp", "azure", "ccloud", "salesforce"]
| Allowed Values: | aws, gcp, azure, ccloud, salesforce


