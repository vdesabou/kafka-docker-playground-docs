# ✅ A customer config: validate it without creating anything, then diff it with the connector of the example
Output docs/videos/validate-diff.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# off camera: the JDBC PostgreSQL sink example, and a "customer" config with a typo and a few changes
Hide
Type `playground run -f connect/connect-jdbc-postgresql-sink/postgres-sink.sh > /tmp/kdp-video-run.log 2>&1; printf '{\n  "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",\n  "tasks.max": "4",\n  "connection.url": "jdbc:postgresql://postgres/postgres?user=myuser&password=mypassword&ssl=false",\n  "topics": "orders",\n  "auto.create": "true",\n  "insert.mode": "upsrt",\n  "pk.mode": "record_value",\n  "pk.fields": "id"\n}\n' > /tmp/customer-config.json; clear`
Enter
Wait@15m /❯\s*$/
Show

Type "cat /tmp/customer-config.json"
Sleep 500ms
Enter
Sleep 4s
Type "playground connector validate < /tmp/customer-config.json"
Sleep 500ms
Enter
Wait@2m /❯\s*$/
Sleep 4s
Type "playground connector diff --connector postgres-sink --file /tmp/customer-config.json"
Sleep 500ms
Enter
Wait@2m /❯\s*$/
Sleep 8s

Hide
Type "rm -f /tmp/customer-config.json"
Enter
