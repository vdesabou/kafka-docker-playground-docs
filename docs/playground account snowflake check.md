# playground account snowflake check

🩺 Check that the stored Snowflake login works for the Snowflake examples

Logs in with `SNOWFLAKE_ACCOUNT_NAME`, `SNOWFLAKE_USERNAME` and  
`SNOWFLAKE_PASSWORD` exactly like the examples (password login, as  
snowsql does), explains a rejection (wrong password, MFA required,  
locked user, network policy, wrong account identifier), then checks the  
roles the examples use (SECURITYADMIN, SYSADMIN, USERADMIN, ACCOUNTADMIN  
for Iceberg), the default role, the edition (Enterprise for Iceberg)  
and the warehouses the examples left behind.

Read-only, needs neither snowsql nor Docker, takes a few seconds.

Exits with 1 when the login fails.

## Usage

```bash
playground account snowflake check
```

## Examples

```bash
playground account snowflake check
```


