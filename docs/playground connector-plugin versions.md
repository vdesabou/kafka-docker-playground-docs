# playground connector-plugin versions

💯 List versions for a connector plugin from confluent hub https://www.confluent.io/hub/

## Usage

```bash
playground connector-plugin versions [OPTIONS]
```

## Options

#### *--connector-plugin, -c CONNECTOR-PLUGIN*

🔌 Connector plugin name  
  
🎓 Tip: use \<tab\> completion to trigger fzf completion

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--force-refresh*

☢️ Force refresh.

#### *--last LAST*

🆕 Number of last versions to show

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--all*

## Examples

```bash
playground connector-plugin versions --connector-plugin confluentinc/kafka-connect-s3

```


