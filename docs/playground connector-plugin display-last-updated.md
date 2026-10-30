# playground connector-plugin display-last-updated

🆕 List last updated connector plugins from confluent hub https://www.confluent.io/hub/

A quick way to see what has just been released on the Hub, which often  
explains why an example that passed yesterday behaves differently today.

One request to the Confluent Hub API lists every plugin with its latest  
version, newest first. A plugin released twice in the period shows its  
latest version only.

## Usage

```bash
playground connector-plugin display-last-updated [OPTIONS]
```

## Options

#### `--days DAYS`

📅 Number of days to look back

Default is 3 days

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `3`

#### `--vendor VENDOR`

🏢 Only display results for this vendor

A regular expression matched against owner/name, for example confluentinc or debezium

#### `--with-changelog`

📜 Show the release notes of each new version under it

From the changelog feeds of docs.confluent.io, like playground connector-plugin changelog: Confluent self-managed plugins only.

#### `--json`

🤖 Print the result as JSON

connector_plugin, version, release_date, days_ago, documentation_url, and changes with `--with-changelog`.

## Examples

```bash
playground connector-plugin display-last-updated --days 7
playground connector-plugin display-last-updated --days 7 --vendor confluentinc --with-changelog
playground connector-plugin display-last-updated --days 30 --json

```


