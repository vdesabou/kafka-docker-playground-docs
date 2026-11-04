# playground db

🛢️ Database commands

Run SQL in the database container of the running example, and wait for a  
sink connector to write rows, without docker exec and the client command  
line of each database.

- **sql**: run statements (heredoc, `--file` or `--sql`) with the database client
- **wait-for-rows**: wait until a table contains N rows

Supported: Oracle (sqlplus), PostgreSQL (psql), MySQL and MariaDB (mysql /  
mariadb), SQL Server (sqlcmd), IBM Db2 (db2) and MongoDB (mongosh).

The database is the only running container whose image is one of them  
(oracle, postgres, mysql, sqlserver, mongodb, ibmdb2... in the examples):  
pass `--container` when there are several, and `--engine` when the image name  
does not tell which database it is.

The user, password and database come from the environment variables of the  
container (`POSTGRES_USER`, `MYSQL_ROOT_PASSWORD`, `SA_PASSWORD`, `ORACLE_PWD`,  
`MONGO_INITDB_ROOT_USERNAME`, `DB2INST1_PASSWORD`...), so most examples need no  
flag: pass `--user`, `--password` and `--database` to connect as another user.

🎓 Tip: in an example script, use 'db wait-for-rows' instead of a fixed  
sleep before checking what a sink connector wrote.

## Usage

```bash
playground db COMMAND
```

## Database commands

- [sql](playground%20db%20sql) - 🛢️ Run SQL statements with the client of the database
- [wait-for-rows](playground%20db%20wait-for-rows) - ⏳ Wait for a table to contain a minimum number of rows


