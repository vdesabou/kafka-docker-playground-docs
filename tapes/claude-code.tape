# 🤖 Ask Claude Code: it runs the playground commands and explains the root cause
Output docs/videos/claude-code.mp4
Source tapes/settings.tape
Source tapes/prelude.tape

# off camera: the JDBC PostgreSQL sink example, then a record that is not avro, which fails the task
Hide
Type "playground run -f connect/connect-jdbc-postgresql-sink/postgres-sink.sh > /tmp/kdp-video-run.log 2>&1; echo 'this is not avro' | playground topic produce -t orders --nb-messages 1 > /dev/null 2>&1; playground connector wait --connector postgres-sink --state FAILED --max-wait 120 > /dev/null 2>&1; clear"
Enter
Wait@15m /❯\s*$/
Show

Type 'claude "the postgres-sink connector stopped writing to postgres, why? Do not change anything, answer in a few lines"'
Sleep 500ms
Enter
# Claude Code prints "<verb> for 15s · done 4:38 PM" when it has answered
Wait+Screen@5m /· done [0-9]/
Sleep 8s
