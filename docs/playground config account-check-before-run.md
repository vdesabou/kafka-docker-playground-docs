# playground config account-check-before-run

🩺 When running an example of a provider (gcp, azure, aws, snowflake, salesforce, servicenow, databricks, zendesk, jira, marketo, clickhouse, couchbase, mongodb-atlas, pagerduty), call playground account `<provider>` check first: a login that does not work stops the run in a few seconds instead of failing minutes later. True by default, never done in CI.

## Usage

```bash
playground config account-check-before-run [ENABLED]
```

## Arguments

#### `ENABLED`



| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `true`

## Examples

```bash
playground config account-check-before-run false
```

```bash
playground config account-check-before-run true
```


