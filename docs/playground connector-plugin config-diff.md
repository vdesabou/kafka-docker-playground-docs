# playground connector-plugin config-diff

🔧 Configuration keys added, removed or changed between two versions of a plugin

"What changes in the configuration when the customer upgrades from 10.7.4  
to the latest?": keys added ➕, removed ➖, default changed ✏️, type,  
importance, valid values or required changed 🔀 (📝 documentation with  
`--with-docs`), for every connector class of the plugin.

With `--file` (the customer's connector config: JSON, CFK, Strimzi,  
terraform, properties), only the keys it sets are compared, and a key it  
sets that the new version doesn't know is flagged ❗.

No environment needed: each version is downloaded (same cache as  
search-jar), and its configuration read by loading the connector class  
with the java of the connect image (a small reader compiled once in a JDK  
container). The result is also kept in .connector_config, like  
playground connector show-config-parameters: connector-plugin config-key  
then lists those versions under "versions run locally".

## Usage

```bash
playground connector-plugin config-diff [OPTIONS]
```

## Dependencies

#### *python3*

visit https://www.python.org/downloads/ to install

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

🔢 Version in use (the customer's)

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--to TO`

🔢 Version to compare with, default is the latest on Confluent Hub

#### `--connector-class CONNECTOR-CLASS`

🔌 Only this connector class (default: every connector of the plugin, or the connector.class of `--file`)

#### `--file FILE`

📄 Connector configuration of the customer: only the keys it sets are compared

JSON ({"name":…, "config":{…}} or the bare config), or a CFK / Strimzi / terraform / properties file.

#### `--with-docs`

📝 Also report the keys whose documentation changed

#### `--json`

🤖 Print the result as JSON

## Examples

```bash
playground connector-plugin config-diff --connector-plugin confluentinc/kafka-connect-jdbc --from 10.7.4
playground connector-plugin config-diff --connector-plugin confluentinc/kafka-connect-jdbc --from 10.7.4 --to 10.9.9 --connector-class io.confluent.connect.jdbc.JdbcSinkConnector
playground connector-plugin config-diff --connector-plugin confluentinc/kafka-connect-s3 --from 10.5.0 --file /path/to/customer-connector.json

```


