# playground account databricks setup

🛠️ Validate and store the Databricks workspace of the Databricks examples

Validates the personal access token, lists the SQL warehouses and takes  
`DATABRICKS_HTTP_PATH` and `DATABRICKS_SERVER_HOSTNAME` from the connection  
details of the one you pick (the values people get wrong), validates  
the S3 staging bucket with the staging keys, stores everything with  
`playground secrets set` (`DATABRICKS_HOST` too, for the JDBC examples),  
prints the grants the Delta Lake sink needs, and runs check.

Missing values are taken from the stored ones, else asked for (secrets  
without echo).

## Usage

```bash
playground account databricks setup [OPTIONS]
```

## Options

#### `--host HOST`

🏠 Workspace URL or host (https://dbc-xxxx.cloud.databricks.com)

#### `--token TOKEN`

🔐 Personal access token (Settings \> Developer \> Access tokens)

#### `--warehouse WAREHOUSE`

🏭 Name or id of the SQL warehouse (default: the only one, else the stored one)

#### `--bucket BUCKET`

🪣 S3 staging bucket of the Delta Lake sink

#### `--bucket-region BUCKET_REGION`

🌍 Region of the staging bucket

#### `--staging-access-key-id STAGING_ACCESS_KEY_ID`

🔑 AWS access key id allowed on the staging bucket

#### `--staging-secret-access-key STAGING_SECRET_ACCESS_KEY`

🔐 Its secret access key

#### `--no-store`

📋 Print the export commands instead of storing the variables

## Examples

```bash
playground account databricks setup
```

```bash
playground account databricks setup --host https://dbc-1234.cloud.databricks.com --warehouse "Serverless Starter Warehouse"
```


