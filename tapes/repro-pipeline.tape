# 🔗 Build a pipeline: a source example followed by a sink example, on the same topic
Output docs/videos/repro-pipeline.mp4
Source tapes/settings.tape
Source tapes/prelude.tape

Hide
Type "rm -rf reproduction-models/connect-connect-debezium-postgresql-source && clear"
Enter
Sleep 1s
Show

Type 'playground repro bootstrap -f "$PWD/connect/connect-debezium-postgresql-source/debezium-postgres-source.sh" --pipeline "$PWD/connect/connect-elasticsearch-sink/elasticsearch-sink.sh" -d "cdc to elastic" --no-run'
Sleep 500ms
Enter
Wait /❯\s*$/
Sleep 4s
Type 'grep -nE "create-or-update|\"topics\"|topic consume" reproduction-models/connect-connect-debezium-postgresql-source/debezium-postgres-source-repro-cdc-to-elastic.sh'
Sleep 500ms
Enter
Sleep 6s

Hide
Type "rm -rf reproduction-models/connect-connect-debezium-postgresql-source"
Enter
