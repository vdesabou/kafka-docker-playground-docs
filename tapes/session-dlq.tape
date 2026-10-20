# 🎓 Bite size session: a sink is RUNNING but writes nothing: diagnose it, inspect its dead letter queue, fix, replay (narrated with comments typed in the terminal)
# off camera (scripts/generate-session-videos.sh): the reprocess-dlq example with schema-registry killed, 10 records in the dlq topic
Output docs/videos/session-dlq-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# ── 1. the symptom ──────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: the filestream-sink connector is RUNNING, no error in its status, but the file stays empty"
Enter
Sleep 2s
Type "playground container exec -c connect --command 'wc -l /tmp/output.json'"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 3s
Type@15ms "# 0 lines. First reflex, one command: status, error digest, progress and next steps"
Enter
Sleep 1s
Type "playground connector diagnose"
Sleep 800ms
Enter
Wait@3m /❯\s*$/
Sleep 4s
# scroll back to the error digest
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 2. reading the diagnosis ────────────────────────────────────────────────
Type@15ms "# What diagnose said:"
Enter
Sleep 1s
Type@15ms "# 🗺️  status RUNNING, 🐢 lag 0: the connector read all 10 records... and wrote none of them"
Enter
Sleep 3s
Type@15ms "# 🔥 ERROR x10 in stage VALUE_CONVERTER (AvroConverter): UnknownHostException: schema-registry"
Enter
Sleep 3s
Type@15ms "# errors.tolerance=all: the task does not fail, each bad record goes to the dead letter queue instead. Let's look at it 👇"
Enter
Sleep 3s

# ── 3. inspect the DLQ ──────────────────────────────────────────────────────
Type "playground topic dlq inspect --connector filestream-sink"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 8s
Type@15ms "# 🔢 records grouped by error: stage, exception, 🌱 root cause, 📍 original topic / partition / offsets"
Enter
Sleep 3s
Type@15ms "# here 1 group: the 10 records failed only because schema-registry was not reachable => the data is fine"
Enter
Sleep 3s
Type@15ms "# (--grep to filter, --json for scripts; with real poison pills, fix the producer instead of replaying)"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 4. fix the cause, then replay ───────────────────────────────────────────
Type@15ms "# Fix the cause: bring schema-registry back"
Enter
Sleep 1s
Type "playground container restart -c schema-registry"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 8s
Type@15ms "# Replay the DLQ records to their original topic (from the __connect.errors.topic header), dry run first"
Enter
Sleep 1s
Type "playground topic dlq replay --connector filestream-sink --dry-run"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 4s
Type "playground topic dlq replay --connector filestream-sink"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 4s
Type@15ms "# The sink reads them again from its topic: wait for its lag to reach 0"
Enter
Sleep 1s
Type "playground connector show-lag --connector filestream-sink --max-wait 120"
Sleep 800ms
Enter
Sleep 6s
# the lag takes about a minute to reach 0: cut it
Hide
Wait@3m /❯\s*$/
Show
Sleep 3s
Type "playground container exec -c connect --command 'wc -l /tmp/output.json'"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 3s
Type@15ms "# ✅ 10 lines: every record is written, none went back to the DLQ (dlq inspect again to check)"
Enter
Sleep 3s
Type@15ms "# 💡 replay elsewhere with --to <topic>; a DLQ of a fully managed connector works the same way"
Enter
Sleep 5s
