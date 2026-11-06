# 🎓 Bite size session: did the fix work? Analyze the logs before and after it (narrated with comments typed in the terminal)
# the end of the session (a scroll through the HTML report of the comparison) is added by scripts/generate-session-videos.sh
# off camera, setup_analyze_logs writes /tmp/partial.log.gz: a log gzipped then cut at 2 KB, a download that stopped
Output docs/videos/session-analyze-logs-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# ── 1. the situation ────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: the customer applied a fix and sent the logs of the worker, the day before and the day after"
Enter
Sleep 2s
Type@15ms "# Did it work? Reading two log files side by side is long and you miss what moved: let analyze logs compare them"
Enter
Sleep 2s
Type@15ms "#    playground analyze logs -f <after> --compare <before>     (a file, a folder, a .zip / .tar.gz, or a JSON of --json)"
Enter
Sleep 2s
Type@15ms "# On the sample shipped with the playground: the log of a Connect worker the day after a fix, against the day before 👇"
Enter
Sleep 2s

Type "playground analyze logs --sample compare_fix --output-dir /tmp/analyze-logs 2>&1 | sed -n '/🧭 Summary/,$p' | less -R"
Sleep 800ms
Enter

# ── 2. the summary, page by page ────────────────────────────────────────────
# page 1: summary, period, connectors, known causes with what to do
Sleep 12s
Type " "
# page 2: root causes, 🔁 comparison, 🗓️ timeline, 🔌 connectors
Sleep 16s
Type "q"
Sleep 500ms
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 3. what it found ────────────────────────────────────────────────────────
Type@15ms "# What the comparison says:"
Enter
Sleep 1s
Type@15ms "# ✅ gone      the fenced producer, the S3 throttling, the topic policy error => the fix did its job for those"
Enter
Sleep 3s
Type@15ms "# 🆕 new       a JDBC SQLRecoverableException (Connection reset by peer) => a new problem, not there the day before"
Enter
Sleep 3s
Type@15ms "# 📈 growing   the offset commit failed in a rebalance 7 times instead of once => the sink is still unstable"
Enter
Sleep 3s
Type@15ms "# 👉 not done yet. Two days of different lengths? The counts are compared per hour, with the rates"
Enter
Sleep 3s
Type@15ms "# 🗓️ the timeline says what came first, all files merged, and each 🔌 connector has its card: errors, task killed, config changed"
Enter
Sleep 4s

# ── 4. the trap: a download that stopped ────────────────────────────────────
Hide
Type "clear"
Enter
Sleep 300ms
Show
Type@15ms "# ⚠️ No error found is not always good news: this .gz stopped downloading after 2 KB 👇"
Enter
Sleep 2s
Type "playground analyze logs -f /tmp/partial.log.gz --output-dir /tmp/analyze-logs-partial 2>&1 | grep -E '⚠️|•'"
Sleep 800ms
Enter
Sleep 6s
Type@15ms "# The error is in the part that was not received: ask for a complete copy instead of answering 'the logs are clean'"
Enter
Sleep 4s

# ── 5. for scripts and agents ───────────────────────────────────────────────
Type@15ms "# 🤖 The same analysis as JSON, for a script or an agent:"
Enter
Sleep 1s
Type "playground analyze logs --sample compare_fix --json 2>/dev/null | jq -c '.comparison.counts'"
Sleep 800ms
Enter
Sleep 6s

# ── 6. the HTML report ──────────────────────────────────────────────────────
Type@15ms "# 🌐 The HTML report: the 🔁 comparison linked to each root cause, the timeline, the cards, filters kept in the URL. 📤 Share it!"
Enter
Sleep 2s
Type@15ms "# It looks like this 👇"
Enter
Sleep 2s
