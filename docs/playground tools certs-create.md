# playground tools certs-create

🔐 Generate keys and certificates used for SSL

## Usage

```bash
playground tools certs-create [OPTIONS]
```

## Options

#### *--container, -c, --pod, -p CONTAINER*

🐳 container name (or pod name when cfk environment is used)  
  
🎓 Tip: you can pass multiple containers by specifying --container multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | ["broker", "broker2", "broker3", "client", "schema-registry", "restproxy", "connect", "connect2", "connect3", "control-center", "clientrestproxy", "ksqldb-server", "conduktor"]

#### *--verbose, -v*

🐞 Show command being ran.

#### *--output-folder FOLDER*

📁 Folder where certificates are created

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes


