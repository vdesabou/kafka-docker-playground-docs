# playground ccloud setup

🏗️ Create (or complete) your personal environment and clusters, and store them in a secrets profile

For an organization shared by a team, or your own: rather than a cluster  
created on every run, or a team cluster where everybody's topics collide,  
you get, in the organization your confluent CLI is logged into:

🌐 an environment pg-`<user>` (Stream Governance essentials)  
🎰 one Basic cluster pg-`<user>`-`<cloud>` per `--cloud` (aws, gcp, azure)  
🔑 one Kafka API key per cluster and one Schema Registry API key, owned  
by you (no service account)

and the secrets profile (`--profile`, default: the active one) gets  
ENVIRONMENT, `SCHEMA_REGISTRY_CREDS`, AWS_ / GCP_ / `AZURE_CLUSTER_NAME`,  
_CLOUD, _REGION, _CREDS, and CLUSTER_\* for `--default-cloud`: what  
`playground run` loads for the fully managed examples (fm-aws-\* on the  
AWS cluster, fm-gcp-\* on the GCP one, fm-azure-\* on the Azure one, the  
others on `--default-cloud`).

Run it again any time: what exists is reused (same names), API keys  
already stored in the profile are kept when they still belong to the  
cluster, and only what is missing is created. `--dry-run` shows the plan.

Names matter for the cleanup: 'cloud-resources cleanup `--resource` ccloud'  
deletes all the topics of clusters named pg-`<user>`-\* (yours), never the  
clusters, and never the environment pg-`<user>` nor the keys stored here.

🎓 Tip: one profile per organization (`--profile` emea, `--profile` personal),  
then `playground secrets profile <name>` to switch, and 'confluent login  
`--organization` `<id>` `--save`' for the confluent CLI.

## Usage

```bash
playground ccloud setup [OPTIONS]
```

## Dependencies

#### *confluent*

visit https://docs.confluent.io/confluent-cli/current/overview.html to install

## Options

#### `--cloud CLOUD`

🌤️ Cloud provider of a cluster to create (repeat it for several)

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | `aws`, `gcp`, `azure`
| Allowed Values: | `aws`, `gcp`, `azure`

#### `--aws-region REGION`

🗺️ Region of the AWS cluster (default: `AWS_REGION`, else eu-west-2)

Examples that need a given region stop when the cluster is elsewhere:  
keep `AWS_REGION` equal to it.

#### `--gcp-region REGION`

🗺️ Region of the GCP cluster (default: europe-west2)

#### `--azure-region REGION`

🗺️ Region of the Azure cluster (default: `AZURE_REGION`, else westeurope)

#### `--default-cloud CLOUD`

🎯 Cluster used by the examples that need no specific cloud (CLUSTER_\*), default: the first `--cloud`

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `aws`, `gcp`, `azure`

#### `--environment-name NAME`

🌐 Name of the environment (default: pg-`<user>`)

#### `--profile PROFILE`

🗂️ Secrets profile to write (default: the active one)

#### `--dry-run`

🔎 Show what would be created and stored, without creating nor storing anything

## Examples

```bash
playground ccloud setup --dry-run
```

```bash
playground ccloud setup --profile emea --cloud aws --cloud azure
```

```bash
playground ccloud setup --cloud gcp --gcp-region europe-west1 --default-cloud gcp
```


