# playground ccloud-changelog

📰 Search the Confluent Cloud release notes by date, connector, category or text

Reads the release notes feed of docs.confluent.io  
(https://docs.confluent.io/cloud/current/release-notes.xml, the whole  
history since 2019) and lists one line per change, grouped by day, newest  
first, with the link to the release notes of the day.

It answers "the fully managed connector started behaving differently on  
November 6: did Confluent ship something around that day?" (`--around`) or  
"since when does the Azure Blob Storage Sink support this option?"  
(`--connector`) in one call, with a public page to quote to the customer.

`--connector` matches the changes that link the Confluent Cloud page of the  
connector, not a fuzzy name: give the connector class (AzureBlobSink,  
resolved through the README of its ccloud/fm-\* example), the example  
folder (fm-azure-blob-storage-sink) or the page (cc-azure-blob-sink).  
Anything else is searched in the text.

Without a date, `--connector` or `--grep`, the last 30 days are shown. With  
`--connector` or `--grep`, the whole history is searched.

⚠️ The release notes are dated, not versioned: to know which connector  
version a cc-connect image ships, use 'playground connector-plugin  
fm-versions'. Categories are derived from keywords and links. The feed is  
cached for one day in /tmp/ccloud-changelog (`--force-refresh`).

🎓 Tip: for Confluent Platform, use `playground cp-changelog`

## Usage

```bash
playground ccloud-changelog [OPTIONS]
```

## Options

#### `--since SINCE`

📅 First day to show (included), YYYY-MM-DD

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--around`

#### `--until UNTIL`

📅 Last day to show (included), YYYY-MM-DD

Default is today

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--around`

#### `--around AROUND`

🎯 Day of interest (the day a customer saw the problem), YYYY-MM-DD: show the changes of the `--days` before and after it

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--since`, `--until`

#### `--days DAYS`

🔢 With `--around`: number of days before and after it (default 7)

Alone (or with `--until`): the last N days

#### `--connector, -c CONNECTOR`

🔌 Only show the changes of this fully managed connector (can be repeated)

A connector class (AzureBlobSink, confluentinc/AzureBlobSink), a ccloud/fm-\* example folder (fm-azure-blob-storage-sink),  
a Confluent Cloud page (cc-azure-blob-sink or its URL), or else any text

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--category CATEGORY`

🏷️ Only show the changes of this category (can be repeated)

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Allowed Values: | `connectors`, `flink`, `schema-registry`, `tableflow`, `ksqldb`, `networking`, `security`, `cli`, `terraform`, `cluster-linking`, `other`

#### `--grep GREP`

🔎 Only show the changes matching this regular expression (case insensitive)

Example: `--grep` "partitioner|`BACKUP_FULL_RECORD`"

#### `--json`

🤖 Print the result as JSON

#### `--force-refresh`

☢️ Force refresh.

## Examples

```bash
playground ccloud-changelog
playground ccloud-changelog --around 2026-11-06 --category connectors
playground ccloud-changelog --connector AzureBlobSink
playground ccloud-changelog --connector fm-salesforce-cdc-source --since 2026-01-01
playground ccloud-changelog --category flink --days 90 --grep "snapshot|query"
playground ccloud-changelog --connector SnowflakeSink --json

```


