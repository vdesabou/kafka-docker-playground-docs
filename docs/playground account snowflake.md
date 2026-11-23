# playground account snowflake

❄️ Set up the Snowflake account of the Snowflake examples, and check it

- **setup**: validate and store the account identifier, admin user and password
- **check**: verify that the stored login works and has the roles the examples need

The examples create their own database, role, warehouse and user with the  
admin login you give them: what they need is that login, in the right  
form, with the right roles. Only signing up for the account (a 30-day  
trial works, Enterprise edition for the Iceberg variants) stays manual.

📖 Step by step guide (trial, account identifier, roles, troubleshooting):  
https://kafka-docker-playground.io/#/snowflake

## Usage

```bash
playground account snowflake COMMAND
```

## Commands

- [check](playground%20account%20snowflake%20check) - 🩺 Check that the stored Snowflake login works for the Snowflake examples
- [setup](playground%20account%20snowflake%20setup) - 🛠️ Validate and store the Snowflake login of the Snowflake examples


