# playground ai

🧞‍♂️  AI  
  
It is using Claude Code (https://code.claude.com/docs/en/quickstart) in interactive mode.  
  
MCP servers are available:  
  
1. mcp-playground-cli -   
  
  Tools:  
  - playground_command_help:  
      Get detailed help for playground commands  
  - playground_command_suggest:  
      Get command suggestions and completions for the Kafka Docker Playground CLI  
  - playground_command_validate:  
      Validate a complete playground command and suggest corrections  
  
2. mcp-server - Confluent MCP Server (see http://docs.confluent.io/cloud/current/ai/ai-tools/open-source-mcp-server.html#quick-start and https://github.com/confluentinc/mcp-confluent)  
  
  Tools:  
  - list-topics: List all topics in the Kafka cluster.  
  - create-topics: Create one or more Kafka topics.  
  - delete-topics: Delete topics by name.  
  - produce-message: Produce records to a Kafka topic (supports Schema Registry).  
  - consume-messages: Consume messages from one or more Kafka topics (supports Schema Registry).  
  - list-schemas: List all schemas in the Schema Registry.  
  - delete-schema: Delete a schema subject or a specific version from the Schema Registry.  
  
3. mcp-ccloud - Confluent MCP Server (see http://docs.confluent.io/cloud/current/ai/ai-tools/open-source-mcp-server.html#quick-start and https://github.com/confluentinc/mcp-confluent)  
  
  Tools:  
    Environment & Cluster Management  
    - list-environments: Get all environments in Confluent Cloud.  
    - read-environment: Get details of a specific environment.  
    - list-clusters: Get all clusters in a Confluent Cloud environment.  
  
    Topic Management  
    - list-topics: List all topics in a Kafka cluster.  
    - create-topics: Create one or more Kafka topics.  
    - delete-topics: Delete topics by name.  
    - search-topics-by-name: Search for topics matching a name.  
    - get-topic-config: Retrieve configuration details for a topic.  
    - alter-topic-config: Update topic configuration (SET/DELETE).  
  
    Messaging  
    - produce-message: Produce records to a topic (supports Schema Registry serialization).  
    - consume-messages: Consume and deserialize messages from one or more topics.  
  
    Schema Registry  
    - list-schemas: List schemas (latest or all versions).  
    - delete-schema: Delete a schema subject or specific version.  
    - list-tags: Retrieve all tag definitions.  
    - create-topic-tags: Create new tag definitions.  
    - delete-tag: Delete a tag definition.  
    - add-tags-to-topic: Assign tags to Kafka topics.  
    - remove-tag-from-entity: Remove tags from entities.  
    - search-topics-by-tag: List topics with a specific tag.  
  
    Connector Management  
    - list-connectors: List active connectors in a cluster.  
    - read-connector: Get detailed information about a connector.  
    - create-connector: Create a new Managed or Custom connector.  
    - delete-connector: Delete an existing connector.  
  
    Metrics & Billing  
    - list-available-metrics: Discover valid metric names and filter fields.  
    - query-metrics: Query metrics from the Telemetry API (Kafka, Flink, Connect, SR).  
    - list-billing-costs: Retrieve billing cost data for an organization.

## Usage

```bash
playground ai [--] [GEMINI CLI ARGUMENTS...]
```

## Dependencies

#### *claude*

visit https://code.claude.com/docs/en/quickstart to install

## Examples

```bash
playground ai --model gemini-1.5-pro-latest --output-format json
```


