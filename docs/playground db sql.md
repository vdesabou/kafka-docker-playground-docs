# playground db sql

🛢️ Run SQL statements with the client of the database

The statements are read from stdin (a heredoc, the easiest to copy and  
paste and to grow into a longer query), `--file`, or `--sql` for a quick  
one-liner, and run in one session of the client of the database,  
inside its container:

- **engine**: client    default user / database (from the container environment)
- **oracle**: sqlplus   sys AS SYSDBA (`ORACLE_PWD` or `ORACLE_PASSWORD`) / `ORACLE_SID` (ORCLCDB)
- **postgres**: psql      `POSTGRES_USER` / `POSTGRES_DB`
- **mysql**: mysql     root (`MYSQL_ROOT_PASSWORD`) / `MYSQL_DATABASE`
- **mariadb**: mariadb   root (`MARIADB_ROOT_PASSWORD`) / `MARIADB_DATABASE`
- **sqlserver**: sqlcmd    sa (`SA_PASSWORD` or `MSSQL_SA_PASSWORD`) / master
- **db2**: db2       db2inst1 (`DB2INST1_PASSWORD`) / DBNAME
- **mongodb**: mongosh   `MONGO_INITDB_ROOT_USERNAME` (none if not set) / test

For Oracle, `--database` is the service name: ORCLPDB1 (or FREEPDB1,  
XEPDB1) for the pluggable database, and a user other than sys connects  
as a normal user. For MongoDB, the statements are mongosh commands  
(use, db.collection.insertOne(...)...). For SQL Server, separate the  
batches with GO, as with sqlcmd.

The execution stops at the first statement that fails, and the command  
exits with code 1 (so an example script with set -e stops there).  
With `--ignore-errors`, every statement is run, the errors are printed  
and counted, and the command exits with code 0. MongoDB always runs  
every command: a failing one makes the command exit with code 1.

🎓 Tip: quote the heredoc (\<\< 'EOF') when the statements contain $,  
for example Oracle views such as V$DATABASE.

## Usage

```bash
playground db sql [OPTIONS]
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

#### `--file, -f FILE`

📄 File with the statements

ℹ️ If neither `--file` nor `--sql` is set, the statements are read from stdin

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--sql`

#### `--sql, -s SQL`

✍️ Statements, inline

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--file`

#### `--ignore-errors`

🙈 Run every statement, even after a failing one, and exit with code 0 (the errors are still printed)

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground db sql << 'EOF'
CREATE TABLE customers (id INT PRIMARY KEY, name VARCHAR(50));
INSERT INTO customers VALUES (1, 'alice');
EOF
```

```bash
playground db sql > /tmp/result.log 2>&1 << 'EOF'
select * from customers;
EOF
```

```bash
playground db sql --database ORCLPDB1 --user C##MYUSER --password mypassword << 'EOF'
select count(*) from customers;
EOF
```

```bash
playground db sql --container postgres-source << 'EOF'
select * from pg_replication_slots;
EOF
```

```bash
playground db sql --file ./setup.sql --ignore-errors
```

```bash
playground db sql --sql "select * from customers"
```

```bash
playground db sql << 'EOF'
use inventory
db.customers.insertOne({_id: 1, name: "alice"})
EOF
```

## Example output

```text
$ playground db sql --sql "select * from customers"
10:51:17 ℹ️ 🛢️ Running SQL in postgres container (postgres, psql, user myuser, database postgres)
 id | name
----+-------
  1 | alice
  2 | bob
(2 rows)
```

```text
$ playground db sql --sql "select * from nope; select 1;"
10:51:18 ℹ️ 🛢️ Running SQL in postgres container (postgres, psql, user myuser, database postgres)
ERROR:  relation "nope" does not exist
LINE 1: select * from nope;
                      ^
10:51:18 🔥 ❌ a statement failed (the next ones were not run), see the error above
10:51:18 🔥    🎓 add --ignore-errors to run every statement
```


