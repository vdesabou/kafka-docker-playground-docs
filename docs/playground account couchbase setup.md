# playground account couchbase setup

🛠️ Validate and store the Couchbase Capella account of the Couchbase examples (fm-couchbase-sink, fm-couchbase-source)

Takes `COUCHBASE_HOSTNAME`, `COUCHBASE_USERNAME`, `COUCHBASE_PASSWORD` and the optional COUCHBASE_CAPELLA_\* (API key, organization, project, cluster) from the environment, then the secrets store, else asks  
for them (secrets without echo), puts them in the form the examples use,  
validates them (the cluster state and its allowed IPs through the Capella API), then stores them with `playground secrets set`.  
Nothing is stored when the login fails.

## Usage

```bash
playground account couchbase setup [OPTIONS]
```

## Options

#### `--no-store`

📋 Print the export commands instead of storing the variables

## Examples

```bash
playground account couchbase setup
```


