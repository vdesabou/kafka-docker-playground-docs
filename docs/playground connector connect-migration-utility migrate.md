# playground connector connect-migration-utility migrate

🪄 Migrate discovered connectors to fully managed connectors  
  
  see https://github.com/confluentinc/connect-migration-utility/tree/master?tab=readme-ov-file#step-2-migrate-the-connector  
  ⚠️ \<discovery\> command should be run first  


## Usage

```bash
playground connector connect-migration-utility migrate [OPTIONS]
```

## Options

#### *--migration-mode MIGRATION-MODE*

- create: Create connector without any offset consideration  
- stop_create_latest_offset: Create a connector with no data loss/duplication (the python script stops the self-managed connector and fetches the latest offset and creates a fully-managed connector on Confluent Cloud using the fetched offset). See https://github.com/confluentinc/connect-migration-utility/tree/master?tab=readme-ov-file#create-a-connector-with-no-data-lossduplication.  
- create_latest_offset: Create a connector with no downtime (the python script fetches the latest offset without stopping the connector and creates a fully-managed connector on Confluent Cloud using the fetched offset. This option may cause data duplication as the self-managed connector is still running). See https://github.com/confluentinc/connect-migration-utility/tree/master?tab=readme-ov-file#create-a-connector-with-no-downtime.

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | create
| Allowed Values: | stop_create_latest_offset, create, create_latest_offset


