# playground db cdc-check

🔍 Check the CDC prerequisites of the database

One verdict per prerequisite of the CDC connectors (Oracle CDC and  
XStream, Debezium), with its value and the statement that fixes it, and  
exit code 1 when one is missing:

- **oracle**: ARCHIVELOG, minimal and all columns supplemental logging (database, or `--table`), XStream outbound servers and their capture, enable_goldengate_replication, connector user (common user, CREATE SESSION, LogMiner privileges)
- **postgres**: wal_level=logical, wal senders, replication slots (free, inactive ones retaining WAL, invalidated), publications, published tables without replica identity, connector user REPLICATION
- **mysql**: log_bin, binlog_format=ROW, binlog_row_image=FULL,
- **mariadb**: server_id, gtid_mode, binlog retention, connector user privileges
- **sqlserver**: SQL Server Agent, databases and tables with CDC, capture job
- **mongodb**: replica set (change streams), oplog window

It connects as the admin user of the container (see 'playground db  
sql'), and checks the privileges of the connector user with  
`--connector-user`.

🎓 Tip: the classic "connector RUNNING but no records" of a CDC source  
is a prerequisite missing in the database: run it before reading the  
connector logs.

## Usage

```bash
playground db cdc-check [OPTIONS]
```

## Options

#### `--container, -c CONTAINER`

🐳 Container of the database

ℹ️ If not set, the only running container whose image is a supported database

#### `--engine ENGINE`

🛢️ Database engine, when the image name of the container does not tell it

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `oracle`, `postgres`, `mysql`, `mariadb`, `sqlserver`, `db2`, `mongodb`

#### `--user, -u USER`

👤 User to connect with

ℹ️ If not set, the admin user of the container environment (see above)

#### `--password PASSWORD`

🔑 Password of `--user`

ℹ️ If not set, the password of the container environment

#### `--database, -d DATABASE`

🗄️ Database (Oracle: service name, ORCLPDB1 for the pluggable database)

ℹ️ If not set, the database of the container environment

#### `--connector-user CONNECTOR_USER`

👤 User of the connector, to check its privileges (oracle, postgres, mysql, mariadb)

#### `--table, -t TABLE`

🗂️ Captured table to check: all columns supplemental logging (oracle, `<owner>`.`<table>`), replica identity (postgres, `<schema>`.`<table>`), CDC enabled (sqlserver, `<schema>`.`<table>`)

#### `--json`

📗 Print {"engine", "container", "verdict", "ok", "fail", "warn", "checks": [{"status", "check", "value", "fix"}]} and nothing else

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground db cdc-check
```

```bash
playground db cdc-check --connector-user C##MYUSER --table C##MYUSER.CUSTOMERS
```

```bash
playground db cdc-check --connector-user debezium --table public.customers
```

```bash
playground db cdc-check --database testDB --table dbo.customers
```

```bash
playground db cdc-check --json | jq -r '.checks[] | select(.status == "fail") | .fix'
```

## Example output

```text
$ playground db cdc-check --connector-user C##CFLTUSER --table C##CFLTUSER.CUSTOMERS
12:59:47 ℹ️ 🔍 Checking the CDC prerequisites of oracle container (oracle, connector user C##CFLTUSER, table C##CFLTUSER.CUSTOMERS)
   ℹ️  Oracle version                           19.0.0.0.0 (CDB, PDBs: ORCLPDB1 READ WRITE)
   ✅ ARCHIVELOG mode                          ARCHIVELOG
   ℹ️  archived logs of the last 24 hours       1
   ✅ minimal supplemental logging             IMPLICIT
   ✅ all columns supplemental logging         YES (database level: every table)
   ✅ enable_goldengate_replication (XStream)  TRUE
   ✅ XStream outbound server XOUT             capture CAP$_XOUT_1 ENABLED, connect user C##CFLTUSER
   ℹ️  streams_pool_size (XStream)              0 (0: sized automatically in the SGA)
   ✅ connector user C##CFLTUSER               exists, common user
   ✅ CREATE SESSION of C##CFLTUSER            granted
12:59:48 ℹ️ ✅ the 7 CDC prerequisites are met
```

```text
$ playground db cdc-check
12:52:12 ℹ️ 🔍 Checking the CDC prerequisites of postgres container (postgres)
   ℹ️  PostgreSQL version  15.18 (Debian 15.18-1.pgdg13+1)
   ❌ wal_level           replica
      👉 ALTER SYSTEM SET wal_level = logical; then restart PostgreSQL (docker compose: command: postgres -c wal_level=logical)
   ✅ max_wal_senders     10
   ✅ replication slots   0 used of 10
   ℹ️  publications        none (pgoutput: the connector creates one, publication.autocreate.mode)
12:52:12 🔥 ❌ 1 CDC prerequisite(s) missing, ✅ 2 ok, ⚠️ 0 warning(s)
```


