# playground ksqldb

🧮 ksqlDB commands

Run ksqlDB statements and inspect the streams, tables and queries of the  
ksqlDB server started with `playground run --enable-ksqldb` (the ksqldb/  
examples enable it), without docker exec or curl.

- **sql**: run ksqlDB statements (stdin or `--file`) with the ksql cli
- **list**: streams, tables and persistent queries with their state
- **describe**: fields, queries, statistics, errors and lag of a stream or table
- **wait**: wait until the persistent queries are RUNNING and have no lag

🎓 Tip: the REST API of ksqldb-server is published on http://localhost:8088.  
The records that fail a query are in the `KSQL_PROCESSING_LOG` stream.

## Usage

```bash
playground ksqldb COMMAND
```

## ksqlDB commands

- [sql](playground%20ksqldb%20sql) - 🧮 Run ksqlDB statements with the ksql cli
- [list](playground%20ksqldb%20list) - 📋 List the streams, tables and persistent queries
- [describe](playground%20ksqldb%20describe) - 🔎 Describe a stream or a table
- [wait](playground%20ksqldb%20wait) - ⏳ Wait until the persistent queries are RUNNING and have no lag


