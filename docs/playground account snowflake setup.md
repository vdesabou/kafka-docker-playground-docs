# playground account snowflake setup

🛠️ Validate and store the Snowflake login of the Snowflake examples

Takes the account identifier in any form (the account URL,  
orgname-accountname or `<locator>`.`<region>`.`<cloud>`) and turns it into the  
one the examples use, logs in with the admin user and password exactly  
like the examples (password login, as snowsql does), shows the roles  
and the edition, then stores `SNOWFLAKE_ACCOUNT_NAME`, `SNOWFLAKE_USERNAME`  
and `SNOWFLAKE_PASSWORD` with `playground secrets set`, and runs check.

Missing values are taken from the stored ones, else asked for (the  
password without echo). Needs neither snowsql nor Docker.

## Usage

```bash
playground account snowflake setup [OPTIONS]
```

## Options

#### `--account ACCOUNT`

🏔️ Account identifier, or the account URL (https://`<it>`.snowflakecomputing.com)

#### `--user USER`

👤 Admin user (must be able to use SECURITYADMIN, SYSADMIN and USERADMIN, ACCOUNTADMIN for Iceberg)

#### `--password PASSWORD`

🔐 Its password (asked for without echo when missing)

#### `--no-store`

📋 Print the export commands instead of storing the variables

## Examples

```bash
playground account snowflake setup
```

```bash
playground account snowflake setup --account https://xy12345.eu-west-3.aws.snowflakecomputing.com --user ADMIN
```


