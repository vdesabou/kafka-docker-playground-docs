# playground account clickhouse setup

🛠️ Validate and store the ClickHouse Cloud account of the ClickHouse examples (connect-clickhouse-sink, fm-clickhouse-sink)

Takes `CLICKHOUSE_CLOUD_HOSTNAME`, `CLICKHOUSE_CLOUD_USERNAME` and `CLICKHOUSE_CLOUD_PASSWORD` from the environment, then the secrets store, else asks  
for them (secrets without echo), puts them in the form the examples use,  
validates them (a SELECT over HTTPS (it also wakes an idle service up)), then stores them with `playground secrets set`.  
Nothing is stored when the login fails.

## Usage

```bash
playground account clickhouse setup [OPTIONS]
```

## Options

#### `--no-store`

📋 Print the export commands instead of storing the variables

## Examples

```bash
playground account clickhouse setup
```


