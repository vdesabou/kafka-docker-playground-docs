# 🐢 Watch a sink connector catch up with its backlog
Output docs/videos/show-lag.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# off camera: the JDBC PostgreSQL sink example, connect recreated with offsets committed every 5 seconds (60 by default, the lag
# would not move in between; the example is passed as $0, relative like utils.sh expects, so that it stays the test file in playground.ini),
# then a backlog of 5M records (the sink writes a few 100k records per second) produced while the connector is paused
Hide
Type `playground run -f connect/connect-jdbc-postgresql-sink/postgres-sink.sh > /tmp/kdp-video-run.log 2>&1; printf 'services:\n  connect:\n    environment:\n      CONNECT_OFFSET_FLUSH_INTERVAL_MS: "5000"\n' > /tmp/kdp-video-flush.yml; bash -c "$(playground state get run.docker_command | sed 's#up -d#-f /tmp/kdp-video-flush.yml up -d#')" connect/connect-jdbc-postgresql-sink/postgres-sink.sh > /dev/null 2>&1; playground container wait-for-connect-rest-api-ready > /dev/null 2>&1; playground connector wait --connector postgres-sink --max-wait 120 > /dev/null 2>&1; playground connector pause --connector postgres-sink > /dev/null 2>&1; playground connector wait --connector postgres-sink --state PAUSED --max-wait 60 > /dev/null 2>&1; sleep 10; printf '{"type":"record","name":"myrecord","fields":[{"name":"id","type":"int"},{"name":"product","type":"string"},{"name":"quantity","type":"int"},{"name":"price","type":"float"}]}' | playground topic produce -t orders --nb-messages 5000000 > /dev/null 2>&1; clear`
Enter
Wait@15m /❯\s*$/
Show

Type "playground connector resume --connector postgres-sink"
Sleep 500ms
Enter
Wait /❯\s*$/
Sleep 1s
Type "playground connector show-lag --connector postgres-sink --interval 2"
Sleep 500ms
Enter
Wait@10m /❯\s*$/
Sleep 6s
