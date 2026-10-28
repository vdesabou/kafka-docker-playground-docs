# playground cp-changelog

📜 Show what changed in Confluent Platform between two versions

Reads the changelog feeds of docs.confluent.io (one per minor line, for  
example https://docs.confluent.io/platform/8.3/release-notes/changelog.xml)  
and lists the commits of every version after `--from`, up to `--to`, newest  
first, grouped by component.

It answers "the customer runs 8.1.4: is their Schema Registry bug fixed in  
a later version, and in which one?" or "which CP patch bumped Netty?" in  
one call: pass the customer version as `--from`, and the symptom as `--grep`.

Without `--from` and `--to`, the versions of the latest minor line are shown.  
Feeds exist from 7.4 onwards.

⚠️ The feeds only cover the community components (Common, Kafka, ksqlDB,  
REST Proxy, Schema Registry): nothing for Confluent Server, Control Center  
or Connect enterprise features. They list commit titles, not curated  
release notes, and have no CVE ids (`--security` matches security fixes and  
library upgrades). Answers are cached for one day in /tmp/cp-changelog  
(`--force-refresh`).

🎓 Tip: the end of playground run tells you when a newer patch of the version you run is published

## Usage

```bash
playground cp-changelog [OPTIONS]
```

## Options

#### `--from FROM`

🔢 Version in use: show the changes of the versions after it (excluded)

#### `--to TO`

🔢 Show the changes up to this version (included)

Default is the latest version with a changelog

#### `--component COMPONENT`

🧩 Only show the changes of this component (can be repeated)

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Allowed Values: | `kafka`, `schema-registry`, `ksqldb`, `rest-proxy`, `common`

#### `--grep GREP`

🔎 Only show the changes matching this regular expression (case insensitive)

Example: `--grep` "netty|anyOf|KAFKA-20843"

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--security`

#### `--security`

🔐 Only show security fixes and upgrades of libraries with frequent CVEs (Netty, Jetty, Jackson, log4j…)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--grep`

#### `--json`

🤖 Print the result as JSON

#### `--force-refresh`

☢️ Force refresh.

## Examples

```bash
playground cp-changelog --from 8.3.0
playground cp-changelog --from 8.1.4 --to 8.3.2 --component schema-registry --grep "anyOf|allOf"
playground cp-changelog --from 7.9.3 --security
playground cp-changelog --from 8.2.0 --component kafka --json

```


