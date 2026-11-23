# playground account gcp setup

🛠️ Configure a Google Cloud project for the GCP examples

With gcloud (installed on your machine, else the google/cloud-sdk image  
the examples already use):

• enables the APIs of the examples: Cloud Storage, Pub/Sub, BigQuery,  
Spanner, Bigtable, Firestore, Realtime Database, Cloud Functions,  
Cloud Run, Dataproc, IAM, Resource Manager  
• creates the service account kdp-playground (reused if it exists)  
and grants it the roles the examples need on the project  
• creates a key, saved once as  
~/.config/kafka-docker-playground/gcp-keyfile.json (reused on the  
next runs while the key still exists)

then waits until the key can log in, and stores `GCP_PROJECT` and  
`GCP_KEYFILE_CONTENT` with `playground secrets set`: no more keyfile.json  
to copy into each example folder.

Without `--account`, 'gcloud auth login' opens the browser once, in a  
gcloud configuration of its own: your gcloud login and default project  
are left alone. Running it again on the same project changes nothing.

Can't create service accounts in the project (shared project)? Pass the  
key you were given with `--keyfile`: it is checked and stored, nothing is  
changed in the project.

⚠️ The roles are broad (Storage Admin, Pub/Sub Admin, BigQuery Admin,  
Spanner Admin, Bigtable Admin, Project IAM Admin…): use a sandbox  
project, not a shared one.

## Usage

```bash
playground account gcp setup [OPTIONS]
```

## Options

#### `--project, -p PROJECT`

🗂️ Project id

Default: `GCP_PROJECT` (environment, then secrets store), else the only  
project the account can see.

#### `--account, -a ACCOUNT`

🔑 An account your own gcloud is already logged into (gcloud auth list): no browser

Uses your gcloud configuration instead of the dedicated one.

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--keyfile`

#### `--service-account SERVICE_ACCOUNT`

🤖 Name of the service account (6 to 30 lowercase letters, digits and dashes)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `kdp-playground`

#### `--keyfile KEYFILE`

📄 Use this existing service account key instead of creating a service account

For a shared project where you can't create service accounts: the key  
is checked, saved once and stored (`GCP_PROJECT` defaults to its  
project_id), then `playground account gcp check` runs. Nothing is  
changed in the project, gcloud is not needed.

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--account`, `--new-key`

#### `--new-key`

♻️ Create a new key even if the saved one still works (the previous file is kept as .bak)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--keyfile`

#### `--dry-run`

🧪 Only print the APIs, the service account and the roles, change nothing

#### `--no-store`

📋 Print the export commands instead of storing `GCP_PROJECT` and `GCP_KEYFILE_CONTENT`

## Examples

```bash
playground account gcp setup
```

```bash
playground account gcp setup --project my-sandbox-project
```

```bash
playground account gcp setup --account me@example.com --project my-sandbox-project
```

```bash
playground account gcp setup --keyfile ~/Downloads/my-project-3f2a91c07b4e.json
```

```bash
playground account gcp setup --dry-run
```


