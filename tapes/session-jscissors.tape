# 🎓 Bite size session: what does the code do, call by call? jscissors on a running connector: the records a sink drops
# without a word, then the call a stuck task is hanging in, with its batch (narrated with comments typed in the terminal)
# each command that prints a lot keeps its output in /tmp/out.log and shows a few lines: the vhs terminal (ttyd flow
# control) stops updating after a burst of a few dozen lines
# off camera (scripts/generate-session-videos.sh): the JDBC PostgreSQL sink example (connector postgres-sink, 2 rows in
# the table orders) updated with errors.tolerance=all (no dead letter queue, no errors.log.enable), the avro schema of
# its topic orders in /tmp/orders.avsc, no /tmp/jscissors folder
Output docs/videos/session-jscissors-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# ── 1. the question ─────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: the sink postgres-sink is RUNNING, but orders are missing in the database. Nothing in the logs"
Enter
Sleep 2s
Type@15ms "# jscissors ✂️  loads a java agent in the RUNNING worker and records what the methods you pick receive, return and throw"
Enter
Sleep 2s
Type@15ms "# no restart, no debugger that freezes the worker, no log line to add and no connector to rebuild"
Enter
Sleep 2s
Type@15ms "# ① a record goes from the topic through the converter (avro here), then to the JDBC writer: start with the converter"
Enter
Sleep 1s
Type "playground debug jscissors -c connect --class io.confluent.connect.avro.AvroConverter --method toConnectData --only-failed --action start"
Sleep 800ms
Enter
Wait+Screen@3m /stop it, copy the trace/
Sleep 4s
Type@15ms "# --only-failed: every call is counted, but only the ones that throw are kept with their arguments"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 2. the records that vanish ──────────────────────────────────────────────
Type@15ms "# the customer's producers send 10 orders (off screen). How many rows in postgres? There were 2 before"
Enter
Sleep 1s
Hide
Type `playground topic produce -t orders --nb-messages 4 < /tmp/orders.avsc > /dev/null 2>&1; playground topic produce -t orders --nb-messages 2 --value-format raw --value '{"id": %g, "product": "legacy-app", "quantity": 1, "price": 9.99}' > /dev/null 2>&1; playground topic produce -t orders --nb-messages 4 < /tmp/orders.avsc > /dev/null 2>&1; sleep 8; clear`
Enter
Wait@3m /❯\s*$/
Show
Type `playground container exec -c postgres --command "psql -U myuser -d postgres -tc 'SELECT count(*) FROM orders'" 2>/dev/null | tail -2`
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 3s
Type@15ms "# 10 rows: 2 + 8. Two orders are gone. The task is RUNNING, and the logs?"
Enter
Sleep 1s
Type "playground container logs -c connect --errors --since 5m 2>&1 | tail -1"
Sleep 800ms
Enter
Wait+Screen@1m /no ERROR\/FATAL record found|ERROR/
Sleep 3s
Type@15ms "# not a word: errors.tolerance=all skips the records the converter rejects, and there is no dead letter queue. Stop the trace"
Enter
Sleep 1s
Type "playground debug jscissors -c connect --action stop --output-dir /tmp/jscissors > /tmp/out.log 2>&1; sed -n '/Methods, by total time/,/Findings/p' /tmp/out.log | grep -v Findings | cut -c1-250"
Sleep 800ms
Enter
Wait+Screen@2m /Slowest calls/
Sleep 8s
Type@15ms "# 2 of the 10 calls threw, and here are their arguments: plain JSON bytes on an avro topic. A legacy app writes to orders"
Enter
Sleep 3s
Type@15ms "# the converter's own input, as it received it: no guess, no rebuild, the worker never stopped. The fix is on the producer side"
Enter
Sleep 4s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 3. the task that hangs ──────────────────────────────────────────────────
Type@15ms "# ② another week: the task is RUNNING, the lag grows, still no error. Where does it hang, since when, on which records?"
Enter
Sleep 2s
Type@15ms "# trace the JDBC writer this time: a regex picks several classes and methods"
Enter
Sleep 1s
Type "playground debug jscissors -c connect --class 'io.confluent.connect.jdbc.sink.(JdbcDbWriter|BufferedRecords)' --method 'write|flush' --action start 2>&1 | grep -E 'instrumented|stop it'"
Sleep 800ms
Enter
Wait+Screen@3m /stop it, copy the trace/
Sleep 3s
Type@15ms "# the outage, on purpose: the route from connect to postgres is cut (the block-traffic session shows more), then 3 orders arrive"
Enter
Sleep 1s
Type "playground debug block-traffic -c connect --destination postgres --action start > /dev/null 2>&1"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Hide
Type "playground topic produce -t orders --nb-messages 3 < /tmp/orders.avsc > /dev/null 2>&1; sleep 25; clear"
Enter
Wait@2m /❯\s*$/
Show
Type@15ms "# 30 seconds later, the task still says RUNNING. Stop the trace"
Enter
Sleep 1s
Type "playground debug jscissors -c connect --action stop --output-dir /tmp/jscissors > /tmp/out.log 2>&1; sed -n '/Still running/,/^$/p;/Findings/,/HTML report/p' /tmp/out.log | grep -v '[0-9]:[0-9][0-9] ℹ️' | cut -c1-250"
Sleep 800ms
Enter
Wait+Screen@2m /HIGH/
Sleep 8s
Type@15ms "# JdbcDbWriter.write has been running for half a minute, on the batch that starts at this offset: the 3 orders, still in its hands"
Enter
Sleep 3s
Type@15ms "# a thread dump says WHERE a thread waits. jscissors adds SINCE WHEN, and WITH WHICH DATA. Next step: the thread dump it suggests"
Enter
Sleep 4s
Hide
Type "playground debug block-traffic -c connect --destination postgres --action stop > /dev/null 2>&1; clear"
Enter
Wait@1m /❯\s*$/
Show

# ── 4. more ─────────────────────────────────────────────────────────────────
Type@15ms "# 💡 --slower-than 500ms: only the slow calls with their details. --operation EXCEPTION_THREADS: a thread dump at each exception"
Enter
Sleep 2s
Type@15ms "# 💡 --duration 60s: start, wait, stop and analyze in one command. --restart: trace the startup too. --config-file: one rule per class"
Enter
Sleep 2s
Type@15ms "# 💡 trace the concrete class (not an interface), and keep it narrow: each call costs a few µs plus the toString() of its arguments"
Enter
Sleep 2s
Type@15ms "# 💡 passwords and tokens are masked, record values are not: read the report before you share it. Here it is 👇"
Enter
Sleep 2s
Type@15ms "# 📚 playground debug jscissors --help, playground analyze jscissors --sample filestream_sink_bad_json"
Enter
Sleep 5s
