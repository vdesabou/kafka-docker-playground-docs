# playground account gcp check

🩺 Check that the stored GCP key works for the GCP examples

Logs in with the service account key exactly like a connector does  
(OAuth JWT bearer, key from `GCP_KEYFILE_CONTENT`, else  
~/.config/kafka-docker-playground/gcp-keyfile.json), explains a  
rejection, then calls each API the examples use (Cloud Storage, Pub/Sub,  
BigQuery, Spanner, Bigtable, Firestore, Cloud Functions, Dataproc,  
Realtime Database) and the project permissions some of them need. Each  
failure says whether the API is disabled, billing is off or a role is  
missing, and which examples it breaks.

Read-only, needs neither Docker nor gcloud, takes a few seconds.

Exits with 1 when the key can't log in.

## Usage

```bash
playground account gcp check [OPTIONS]
```

## Options

#### `--project, -p PROJECT`

🗂️ Project id

Default: `GCP_PROJECT` (environment, then secrets store), else the only  
project the account can see.

#### `--keyfile KEYFILE`

📄 Service account key file to check instead of the stored one (e.g. an example's keyfile.json)

## Examples

```bash
playground account gcp check
```

```bash
playground account gcp check --keyfile connect/connect-gcp-gcs-sink/keyfile.json
```


