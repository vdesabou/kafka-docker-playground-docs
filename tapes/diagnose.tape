# 🩺 Diagnose a failed connector
Output docs/videos/diagnose.mp4
Output docs/videos/diagnose.gif
Source tapes/settings.tape
Source tapes/prelude.tape

# off camera: the JDBC PostgreSQL sink example, then a record that is not avro, which fails the task
Hide
Type "playground run -f connect/connect-jdbc-postgresql-sink/postgres-sink.sh > /tmp/kdp-video-run.log 2>&1; echo 'this is not avro' | playground topic produce -t orders --nb-messages 1 > /dev/null 2>&1; playground connector wait --connector postgres-sink --state FAILED --max-wait 120 > /dev/null 2>&1; clear"
Enter
Wait@15m /❯\s*$/
Show

Type "# the postgres-sink connector stopped writing, why?"
Enter
Type "playground connector diagnose"
Sleep 500ms
Enter
Wait@3m /❯\s*$/
Sleep 10s
