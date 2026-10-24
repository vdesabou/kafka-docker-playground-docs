# 🎓 Bite size session: a connector failed: the error digest of the live logs (--errors), --grep --no-follow, --wait-for-log, then the same digest offline on a customer bundle with analyze logs (narrated with comments typed in the terminal)
# each command that prints a lot keeps its output in /tmp/out.log or is filtered: the vhs terminal (ttyd flow control)
# stops updating after a burst of a few dozen lines
# off camera (scripts/generate-session-videos.sh): the FileStream sink example (connector filestream-sink, 5 plain JSON
# records in topic filestream) and the connector bad-sink of the deep dive lab: an AvroConverter on those JSON records,
# its task FAILED
Output docs/videos/session-container-logs-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# ── 1. the symptom ──────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: the customer says the sink bad-sink stopped writing. The answer is in the worker log... among thousands of lines"
Enter
Sleep 2s
Type "playground connector status 2>&1 | grep -m1 '^bad-sink' | cut -c1-150"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 4s
Type@15ms "# the task is FAILED, and its stack trace is squeezed on one line. Let the playground read the log instead"
Enter
Sleep 2s
Type@15ms "# ① --errors: a digest of the ERROR/FATAL records only, --since to keep the recent ones. It never follows: the prompt comes back"
Enter
Sleep 2s
Type "playground container logs -c connect --errors --since 10m 2>&1 | cut -c1-150"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 8s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 2. reading the digest ───────────────────────────────────────────────────
Type@15ms "# What the digest said:"
Enter
Sleep 1s
Type@15ms "# 🔴 one finding: the record, its chain of 'Caused by:' and 3 frames of the deepest cause. Read the LAST 'Caused by:' first"
Enter
Sleep 3s
Type@15ms "# Caused by: java.lang.IllegalArgumentException: Unknown magic byte! => the AvroConverter reads records that are not Avro"
Enter
Sleep 3s
Type@15ms "# Does a restart fix it?"
Enter
Sleep 1s
Type "playground connector restart --connector bad-sink > /dev/null 2>&1; playground connector wait --connector bad-sink --state FAILED --max-wait 120 > /tmp/out.log 2>&1; grep 'is FAILED after' /tmp/out.log"
Sleep 800ms
Enter
Wait+Screen@3m /is FAILED after/
Sleep 3s
# the second failure can take a few seconds to be logged: wait for it off camera
Hide
Type "for i in $(seq 24); do playground container logs -c connect --errors --since 10m 2>&1 | grep -q 'ERROR x2' && break; sleep 5; done"
Enter
Wait@3m /❯\s*$/
Type "clear"
Enter
Sleep 300ms
Show

# ── 3. counts, then the raw lines ───────────────────────────────────────────
Type@15ms "# No: FAILED again. The digest again, only the header and first line of each finding this time"
Enter
Sleep 1s
Type "playground container logs -c connect --errors --since 10m 2>&1 | grep -A1 'ERROR x' | cut -c1-150"
Sleep 800ms
Enter
Wait+Screen@2m /ERROR x2/
Sleep 5s
Type@15ms "# ERROR x2: the same failure after the restart is ONE finding, counted. First / last seen line: once at startup, or until now?"
Enter
Sleep 3s
Type@15ms "# ② the raw lines: --grep keeps only the matching lines (no stack trace around them), --no-follow gives the prompt back"
Enter
Sleep 2s
Type "playground container logs -c connect --grep 'Unknown magic byte' --no-follow | cut -c1-150"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 4s
Type@15ms "# ⚠️  the trap: without --no-follow, --grep and --since keep following the log, forever. In scripts: --no-follow, --errors or --wait-for-log"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 4. waiting for a line ───────────────────────────────────────────────────
Type@15ms "# ③ in a repro, wait for a log line instead of a sleep: --wait-for-log, at most --max-wait seconds, exit 1 otherwise"
Enter
Sleep 2s
Type "playground container logs -c connect --wait-for-log 'Unknown magic byte' --max-wait 30 > /tmp/out.log 2>&1; echo exit=$?; sed -n '1p;$p' /tmp/out.log"
Sleep 800ms
Enter
Wait+Screen@2m /log is there|do not show/
Sleep 4s
Type@15ms "# exit=0 at once: it searches the WHOLE log, old lines included. Wait for something specific to THIS run (a connector name, an id)"
Enter
Sleep 3s
Type@15ms "# it checks every 10 s; still not there after --max-wait: exit 1, and a hint"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 5. offline: a customer bundle ───────────────────────────────────────────
Type@15ms "# ④ no running container, the customer sent a support bundle: analyze logs, the same digest offline (file, folder, .zip, .tar.gz, .gz)"
Enter
Sleep 2s
Type@15ms "# --sample support_bundle: a .zip shipped with the playground, a Connect log and a gzipped broker log"
Enter
Sleep 1s
Type "playground analyze logs --sample support_bundle > /tmp/out.log 2>&1; grep -E 'digest for|🔎|^.2026-|ORA-01017|📊' /tmp/out.log | cut -c1-160"
Sleep 800ms
Enter
Wait+Screen@2m /file\(s\) with findings/
Sleep 8s
Type@15ms "# one digest per file, named with its path in the archive, only the files with findings: 2 scanned, the Connect log has 6 ERRORs"
Enter
Sleep 3s
Type@15ms "# in order of first seen: ORA-01017 wrong password, outbound server XOUT_MISSING not valid... and at the end the task killed"
Enter
Sleep 3s
Type@15ms "# nothing in the broker log? --include-warnings adds the WARN records, --max-findings bounds each file"
Enter
Sleep 1s
Type "playground analyze logs --sample support_bundle --include-warnings --max-findings 3 > /tmp/out.log 2>&1; grep -E 'digest for|🔎|WARN x|✂️|📊' /tmp/out.log | cut -c1-160"
Sleep 800ms
Enter
Wait+Screen@2m /file\(s\) with findings/
Sleep 6s
Type@15ms "# the broker: 1 record, WARN x24, noise. The Connect log: 12 records with the WARNs, 9 not shown. The answer stays in the Connect log"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 6. the fix, and more ────────────────────────────────────────────────────
Type@15ms "# Back to bad-sink: the topic holds plain JSON. The fix is the converter: value.converter=org.apache.kafka.connect.json.JsonConverter"
Enter
Sleep 3s
Type@15ms "# 💡 --errors (--since, --include-warnings, --max-findings) for what went wrong, --no-follow --tail N for raw lines, --wait-for-log in scripts"
Enter
Sleep 2s
Type@15ms "# 💡 --errors and analyze logs exit 0 even with findings: a reading aid, not an assertion. A bundle is untrusted: read it, run nothing from it"
Enter
Sleep 2s
Type@15ms "# 📚 playground container logs --help, playground analyze logs --help"
Enter
Sleep 5s
