# playground cleanup-cloud-resources

🧹 Cleanup cloud resources that were created by running examples from the playground  
  
❗it will remove all resources created by the playground, including topics, connectors, clusters, buckets, redshift cluster, etc...

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

#### *AZ_PASS*

Azure password

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


