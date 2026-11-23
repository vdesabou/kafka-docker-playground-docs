# playground account

☁️ Set up and check the accounts the examples run against

- **ccloud**: your Confluent Cloud environment, one cluster per cloud, their API keys
- **salesforce**: a Salesforce org: External Client App (JWT bearer), Platform Event, Change Data Capture
- **gcp**: a Google Cloud project: APIs, service account with its roles, key
- **azure**: an Azure subscription: service principal with its roles, resource providers
- **snowflake**: a Snowflake account: account identifier, admin login, roles, edition
- **aws**: AWS access keys and region, the IAM role of the assume-role variants
- **servicenow**: a ServiceNow developer instance: URL, admin login, hibernation
- **databricks**: a Databricks workspace: token, SQL warehouse, S3 staging bucket

Each provider has 'setup' (configure the account in one command, store  
the variables with `playground secrets set`) and, except ccloud, 'check'  
(a few seconds, read-only: does the stored login still work, and what is  
missing).

📖 All the providers, how they behave, and the guide of each one:  
https://kafka-docker-playground.io/#/accounts

## Usage

```bash
playground account COMMAND
```

## Commands

- [aws](playground%20account%20aws) - ☁️ Set up the AWS credentials of the AWS examples, and check them
  - [check](playground%20account%20aws%20check) - 🩺 Check the AWS credentials of the AWS examples
  - [setup](playground%20account%20aws%20setup) - 🛠️ Validate and store the AWS credentials of the AWS examples
- [azure](playground%20account%20azure) - ☁️ Set up an Azure subscription for the Azure examples, and check it
  - [check](playground%20account%20azure%20check) - 🩺 Check that the stored Azure service principal works for the Azure examples
  - [setup](playground%20account%20azure%20setup) - 🛠️ Configure an Azure subscription for the Azure examples
- [ccloud](playground%20account%20ccloud) - 🌤️ Set up your own Confluent Cloud clusters for the fully managed examples
  - [setup](playground%20account%20ccloud%20setup) - 🏗️ Create (or complete) your personal environment and clusters, and store them in a secrets profile
- [databricks](playground%20account%20databricks) - ☁️ Set up the Databricks workspace of the Databricks examples, and check it
  - [check](playground%20account%20databricks%20check) - 🩺 Check the Databricks workspace of the Databricks examples
  - [setup](playground%20account%20databricks%20setup) - 🛠️ Validate and store the Databricks workspace of the Databricks examples
- [gcp](playground%20account%20gcp) - ☁️ Set up a Google Cloud project for the GCP examples, and check it
  - [check](playground%20account%20gcp%20check) - 🩺 Check that the stored GCP key works for the GCP examples
  - [setup](playground%20account%20gcp%20setup) - 🛠️ Configure a Google Cloud project for the GCP examples
- [salesforce](playground%20account%20salesforce) - ☁️ Set up a Salesforce org for the Salesforce examples, and check it
  - [check](playground%20account%20salesforce%20check) - 🩺 Check that the stored Salesforce credentials work
  - [setup](playground%20account%20salesforce%20setup) - 🛠️ Configure a Salesforce org for the Salesforce examples
- [servicenow](playground%20account%20servicenow) - ☁️ Set up the ServiceNow instance of the ServiceNow examples, and check it
  - [check](playground%20account%20servicenow%20check) - 🩺 Check the ServiceNow instance of the ServiceNow examples
  - [setup](playground%20account%20servicenow%20setup) - 🛠️ Validate and store the ServiceNow instance of the ServiceNow examples
- [snowflake](playground%20account%20snowflake) - ❄️ Set up the Snowflake account of the Snowflake examples, and check it
  - [check](playground%20account%20snowflake%20check) - 🩺 Check that the stored Snowflake login works for the Snowflake examples
  - [setup](playground%20account%20snowflake%20setup) - 🛠️ Validate and store the Snowflake login of the Snowflake examples


