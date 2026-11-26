# playground storage

🪣 Object store commands

List, read and wait for the objects that a sink connector writes to an  
object store, without the command line of each provider (aws s3, gcloud  
storage, az storage, hdfs dfs, sftp) and without downloading files by  
hand.

- **ls**: objects of the bucket, and a summary per topic-partition
- **cat**: records of the objects (Avro, Parquet, JSON, CSV, text decoded)
- **wait-for-objects**: wait until N objects are written

Supported: Amazon S3, MinIO and other S3 compatible stores (store.url),  
Google Cloud Storage, Azure Blob Storage, ADLS Gen2, HDFS (no Kerberos) and  
SFTP, through one rclone container (rclone/rclone).

🔗 With `--connector` (or the only running connector), the bucket, the  
folder (topics.dir) and the credentials come from the config of the  
connector, self-managed or fully managed. A secret masked by the REST API  
is read from the connect container (a ${file:...} config provider, the  
~/.aws/credentials file, the GCS key file of gcs.credentials.path), then  
from the example script, then from the playground secrets  
(`AWS_ACCESS_KEY_ID`, `GCP_KEYFILE_CONTENT`, `AZURE_ACCOUNT_KEY`).

🌐 With `--url`, any location: s3://bucket/prefix (with `--endpoint` for  
MinIO), gs://bucket/prefix, az://account/container/prefix,  
hdfs://[user@]namenode:9000/path, sftp://user:password@host:22/path.

🎓 Tip: in an example script, use 'storage wait-for-objects' instead of a  
fixed sleep, then 'storage cat' instead of a download + 'tools  
read-avro-file'. 'connector reconcile' compares the records of the  
objects with the topic (lost, duplicated records).

## Usage

```bash
playground storage COMMAND
```

## Storage commands

- [cat](playground%20storage%20cat) - 📄 Print the records of the objects written by a sink connector
- [ls](playground%20storage%20ls) - 🪣 List the objects written by a sink connector
- [wait-for-objects](playground%20storage%20wait-for-objects) - ⏳ Wait for a sink connector to write a minimum number of objects


