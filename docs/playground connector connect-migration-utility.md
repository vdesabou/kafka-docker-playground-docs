# playground connector connect-migration-utility

🧩 Run Kafka Connector Migration Utility (see https://github.com/confluentinc/connect-migration-utility/) on running connect cluster  
  
Takes a self managed connector running in the connect container and  
recreates it as a fully managed connector in Confluent Cloud, keeping  
its offsets so consumers do not replay or skip data. Two steps:  
  
  discovery   read the local connectors and export their configurations  
  migrate     create the equivalent connectors on Confluent Cloud  
  
Run discovery first, migrate second. Use it to rehearse a customer's  
migration and see what their configuration turns into.  
  
The connector example should be ran with --environment flag set to ccloud.  
  
See a full example at https://github.com/vdesabou/kafka-docker-playground/blob/master/ccloud/connect-migration-utility/README.md  


## Usage

```bash
playground connector connect-migration-utility COMMAND
```

## Dependencies

#### *confluent*

visit https://docs.confluent.io/confluent-cli/current/overview.html to install

## == Commands ==

- [discovery](playground%20connector%20connect-migration-utility%20discovery) - 👨‍🔬 Discover connectors in the local connect cluster and export their configurations to files
- [migrate](playground%20connector%20connect-migration-utility%20migrate) - 🪄 Migrate discovered connectors to fully managed connectors


