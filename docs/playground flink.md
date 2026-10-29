# playground flink

🐿️ Flink commands

Run Flink SQL and manage the jobs of the Flink cluster started with  
`playground run --enable-flink` (jobmanager REST API on port 18081).

- **sql**: run Flink SQL statements (stdin or `--file`) with the SQL client
- **list-jobs**: jobs of the cluster with their state, start time and duration
- **cancel**: cancel a job, or all running jobs

🎓 Tip: the Flink UI is served on the same port as the REST API:  
http://localhost:18081. See the flink/flink-sql-kafka example.

## Usage

```bash
playground flink COMMAND
```

## Flink commands

- [sql](playground%20flink%20sql) - 🐿️ Run Flink SQL statements with the SQL client
- [list-jobs](playground%20flink%20list-jobs) - 📋 List the jobs of the Flink cluster
- [cancel](playground%20flink%20cancel) - 🛑 Cancel a Flink job


