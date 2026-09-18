# playground ai

🧞‍♂️  AI  
  
Opens Claude Code in this checkout, already wired to the playground.  
  
It is using Claude Code (https://code.claude.com/docs/en/quickstart) in interactive mode.  
  
Because of the MCP servers below, it can see what is actually running:  
which example, which containers, which connectors are failing and why,  
and it can search the ~2500 example scripts to find the one that already  
reproduces what you are looking at. So ask it things like "why did my  
connector fail" or "is there an example doing X", rather than treating it  
as a generic assistant.  
  
Anything you pass after 'playground ai' goes straight to the claude cli.  
  
MCP servers are available:  
  
1. mcp-playground - Playground MCP Server (see https://github.com/vdesabou/kafka-docker-playground-mcp-server), it exposes the live state of this checkout  
  
  Tools:  
  - playground_status:  
      Docker availability, the example currently running (script, environment, connector type),  
      every container with its state/health/ports and the recent `playground run` history.  
  - playground_connectors:  
      Status of every connector, with the root cause of each FAILED task. Talks to the running  
      Connect worker (ssl/rbac included) or to the Confluent Cloud Connect API, whichever the  
      current environment uses.  
  - playground_logs:  
      Container logs without flooding the context: de-duplicated errors with collapsed stack  
      traces (default), tail, or regex search.  
  - playground_find_example:  
      Search the ~2500 runnable example scripts by connector class, path, title or body, and get  
      the exact `playground run -f \<script\>` command back.  
  - playground_example_details:  
      One call for everything about an example: source, connector payloads, default environment,  
      docker-compose overrides, sibling variants and the variables you must export.  
  
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
playground ai [--] [CLAUDE CLI ARGUMENTS...]
```

## Dependencies

#### *claude*

visit https://code.claude.com/docs/en/quickstart to install

## Examples

```bash
playground ai
```

```bash
playground ai --model opus
```


