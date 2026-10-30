# playground connector-plugin versions

💯 List versions for a connector plugin from confluent hub https://www.confluent.io/hub/

What to feed to `--connector-tag` when you want to test another version,  
and the way to find out which release you are behind on (`--from`).

The answer of Confluent Hub is cached for one day in  
/tmp/version_`<owner>`_`<name>`.json and the age of each version is  
computed on every call; use `--force-refresh` right after a release.

## Usage

```bash
playground connector-plugin versions [OPTIONS]
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

#### `--force-refresh`

☢️ Force refresh.

#### `--last LAST`

🆕 Number of last versions to show

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--latest`

#### `--from FROM`

📌 Version in use: show how many versions it is behind, and only the newer ones

Combine with `--with-changelog` to read what changed since, or use playground connector-plugin changelog `--from`.

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--latest`

#### `--latest`

🔝 Only print the latest version number, nothing else

🎓 Tip: use it in scripts and from AI agents, the output is just the version (for example 10.9.9)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--last`, `--from`, `--with-changelog`, `--json`

#### `--with-changelog`

📜 Show the release notes of each version under it

From the changelog feeds of docs.confluent.io, like playground connector-plugin changelog: Confluent self-managed plugins only.

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--latest`

#### `--json`

🤖 Print the result as JSON

latest, versions (version, release_date, days_ago, and changes with `--with-changelog`), documentation_url, versions_behind with `--from`.

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--latest`

## Examples

```bash
playground connector-plugin versions --connector-plugin confluentinc/kafka-connect-s3
playground connector-plugin versions --connector-plugin confluentinc/kafka-connect-jdbc --last 3 --with-changelog
playground connector-plugin versions --connector-plugin confluentinc/kafka-connect-jdbc --from 10.7.4
playground connector-plugin versions --connector-plugin confluentinc/kafka-connect-jdbc --latest
playground connector-plugin versions --connector-plugin confluentinc/kafka-connect-jdbc --last 3 --json

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


