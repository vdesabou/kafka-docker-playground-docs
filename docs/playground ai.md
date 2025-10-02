# playground ai

🧞‍♂️  AI  
  
It is using Gemini CI (https://google-gemini.github.io/gemini-cli/) in interactive mode.  
  
MCP servers are available:  
  
1. mcp-playground-cli -   
  
  Tools:  
  - playground_command_help:  
      Get detailed help for playground commands  
  - playground_command_suggest:  
      Get command suggestions and completions for the Kafka Docker Playground CLI  
  - playground_command_validate:  
      Validate a complete playground command and suggest corrections  
  
2. mcp-kafka - Kafka MCP Server (https://docs.tuannvm.com/kafka-mcp-server)  
  
  Tools:  
  - cluster_overview:  
      Aggregates high-level cluster health data, such as controller, broker/topic/partition counts, and under-replicated/offline partitions.  
  - consume_messages:  
      Consume a batch of messages from Kafka topics.  
  - describe_configs:  
      Fetches configuration entries for a specific resource (topic or broker).  
  - describe_consumer_group:  
      Shows details for a specific consumer group, including state, members, and optionally partition offsets and lag.  
  - describe_topic:  
      Provides detailed metadata for a specific Kafka topic, including partition leaders, replicas, and ISRs.  
  - list_brokers:  
      Lists the configured Kafka broker addresses.  
  - list_consumer_groups:  
      Enumerates active consumer groups known by the Kafka cluster.  
  - list_topics:  
      Retrieves all topic names along with partition counts and replication factors.  
  - produce_message:  
      Produce a message to a Kafka topic  
  
  Prompts:  
  - kafka_cluster_overview:  
      Provides a summary of Kafka cluster health and metrics  
  - kafka_consumer_lag_report:  
      Provide a detailed report on consumer lag across all consumer groups  
  - kafka_health_check:  
      Run a comprehensive health check on the Kafka cluster  
  - kafka_under_replicated_partitions:  
      List topics and partitions where ISR count is less than replication factor  
  
3. mcp-ccloud - Confluent Cloud MCP Server (https://github.com/confluentinc/mcp-confluent)  
  
  Tools:  
  - add-tags-to-topic:  
      Assign existing tags to Kafka topics in Confluent Cloud.  
  - alter-topic-config:  
      Alter topic configuration in Confluent Cloud.  
  - create-connector:  
      Create a new connector. Returns the new connector information if successful.  
  - create-topic-tags:  
      Create new tag definitions in Confluent Cloud.  
  - create-topics:  
      Create one or more Kafka topics.  
  - delete-connector:  
      Delete an existing connector. Returns success message if deletion was successful.  
  - delete-tag:  
      Delete a tag definition from Confluent Cloud.  
  - delete-topics:  
      Delete the topic with the given names.  
  - get-topic-config:  
      Retrieve configuration details for a specific Kafka topic.  
  - list-clusters:  
      Get all clusters in the Confluent Cloud environment  
  - list-connectors:  
      Retrieve a list of "names" of the active connectors. You can then make a read request for a specific connector by name.  
  - list-environments:  
      Get all environments in Confluent Cloud with pagination support  
  - list-schemas:  
      List all schemas in the Schema Registry.  
  - list-tags:  
      Retrieve all tags with definitions from Confluent Cloud Schema Registry.  
  - list-topics:  
      List all topics in the Kafka cluster.  
  - read-connector:  
      Get information about the connector.  
  - read-environment:  
      Get details of a specific environment by ID  
  - remove-tag-from-entity:  
      Remove tag from an entity in Confluent Cloud.  
  - search-topics-by-name:  
      List all topics in the Kafka cluster matching the specified name.  
  - search-topics-by-tag:  
      List all topics in the Kafka cluster with the specified tag.

## Usage

```bash
playground ai [--] [GEMINI CLI ARGUMENTS...]
```

## Dependencies

#### *gemini*

visit https://github.com/google-gemini/gemini-cli/tree/main?tab=readme-ov-file#-installation to install

#### *kafka-mcp-server*

visit https://docs.tuannvm.com/kafka-mcp-server#installation to install

## Examples

```bash
playground ai --model gemini-1.5-pro-latest --output-format json
```


