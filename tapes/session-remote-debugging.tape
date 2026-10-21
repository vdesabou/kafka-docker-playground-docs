# 🎓 Bite size session: remote debugging, a breakpoint in a running connector (narrated with comments typed in the terminal)
# off camera (scripts/generate-session-videos.sh): the JDBC PostgreSQL sink example, and the avro schema of its orders
# topic in /tmp/orders.avsc
# the end of the session (the same in Visual Studio Code, screenshots of the docs) is added by scripts/generate-session-videos.sh
Output docs/videos/session-remote-debugging-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# ── 1. the idea ─────────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: logs are not enough, you want to see what the connector does with a record => remote debugging"
Enter
Sleep 2s
Type@15ms "# The connect container always listens for a java debugger on port 5005 (KAFKA_DEBUG, JAVA_DEBUG_OPTS): nothing to enable"
Enter
Sleep 2s
Type@15ms "# (other containers: playground debug enable-remote-debugging -c broker, it also prints the launch.json of VS Code)"
Enter
Sleep 3s

# ── 2. the code at the right version ────────────────────────────────────────
Type@15ms "# ① a breakpoint only makes sense in the code of the version that runs: which one?"
Enter
Sleep 1s
Type "playground connector versions 2> /dev/null | tail -3"
Sleep 800ms
Enter
Wait+Screen@1m /Version currently used for confluentinc/
Sleep 4s
Type@15ms "# ② its code at that tag, and the line to stop at: where the JDBC sink writes the records to the database"
Enter
Sleep 1s
Type "playground connector-plugin sourcecode -c confluentinc/kafka-connect-jdbc --connector-tag 10.9.9 --checkout-only 2> /dev/null | tail -1"
Sleep 800ms
Enter
Wait+Screen@2m /kafka-connect-jdbc-10\.9\.9/
Sleep 2s
Type "grep -n 'writer.write(records)' /tmp/connector-plugin-sourcecode/kafka-connect-jdbc-10.9.9/src/main/java/io/confluent/connect/jdbc/sink/JdbcSinkTask.java"
Sleep 800ms
Enter
Sleep 4s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 3. attach, break, inspect ───────────────────────────────────────────────
Type@15ms "# ③ in another terminal you would produce a record; here it runs in the background, in 25 s"
Enter
Sleep 1s
Type "(sleep 25; playground topic produce -t orders --nb-messages 1 < /tmp/orders.avsc > /dev/null 2>&1) &"
Sleep 800ms
Enter
Sleep 1s
Type@15ms "# ④ attach jdb (the debugger of the JDK) to localhost:5005, with the source code to show the lines"
Enter
Sleep 1s
Type "jdb -attach localhost:5005 -sourcepath /tmp/connector-plugin-sourcecode/kafka-connect-jdbc-10.9.9/src/main/java"
Sleep 800ms
Enter
Wait+Screen@1m /Initializing jdb/
Sleep 2s
Type "stop at io.confluent.connect.jdbc.sink.JdbcSinkTask:87"
Sleep 800ms
Enter
Wait+Screen@2m /Breakpoint hit/
Sleep 4s
Type "where"
Sleep 800ms
Enter
Sleep 6s
Type "list"
Sleep 800ms
Enter
Sleep 5s
Type "locals"
Sleep 800ms
Enter
Sleep 4s
Type "print first.value()"
Sleep 800ms
Enter
Sleep 5s
Type "clear io.confluent.connect.jdbc.sink.JdbcSinkTask:87"
Sleep 800ms
Enter
Sleep 1s
Type "cont"
Sleep 800ms
Enter
Sleep 2s
Type "exit"
Sleep 800ms
Enter
Sleep 2s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 4. what we saw ──────────────────────────────────────────────────────────
Type@15ms "# What we saw:"
Enter
Sleep 1s
Type@15ms "# 🛑 the task thread task-thread-postgres-sink-0 stopped at JdbcSinkTask.put, line 87, before writing to the database"
Enter
Sleep 3s
Type@15ms "# 🧵 where: called by WorkerSinkTask.deliverMessages, the Connect framework that hands the records to the task"
Enter
Sleep 3s
Type@15ms "# 🔎 locals and print: the batch (recordsCount) and the value of the first record, as the connector sees it (a Struct)"
Enter
Sleep 3s
Type@15ms "# ⚠️  'stop at' pauses the whole worker: keep it short (consumer and worker groups), then clear and cont"
Enter
Sleep 3s
Type "playground connector status 2> /dev/null | grep postgres-sink"
Sleep 800ms
Enter
Wait+Screen@1m /RUNNING/
Sleep 3s
Type@15ms "# ✅ the connector goes on: the record is written to postgres"
Enter
Sleep 3s

# ── 5. in your IDE ──────────────────────────────────────────────────────────
Type@15ms "# 🧑‍💻 in VS Code or IntelliJ: open the code at that tag, add an attach configuration on 127.0.0.1:5005, set breakpoints"
Enter
Sleep 3s
Type@15ms "# 📚 step by step: kafka-docker-playground.io => Reproduction toolkit => Remote debugging. The same in VS Code 👇"
Enter
Sleep 3s
