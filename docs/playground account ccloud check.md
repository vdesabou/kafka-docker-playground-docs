# playground account ccloud check

🩺 Check the environment, clusters and API keys of the fully managed examples

Reads the variables like `playground run` does (exported in your shell  
first, else the secrets profile) and checks, in the organization your  
confluent CLI is logged into:

🌐 ENVIRONMENT exists  
🎰 each `CLUSTER_NAME`, AWS_ / GCP_ / AZURE_ / `AWS_DATABRICKS_CLUSTER_NAME`  
that is set: the cluster exists in the environment, is UP, is on  
the right cloud, matches _CLOUD and _REGION  
🔑 each _CLUSTER_CREDS: the key exists, belongs to that cluster, and  
lists the topics (REST API)  
🔑 `SCHEMA_REGISTRY_CREDS`: the key belongs to the Schema Registry of the  
environment and lists the subjects; warns near the free schemas limit  
🗺️ `AWS_REGION` / `AZURE_REGION` versus the region of the cluster  
⚠️ exported variables that hide the profile

Each failure says which examples it breaks and the 'setup' command that  
fixes it. Read-only: nothing is created nor stored.

Exits with 1 when a check fails (or the confluent CLI is not logged in).

## Usage

```bash
playground account ccloud check [OPTIONS]
```

## Dependencies

#### *confluent*

visit https://docs.confluent.io/confluent-cli/current/overview.html to install

## Options

#### `--profile PROFILE`

🗂️ Secrets profile to check (default: the active one)

## Examples

```bash
playground account ccloud check
```

```bash
playground account ccloud check --profile emea
```


