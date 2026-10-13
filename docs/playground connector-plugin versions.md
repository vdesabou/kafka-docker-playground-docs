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

## Example output

```text
$ playground connector-plugin versions --connector-plugin confluentinc/kafka-connect-http --last 3
17:23:19 ℹ️ 💯 Listing last 3 versions for connector plugin confluentinc/kafka-connect-http
🔢 v1.7.12 - 📅 release date: 2026-01-29 (256 days ago)
🔢 v1.7.13 - 📅 release date: 2026-05-05 (160 days ago)
🔢 v1.7.14 - 📅 release date: 2026-10-01 (11 days ago)
🌐 documentation: https://docs.confluent.io/kafka-connect-http/current/index.html
```


