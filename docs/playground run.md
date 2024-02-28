# playground run

🕹️ Run any example !  
  
🔥 It start an interactive mode where you'll be fully guided !  
  
  
⛅ When running Confluent Cloud (ccloud) example:  
  
  All you have to do is to be already logged in with confluent CLI.  
  
  By default, a new Confluent Cloud environment with a Cluster will be created.  
  
  You can configure the new cluster by setting:  
  
  --cluster-type (or CLUSTER_TYPE environment variable): The type of cluster (possible values: basic, standard and dedicated, default basic)  
  --cluster-cloud (or CLUSTER_CLOUD environment variable): The Cloud provider (possible values: aws, gcp and azure, default aws)  
  --cluster-region (or CLUSTER_REGION environment variable): The Cloud region (use confluent kafka region list to get the list, default eu-west-2 for aws, westeurope for azure and europe-west2 for gcp)  
  --cluster-environment (or ENVIRONMENT environment variable) (optional): The environment id where want your new cluster (example: txxxxx)   
  
  In case you want to use your own existing cluster, you need to setup, in addition to previous ones:  
  
  --cluster-name (or CLUSTER_NAME environment variable): The cluster name  
  --cluster-creds (or CLUSTER_CREDS environment variable): The Kafka api key and secret to use, it should be separated with colon (example: \<API_KEY\>:\<API_KEY_SECRET\>)  
  --cluster-schema-registry-creds (or SCHEMA_REGISTRY_CREDS environment variable) (optional, if not set, new one will be created): The Schema Registry api key and secret to use, it should be separated with colon (example: \<SR_API_KEY\>:\<SR_API_KEY_SECRET\>)

## Usage

```bash
playground run [OPTIONS]
```

## Dependencies

#### *fzf*

visit https://github.com/junegunn/fzf#installation to install

## Options

## Examples

```bash
playground run (interactive mode)
```


