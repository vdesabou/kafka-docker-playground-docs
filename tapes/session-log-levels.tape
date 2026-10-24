# 🎓 Bite size session: TRACE on a running connector without a restart: debug log-level, connector log-level, back to normal, and what a restart forgets (narrated with comments typed in the terminal)
# each command that prints a lot keeps its output in /tmp/out.log or is filtered: the vhs terminal (ttyd flow control)
# stops updating after a burst of a few dozen lines
# off camera (scripts/generate-session-videos.sh): the FileStream sink example (connector filestream-sink: topic
# filestream to /tmp/output.json in the connect container)
Output docs/videos/session-log-levels-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# ── 1. the question ─────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: the customer asks what the sink filestream-sink really writes, record by record. At INFO, the worker says nothing"
Enter
Sleep 2s
Type@15ms "# log levels change live on the worker (the Connect REST API, /admin/loggers): no restart, no log4j file to edit"
Enter
Sleep 2s
Type "playground debug log-level get --package org.apache.kafka.connect.file"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 4s
Type@15ms "# 404 'Logger not found': the package has no level of its own, it logs at the level inherited from root, INFO"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 2. TRACE on one package ─────────────────────────────────────────────────
Type@15ms "# ① TRACE on the package of the connector class (org.apache.kafka.connect.file.FileStreamSinkConnector), and everything below it"
Enter
Sleep 2s
Type "playground debug log-level set --package org.apache.kafka.connect.file --level TRACE"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 4s
Type@15ms "# scope=cluster: on CP 7.7+, every worker of the Connect cluster applies it. Then the level is read back: TRACE"
Enter
Sleep 3s
Type@15ms "# reproduce: 3 new records, and wait for the log line of the third one"
Enter
Sleep 1s
Type `playground topic produce -t filestream --nb-messages 3 --value '{"lab": %g}' > /dev/null 2>&1; playground container logs -c connect --wait-for-log 'lab=3' --max-wait 60 > /dev/null 2>&1`
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 1s
Type "playground container logs -c connect --grep 'Writing line' --no-follow | cut -c1-160"
Sleep 800ms
Enter
Wait+Screen@1m /lab=3/
Sleep 5s
Type@15ms "# one TRACE line per record, with its value. The logger name is at the end of each line, in parentheses: copy it from there"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 3. the connector's loggers in one call ──────────────────────────────────
Type@15ms "# ② not sure which packages? connector log-level picks them: the package of connector.class + 3 runtime loggers"
Enter
Sleep 2s
Type "playground connector log-level --connector filestream-sink --level TRACE 2>&1 | grep -E 'also setting|Set log level|Skipping'"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 6s
Type@15ms "# RestService: each schema registry request. TransformationChain: each record before and after every SMT. WorkerSinkTask: polls, commits"
Enter
Sleep 3s
Type@15ms "# org.apache.kafka.connect.file was already at TRACE: skipped. Shared libraries (storage, http clients) need a debug log-level set of their own"
Enter
Sleep 3s
Type@15ms "# ⚠️  at TRACE, records and schemas end up in the log: check it before you share it"
Enter
Sleep 3s
Type@15ms "# ③ found it? back to normal: --level INFO (there is no reset, the loggers stay listed, at INFO)"
Enter
Sleep 2s
Type "playground connector log-level --connector filestream-sink --level INFO 2>&1 | grep 'Set log level'"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 5s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 4. what a restart forgets ───────────────────────────────────────────────
Type@15ms "# ④ the trap: nothing is persisted. TRACE again, then a restart of the worker"
Enter
Sleep 2s
Type "playground debug log-level set --package org.apache.kafka.connect.file --level TRACE > /dev/null 2>&1; playground container restart -c connect > /dev/null 2>&1"
Sleep 800ms
Enter
Sleep 3s
# the restart and the connector start take about a minute: cut it
Hide
Wait@5m /❯\s*$/
Type "playground connector wait --connector filestream-sink --max-wait 180 > /dev/null 2>&1"
Enter
Wait@5m /❯\s*$/
Type "clear"
Enter
Sleep 300ms
Show
Type@15ms "# connect restarted, filestream-sink is RUNNING again. The level of the package?"
Enter
Sleep 1s
Type "playground debug log-level get --package org.apache.kafka.connect.file"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 4s
Type@15ms "# 404 again: the TRACE is gone. Restart, recreate, crash, CFK pod restart: the worker starts with the levels of its configuration"
Enter
Sleep 3s
Type@15ms "# levels that must survive a restart: CONNECT_LOG4J_LOGGERS in the docker compose override of the example (keep its default entries)"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 5. more ─────────────────────────────────────────────────────────────────
Type@15ms "# 💡 the first lines of a task: playground run -f <example> --connect-log-level 'io.confluent.connect.jdbc=TRACE' sets them before the connector exists"
Enter
Sleep 2s
Type@15ms "# 💡 create-or-update --level TRACE right after a deploy. 4 levels: INFO, WARN (to silence a noisy logger), DEBUG, TRACE"
Enter
Sleep 2s
Type@15ms "# 💡 a package name is not checked: a typo is accepted and logs nothing. Only the Connect worker: not the broker, not schema registry"
Enter
Sleep 2s
Type@15ms "# 📚 playground debug log-level --help, playground connector log-level --help"
Enter
Sleep 5s
