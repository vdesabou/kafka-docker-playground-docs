# 📜 Turn on DEBUG for a connector, then wait for a log line: here the SQL the JDBC sink runs
Output docs/videos/logs.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# off camera: the JDBC PostgreSQL sink example, and one more record in 25 seconds (once DEBUG is on), so that the sink writes again
Hide
Type `playground run -f connect/connect-jdbc-postgresql-sink/postgres-sink.sh > /tmp/kdp-video-run.log 2>&1; ( ( sleep 25; printf '{"type":"record","name":"myrecord","fields":[{"name":"id","type":"int"},{"name":"product","type":"string"},{"name":"quantity","type":"int"},{"name":"price","type":"float"}]}' | playground topic produce -t orders --nb-messages 1 --forced-value '{"id":3,"product":"bar","quantity":5,"price":1.5}' ) > /dev/null 2>&1 & ); clear`
Enter
Wait@15m /❯\s*$/
Show

Type "playground connector log-level --connector postgres-sink --level DEBUG"
Sleep 500ms
Enter
Wait /❯\s*$/
Sleep 2s
Type `playground connector logs --connector postgres-sink --wait-for-log "INSERT sql"`
Sleep 500ms
Enter
Wait@3m /❯\s*$/
Sleep 8s
