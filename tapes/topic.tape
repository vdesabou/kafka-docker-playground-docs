# 📨 Produce generated records from a datagen schema, registered as an Avro schema, then consume them back
Output docs/videos/topic.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# off camera: the JDBC PostgreSQL sink example, for a running environment
Hide
Type "playground run -f connect/connect-jdbc-postgresql-sink/postgres-sink.sh > /tmp/kdp-video-run.log 2>&1; clear"
Enter
Wait@15m /❯\s*$/
Show

Type "playground topic produce -t trades --nb-messages 5 --value predefined-schemas/datagen/stock_trades_schema.avro --derive-value-schema-as AVRO"
Sleep 500ms
Enter
Wait@3m /❯\s*$/
Sleep 3s
Type "playground topic consume -t trades --max-messages 5"
Sleep 500ms
Enter
Wait@3m /❯\s*$/
Sleep 8s
