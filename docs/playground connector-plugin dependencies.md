# playground connector-plugin dependencies

📚 Libraries bundled in a connector plugin, and what changed between two versions

"Which jackson / netty / aws-sdk version ships in 10.7.4, and which  
plugin version bumped it?", often after a CVE scanner flagged a jar.

Libraries are read from the META-INF/maven/\*\*/pom.properties of each jar  
(the libraries shaded inside a fat jar are listed too, "inside `<jar>`"),  
or from the jar file name. Same download and cache as search-jar  
(/tmp/connector-plugin-jars).

One `--connector-tag` (default latest) or `--connector-zip`: the list.  
Two of them (or a zip and a version): upgraded ⬆️, downgraded ⬇️,  
added ➕ and removed ➖ libraries.

`--find-first` `<artifact>:<version>` finds the first version of the plugin  
that ships at least that version of the library, with a binary search  
over the versions of Confluent Hub (each probed version is downloaded).

| Attributes       | &nbsp;
|------------------|-------------
| Alias:           | deps

## Usage

```bash
playground connector-plugin dependencies [OPTIONS]
```

## Dependencies

#### *python3*

visit https://www.python.org/downloads/ to install

## Options

#### `--connector-plugin, -c CONNECTOR-PLUGIN`

🔌 Connector plugin name (or `--connector-zip`)

owner/name, a connector class (io.confluent.connect.jdbc.JdbcSinkConnector: its plugin is found in the examples)  
or a fully managed type (`S3_SINK`)

🎓 Tip: use `<tab>` completion to trigger fzf completion

#### `--connector-tag CONNECTOR_TAG`

🔗 Connector version, default is the latest on Confluent Hub

Set it twice to compare two versions. With `--find-first`, the version to start the search from.

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--connector-zip CONNECTOR_ZIP`

🤐 Connector zip: its libraries, or compared with `--connector-tag`

#### `--grep GREP`

🔎 Only the libraries matching this regular expression (group:artifact or jar name, case insensitive)

Example: `--grep` "jackson|netty"

#### `--find-first ARTIFACT_VERSION`

🎯 `<artifact>:<version>`: first plugin version shipping at least that version of the library

Example: `--find-first` jackson-databind:2.18.0 (the artifactId, as in the list)

#### `--json`

🤖 Print the result as JSON

#### `--force-refresh`

☢️ Force refresh.

## Examples

```bash
playground connector-plugin dependencies --connector-plugin confluentinc/kafka-connect-s3 --connector-tag 10.5.0 --grep "jackson|netty"
playground connector-plugin dependencies --connector-plugin confluentinc/kafka-connect-s3 --connector-tag 10.5.0 --connector-tag 12.1.15
playground connector-plugin dependencies --connector-plugin confluentinc/kafka-connect-jdbc --find-first postgresql:42.7.0
playground connector-plugin deps --connector-zip /path/to/customer-plugin.zip --connector-plugin confluentinc/kafka-connect-jdbc --connector-tag 10.9.9

```


