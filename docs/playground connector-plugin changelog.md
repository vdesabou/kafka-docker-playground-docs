# playground connector-plugin changelog

📜 Show the release notes of a connector plugin between two versions

Reads the changelog feeds of docs.confluent.io (one per minor line, for  
example https://docs.confluent.io/kafka-connectors/s3-sink/12.1/changelog.xml)  
and lists every change after `--from`, up to `--to`, newest first, with the  
release date from Confluent Hub.

It answers "the customer runs 10.5.7: is their bug fixed in a later  
version, and in which one?" in one call: pass the customer version as  
`--from` and the symptom as `--grep`. The CC-xxxxx ids are the Jira tickets  
of the fixes.

Without `--from`, only the minor line of `--to` is shown (for example every  
12.1.x up to 12.1.15).

Only Confluent self-managed plugins documented under  
docs.confluent.io/kafka-connectors have a feed. Fully managed connectors  
and partner plugins don't. Answers are cached for one day in  
/tmp/connector-plugin-changelog (`--force-refresh`).

🎓 Tip: then read the code of the fix with playground connector-plugin sourcecode `--checkout-only`

## Usage

```bash
playground connector-plugin changelog [OPTIONS]
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

🔢 Version in use: show the changes of the versions after it (excluded)

#### `--to TO`

🔢 Show the changes up to this version (included)

Default is the latest version on Confluent Hub

#### `--grep GREP`

🔎 Only show the changes matching this regular expression (case insensitive)

Example: `--grep` "CVE|offset|NullPointerException"

#### `--json`

🤖 Print the result as JSON

#### `--force-refresh`

☢️ Force refresh.

## Examples

```bash
playground connector-plugin changelog --connector-plugin confluentinc/kafka-connect-s3 --from 12.0.10
playground connector-plugin changelog --connector-plugin confluentinc/kafka-connect-jdbc --from 10.7.4 --grep "timestamp|CVE"
playground connector-plugin changelog --connector-plugin confluentinc/kafka-connect-http --to 1.7.10
playground connector-plugin changelog --connector-plugin confluentinc/kafka-connect-oracle-cdc --from 2.14.0 --json

```


