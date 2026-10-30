# playground connector-plugin fm-versions

☁️ Fully managed connector: the connector version shipped by each cc-connect image (Confluent employees)

Fully managed connectors have no Confluent Hub versions: each cc-connect  
image version (a tag of the private confluentinc/cc-docker-connect  
repository) pins one version of every connector in  
cc-connect/cache-versions.env.

Without option: the last `--last` cc-connect versions, grouped by connector  
version, newest first; `--with-log` adds the commits between two connector  
versions (playground connector-plugin sourcecode `--log`).  
`--cc-connect-version`: the connector version of one image.  
`--find-first`: the first cc-connect version shipping a connector version  
(binary search), to answer "is the fix of 3.2.1 in an image yet?".

Needs gh logged in (or `GH_TOKEN`), the Confluent VPN, and the employee  
version of the plugin list (playground generate-connector-plugin-list  
with AWS credentials). The tags are listed once a day (about 30 s).  
An image version is not a deployment: the cc-connect version of a  
cluster is in its connect logs.

## Usage

```bash
playground connector-plugin fm-versions [OPTIONS]
```

## Environment Variables

#### `GH_TOKEN`

🔑 GitHub token, when gh is not logged in (cc-docker-connect is private)

## Options

#### `--connector-plugin, -c CONNECTOR-PLUGIN`

☁️ Fully managed connector, for example confluentinc/SalesforceBulkApiV2Sink

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--last LAST`

🆕 Number of last cc-connect versions to look at (default 10)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--cc-connect-version`, `--find-first`

#### `--cc-connect-version CC_CONNECT_VERSION`

🏷️ Only this cc-connect version: the connector version it ships

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--last`, `--find-first`, `--with-log`

#### `--find-first CONNECTOR_VERSION`

🎯 First cc-connect version shipping at least this connector version (numeric part compared, 3.2.1)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--last`, `--cc-connect-version`, `--with-log`

#### `--with-log`

📜 Also the commits between two consecutive connector versions

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--cc-connect-version`, `--find-first`, `--json`

#### `--json`

🤖 Print the result as JSON

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--with-log`

#### `--force-refresh`

☢️ Force refresh.

## Examples

```bash
playground connector-plugin fm-versions --connector-plugin confluentinc/SalesforceBulkApiV2Sink
playground connector-plugin fm-versions --connector-plugin confluentinc/SalesforceBulkApiV2Sink --last 30 --with-log
playground connector-plugin fm-versions --connector-plugin confluentinc/S3_SINK --cc-connect-version 0.3780.0
playground connector-plugin fm-versions --connector-plugin confluentinc/SalesforceBulkApiV2Sink --find-first 3.2.0

```


