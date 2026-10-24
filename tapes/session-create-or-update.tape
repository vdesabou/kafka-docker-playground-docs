# 🎓 Bite size session: "our sink fails right after we deploy it": deploy the customer's config with create-or-update, see the
# wait catch the failed task, reproduce the failure on purpose, fix and update in place (narrated with comments typed in the terminal)
# each command that prints a lot keeps its output in /tmp/out.log and shows a few lines: the vhs terminal (ttyd flow
# control) stops updating after a burst of a few dozen lines (create-or-update prints the config and its parameters)
# off camera (scripts/generate-session-videos.sh): the FileStream sink example (connector filestream-sink, 5 records in the
# topic filestream), the customer's config in the REST API format in /tmp/customer-connector.json (a file path in a folder
# that does not exist in the connect container) and the same config fixed in /tmp/customer-connector-fixed.json
Output docs/videos/session-create-or-update-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# ── 1. the symptom ──────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: a customer sends the config of their FileStream sink: 'it fails right after we deploy it'"
Enter
Sleep 2s
Type@15ms "# playground connector create-or-update deploys it, the way every example does. First, the file they sent:"
Enter
Sleep 1s
Type "cat /tmp/customer-connector.json"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 5s
Type@15ms "# the REST API format, what GET /connectors/<name> returns: create-or-update takes it as is, its outer name is ignored"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 2. validate, deploy, and the wait ───────────────────────────────────────
Type@15ms "# ① deploy it as broken-sink. --validate first asks the plugin to check every key at once (types, required keys, values)"
Enter
Sleep 2s
Type `playground connector create-or-update -c broken-sink --validate /tmp/customer-connector.json > /tmp/out.log 2>&1; rc=$?; grep -E '📦|is valid|successfully created|Waiting up|FAILED|Caused by: java|🩺|not RUNNING' /tmp/out.log | cut -c1-160; echo "exit code: $rc"`
Sleep 800ms
Enter
Wait+Screen@3m /exit code: [0-9]+/
Sleep 1s
Sleep 7s
Type@15ms "# 📦 REST API format detected, ✅ the config is valid... and yet the task FAILED: validation does not check paths or hostnames"
Enter
Sleep 3s
Type@15ms "# the wait (up to 120 s, the connector AND its tasks) stops at the first FAILED task, with the stack trace: NoSuchFileException"
Enter
Sleep 3s
Type@15ms "# exit code 1: in an example, the script stops right there instead of failing silently later"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 3. a failure on purpose ─────────────────────────────────────────────────
Type@15ms "# ② in a reproduction, you often WANT the connector to fail: --no-wait, then connector wait --state FAILED. No sleep"
Enter
Sleep 2s
Type "playground connector delete -c broken-sink > /dev/null 2>&1; playground connector create-or-update -c broken-sink --no-wait /tmp/customer-connector.json > /dev/null 2>&1"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 1s
Type "playground connector wait -c broken-sink --state FAILED --max-wait 60 > /tmp/out.log 2>&1; grep -E 'Waiting up|is FAILED after' /tmp/out.log"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 5s
Type@15ms "# FAILED as soon as one task fails, even when the connector itself is still RUNNING (the usual case)"
Enter
Sleep 3s
Type@15ms "# (in a reproduction model, the default wait only warns and the script goes on: --wait makes it strict there too)"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 4. fix, and update in place ─────────────────────────────────────────────
Type@15ms "# ③ the fix: a folder that exists in our worker. Create and update are the same call: re-run it with the fixed file"
Enter
Sleep 2s
Type@15ms "# --dry-run first: what would change, and the request that would be sent"
Enter
Sleep 1s
Type "playground connector create-or-update -c broken-sink --dry-run /tmp/customer-connector-fixed.json > /tmp/out.log 2>&1; grep -E '🔍|   [~+-] |🌵' /tmp/out.log | cut -c1-150"
Sleep 800ms
Enter
Wait+Screen@2m /request: PUT/
Sleep 1s
Sleep 5s
Type@15ms "# 🔍 only the changed keys (secrets masked), 🌵 nothing is deployed. Now for real:"
Enter
Sleep 1s
Type `playground connector create-or-update -c broken-sink /tmp/customer-connector-fixed.json > /tmp/out.log 2>&1; rc=$?; grep -E '🔄|   [~+-] |Waiting up|is RUNNING' /tmp/out.log | cut -c1-150; echo "exit code: $rc"`
Sleep 800ms
Enter
Wait+Screen@3m /exit code: [0-9]+/
Sleep 1s
Sleep 6s
Type@15ms "# 🔄 updated in place, ✅ RUNNING only when the task is still RUNNING one check later (a task can fail on its first record)"
Enter
Sleep 3s
Type "playground container exec -c connect --command 'wc -l /tmp/customer-output.json'"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 3s
Type@15ms "# ✅ the 5 records of the topic are in the file. Same file, same command: the customer can apply it as is"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 5. recap ────────────────────────────────────────────────────────────────
Type@15ms "# 🧰 Around create-or-update:"
Enter
Sleep 1s
Type@15ms "#   playground connector diff -c <c> --file customer.json   🔀 what differs from the customer's config (--defaults: the noise)"
Enter
Sleep 2s
Type@15ms "#   playground connector validate < cfg.json                🔎 validation only, nothing deployed"
Enter
Sleep 2s
Type@15ms "#   playground connector show-config -c <c>                 🧰 the config as a heredoc, ready for a repro model"
Enter
Sleep 2s
Type@15ms "#   create-or-update --initial-state STOPPED, --level TRACE, --wait-for-zero-lag (a sink: no sleep before checking the data)"
Enter
Sleep 3s
Type@15ms "# 💡 the wait is your assertion: a config that does not run stops the script, with the stack trace, right where it was deployed"
Enter
Sleep 6s
