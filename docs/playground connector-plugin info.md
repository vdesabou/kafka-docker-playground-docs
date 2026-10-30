# playground connector-plugin info

🪪 One page on a connector plugin of Confluent Hub

What it is and whether the customer is up to date, in one call: owner,  
license, component types, latest version and how many versions since  
when, how far behind `--from` is, the requirements of the manifest when  
the vendor gives them, the examples of this repository using it with  
their CI status, the connector classes, the fully managed examples named  
like it, and the documentation, changelog and source code links.

The fully managed part is a heuristic: the ccloud/fm-\* folders whose name  
has the words of the plugin name (there is no mapping between a  
self-managed plugin and fully managed connector types).

## Usage

```bash
playground connector-plugin info [OPTIONS]
```

## Options

#### `--connector-plugin, -c CONNECTOR-PLUGIN`

🔌 Connector plugin name

owner/name, a connector class (io.confluent.connect.jdbc.JdbcSinkConnector: its plugin is found in the examples)  
or a fully managed type (`S3_SINK`)

🎓 Tip: use `<tab>` completion to trigger fzf completion

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--from FROM`

📌 Version in use: show how many versions it is behind the latest

#### `--max-examples MAX_EXAMPLES`

🧪 Maximum number of examples to list (default 10)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `10`

#### `--json`

🤖 Print the result as JSON

#### `--force-refresh`

☢️ Force refresh.

## Examples

```bash
playground connector-plugin info --connector-plugin confluentinc/kafka-connect-jdbc
playground connector-plugin info --connector-plugin confluentinc/kafka-connect-s3 --from 10.5.0
playground connector-plugin info --connector-plugin debezium/debezium-connector-postgresql --json

```


