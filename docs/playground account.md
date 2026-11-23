# playground account

☁️ Set up and check the third-party accounts the examples run against

- **salesforce**: a Salesforce org: External Client App (JWT bearer), Platform Event, Change Data Capture
- **gcp**: a Google Cloud project: APIs, service account with its roles, key

Each provider has 'setup' (configure the account in one command, store  
the variables with `playground secrets set`) and 'check' (a few seconds,  
read-only: does the stored login still work, and what is missing).

📖 Step by step guides:  
https://kafka-docker-playground.io/#/salesforce  
https://kafka-docker-playground.io/#/gcp

## Usage

```bash
playground account COMMAND
```

## Commands

- [gcp](playground%20account%20gcp) - ☁️ Set up a Google Cloud project for the GCP examples, and check it
  - [check](playground%20account%20gcp%20check) - 🩺 Check that the stored GCP key works for the GCP examples
  - [setup](playground%20account%20gcp%20setup) - 🛠️ Configure a Google Cloud project for the GCP examples
- [salesforce](playground%20account%20salesforce) - ☁️ Set up a Salesforce org for the Salesforce examples, and check it
  - [check](playground%20account%20salesforce%20check) - 🩺 Check that the stored Salesforce credentials work
  - [setup](playground%20account%20salesforce%20setup) - 🛠️ Configure a Salesforce org for the Salesforce examples


