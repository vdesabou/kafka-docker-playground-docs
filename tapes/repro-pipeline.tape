# 🔗 Build a pipeline: a source example followed by a sink example, the records of the source go through the sink
Output docs/videos/repro-pipeline.mp4
Source tapes/settings.tape
Source tapes/prelude.tape

Hide
Type "rm -rf reproduction-models/connect-connect-debezium-mysql-source && clear"
Enter
Sleep 1s
Show

Type 'playground repro bootstrap -f "$PWD/connect/connect-debezium-mysql-source/debezium-mysql-source.sh" --pipeline "$PWD/connect/connect-jdbc-postgresql-sink/postgres-sink.sh" -d "cdc to postgres" --no-run'
Sleep 500ms
Enter
Wait /❯\s*$/
Sleep 6s
Type "clear"
Enter
Type `grep -nE '^# 🔗 pipeline: connect|^playground connector create-or-update|"topics"|"transforms.unwrap.type"|^playground connector show-lag|--container (mysql|postgres)|^set .e$' reproduction-models/connect-connect-debezium-mysql-source/debezium-mysql-source-repro-cdc-to-postgres.sh`
Sleep 500ms
Enter
Sleep 8s

Hide
Type "rm -rf reproduction-models/connect-connect-debezium-mysql-source"
Enter
