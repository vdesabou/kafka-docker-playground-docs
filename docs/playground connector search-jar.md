# playground connector search-jar

🔌 Connector plugin from confluent hub https://www.confluent.io/hub/

## Usage

```bash
playground connector search-jar [OPTIONS]
```

## Examples

```bash
playground connector search-jar --connector-plugin confluentinc/kafka-connect-s3 --class WebIdentityTokenCredentialsProvider

```

## Options

#### *--connector-plugin, -c CONNECTOR-PLUGIN*

🔌 Connector plugin name  
  
🎓 Tip: use \<tab\> completion to trigger fzf completion

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--connector-tag CONNECTOR_TAG*

🔗 Connector version to use  
  
By default, for each connector, the latest available version on Confluent Hub is used

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | latest

#### *--class CLASS*

☕ Java class name to search for in all jars


