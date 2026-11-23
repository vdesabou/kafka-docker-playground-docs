# playground account couchbase

🛋️ Set up and check the Couchbase Capella account of the Couchbase examples (fm-couchbase-sink, fm-couchbase-source)

- **setup**: validate and store `COUCHBASE_HOSTNAME`, `COUCHBASE_USERNAME`, `COUCHBASE_PASSWORD` and the optional COUCHBASE_CAPELLA_\* (API key, organization, project, cluster)
- **check**: verify them in a few seconds: the cluster state and its allowed IPs through the Capella API

Nothing to configure in Couchbase Capella: these examples only need the values,  
in the right form, still valid (free tier clusters are turned off after 72 hours without use: setup turns them back on).

📖 https://kafka-docker-playground.io/#/accounts

## Usage

```bash
playground account couchbase COMMAND
```

## Commands

- [check](playground%20account%20couchbase%20check) - 🩺 Check the Couchbase Capella account of the Couchbase examples (fm-couchbase-sink, fm-couchbase-source)
- [setup](playground%20account%20couchbase%20setup) - 🛠️ Validate and store the Couchbase Capella account of the Couchbase examples (fm-couchbase-sink, fm-couchbase-source)


