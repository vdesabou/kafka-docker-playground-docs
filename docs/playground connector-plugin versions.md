# playground connector-plugin versions

💯 List versions for a connector plugin from confluent hub https://www.confluent.io/hub/  
  
What to feed to --connector-tag when you want to test another version,  
and the way to find out which release you are behind on. The list is  
cached; use --force-refresh after a brand new release.

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


