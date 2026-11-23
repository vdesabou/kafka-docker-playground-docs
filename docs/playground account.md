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

zendesk, jira, marketo, clickhouse, couchbase, mongodb-atlas, pagerduty  
a few values each: validated, stored, checked (expired, paused, idle)

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
- [clickhouse](playground%20account%20clickhouse) - 🏠 Set up and check the ClickHouse Cloud account of the ClickHouse examples (connect-clickhouse-sink, fm-clickhouse-sink)
  - [check](playground%20account%20clickhouse%20check) - 🩺 Check the ClickHouse Cloud account of the ClickHouse examples (connect-clickhouse-sink, fm-clickhouse-sink)
  - [setup](playground%20account%20clickhouse%20setup) - 🛠️ Validate and store the ClickHouse Cloud account of the ClickHouse examples (connect-clickhouse-sink, fm-clickhouse-sink)
- [couchbase](playground%20account%20couchbase) - 🛋️ Set up and check the Couchbase Capella account of the Couchbase examples (fm-couchbase-sink, fm-couchbase-source)
  - [check](playground%20account%20couchbase%20check) - 🩺 Check the Couchbase Capella account of the Couchbase examples (fm-couchbase-sink, fm-couchbase-source)
  - [setup](playground%20account%20couchbase%20setup) - 🛠️ Validate and store the Couchbase Capella account of the Couchbase examples (fm-couchbase-sink, fm-couchbase-source)
- [databricks](playground%20account%20databricks) - ☁️ Set up the Databricks workspace of the Databricks examples, and check it
  - [check](playground%20account%20databricks%20check) - 🩺 Check the Databricks workspace of the Databricks examples
  - [setup](playground%20account%20databricks%20setup) - 🛠️ Validate and store the Databricks workspace of the Databricks examples
- [gcp](playground%20account%20gcp) - ☁️ Set up a Google Cloud project for the GCP examples, and check it
  - [check](playground%20account%20gcp%20check) - 🩺 Check that the stored GCP key works for the GCP examples
  - [setup](playground%20account%20gcp%20setup) - 🛠️ Configure a Google Cloud project for the GCP examples
- [jira](playground%20account%20jira) - 📋 Set up and check the Jira account of the Jira examples (connect-jira-source, fm-jira-source)
  - [check](playground%20account%20jira%20check) - 🩺 Check the Jira account of the Jira examples (connect-jira-source, fm-jira-source)
  - [setup](playground%20account%20jira%20setup) - 🛠️ Validate and store the Jira account of the Jira examples (connect-jira-source, fm-jira-source)
- [marketo](playground%20account%20marketo) - 📣 Set up and check the Marketo account of the Marketo examples (connect-marketo-source, fm-marketo-sink)
  - [check](playground%20account%20marketo%20check) - 🩺 Check the Marketo account of the Marketo examples (connect-marketo-source, fm-marketo-sink)
  - [setup](playground%20account%20marketo%20setup) - 🛠️ Validate and store the Marketo account of the Marketo examples (connect-marketo-source, fm-marketo-sink)
- [mongodb-atlas](playground%20account%20mongodb-atlas) - 🍃 Set up and check the MongoDB Atlas account of the MongoDB Atlas examples (fm-mongodb-atlas-sink, fm-mongodb-atlas-source)
  - [check](playground%20account%20mongodb-atlas%20check) - 🩺 Check the MongoDB Atlas account of the MongoDB Atlas examples (fm-mongodb-atlas-sink, fm-mongodb-atlas-source)
  - [setup](playground%20account%20mongodb-atlas%20setup) - 🛠️ Validate and store the MongoDB Atlas account of the MongoDB Atlas examples (fm-mongodb-atlas-sink, fm-mongodb-atlas-source)
- [pagerduty](playground%20account%20pagerduty) - 🛎️ Set up and check the PagerDuty account of the PagerDuty example (connect-pagerduty-sink)
  - [check](playground%20account%20pagerduty%20check) - 🩺 Check the PagerDuty account of the PagerDuty example (connect-pagerduty-sink)
  - [setup](playground%20account%20pagerduty%20setup) - 🛠️ Validate and store the PagerDuty account of the PagerDuty example (connect-pagerduty-sink)
- [salesforce](playground%20account%20salesforce) - ☁️ Set up a Salesforce org for the Salesforce examples, and check it
  - [check](playground%20account%20salesforce%20check) - 🩺 Check that the stored Salesforce credentials work
  - [setup](playground%20account%20salesforce%20setup) - 🛠️ Configure a Salesforce org for the Salesforce examples
- [servicenow](playground%20account%20servicenow) - ☁️ Set up the ServiceNow instance of the ServiceNow examples, and check it
  - [check](playground%20account%20servicenow%20check) - 🩺 Check the ServiceNow instance of the ServiceNow examples
  - [setup](playground%20account%20servicenow%20setup) - 🛠️ Validate and store the ServiceNow instance of the ServiceNow examples
- [snowflake](playground%20account%20snowflake) - ❄️ Set up the Snowflake account of the Snowflake examples, and check it
  - [check](playground%20account%20snowflake%20check) - 🩺 Check that the stored Snowflake login works for the Snowflake examples
  - [setup](playground%20account%20snowflake%20setup) - 🛠️ Validate and store the Snowflake login of the Snowflake examples
- [zendesk](playground%20account%20zendesk) - 🎫 Set up and check the Zendesk account of the Zendesk examples (connect-zendesk-source, fm-zendesk-source)
  - [check](playground%20account%20zendesk%20check) - 🩺 Check the Zendesk account of the Zendesk examples (connect-zendesk-source, fm-zendesk-source)
  - [setup](playground%20account%20zendesk%20setup) - 🛠️ Validate and store the Zendesk account of the Zendesk examples (connect-zendesk-source, fm-zendesk-source)


