# playground account databricks

☁️ Set up the Databricks workspace of the Databricks examples, and check it

- **setup**: validate the token, pick the SQL warehouse (http path), validate the S3 staging bucket, store them
- **check**: verify the token, the SQL warehouse, the staging bucket, and print the grants the Delta Lake sink needs

The Delta Lake sink and the JDBC examples run against a Databricks  
workspace on AWS: a SQL warehouse, a personal access token, and for the  
Delta Lake sink an S3 staging bucket with keys allowed on it. Only  
creating the workspace (a trial works) stays manual.

📖 Step by step guide (workspace, warehouse, bucket, grants, troubleshooting):  
https://kafka-docker-playground.io/#/databricks

## Usage

```bash
playground account databricks COMMAND
```

## Commands

- [check](playground%20account%20databricks%20check) - 🩺 Check the Databricks workspace of the Databricks examples
- [setup](playground%20account%20databricks%20setup) - 🛠️ Validate and store the Databricks workspace of the Databricks examples


