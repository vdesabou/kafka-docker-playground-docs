# playground account clickhouse

🏠 Set up and check the ClickHouse Cloud account of the ClickHouse examples (connect-clickhouse-sink, fm-clickhouse-sink)

- **setup**: validate and store `CLICKHOUSE_CLOUD_HOSTNAME`, `CLICKHOUSE_CLOUD_USERNAME` and `CLICKHOUSE_CLOUD_PASSWORD`
- **check**: verify them in a few seconds: a SELECT over HTTPS (it also wakes an idle service up)

Nothing to configure in ClickHouse Cloud: these examples only need the values,  
in the right form, still valid (services idle when unused, trials end).

📖 https://kafka-docker-playground.io/#/accounts

## Usage

```bash
playground account clickhouse COMMAND
```

## Commands

- [check](playground%20account%20clickhouse%20check) - 🩺 Check the ClickHouse Cloud account of the ClickHouse examples (connect-clickhouse-sink, fm-clickhouse-sink)
- [setup](playground%20account%20clickhouse%20setup) - 🛠️ Validate and store the ClickHouse Cloud account of the ClickHouse examples (connect-clickhouse-sink, fm-clickhouse-sink)


