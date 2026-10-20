# 🎓 Bite size session: an Oracle XStream CDC connector lags or is RUNNING but idle, analyze the orclcdc_diag report (narrated with comments typed in the terminal)
# the end of the session (a scroll through the HTML report) is added by scripts/generate-session-videos.sh
Output docs/videos/session-oracle-xstream-report-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# ── 1. the symptom ──────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: the Oracle XStream CDC source is RUNNING, but no change comes in, or it lags"
Enter
Sleep 2s
Type@15ms "# The answer is on the database side: capture, LogMiner, outbound server, streams pool, archived logs"
Enter
Sleep 2s
Type@15ms "# The customer runs orclcdc_diag.sql (from the connector docs) and sends orclcdc_diag_<date>.html: hundreds of tables"
Enter
Sleep 3s

# ── 2. the ways to run it ───────────────────────────────────────────────────
Type@15ms "# ① on the report of a customer, with the symptom and since when (repeat -f to compare two reports)"
Enter
Type@15ms "#    playground analyze oracle-xstream-report -f orclcdc_diag_<date>.html -p 'no change since 9:10'"
Enter
Sleep 2s
Type@15ms "# ② on the playground XStream example: runs orclcdc_diag.sql in the oracle container"
Enter
Type@15ms "#    playground analyze oracle-xstream-report -c oracle"
Enter
Sleep 2s
Type@15ms "# ③ on a sample shipped with the playground: a report full of failures, no Oracle needed, try it now 👇"
Enter
Sleep 2s

Type "playground analyze oracle-xstream-report --sample synthetic_failures --output-dir /tmp/xstream | less -R"
Sleep 800ms
Enter

# ── 3. the digest, page by page ─────────────────────────────────────────────
# page 1: database, overall health, prerequisites, capture, outbound server
Sleep 16s
Type " "
# page 2: findings, with the section of the report and the SQL to fix it
Sleep 14s
Type " "
# page 3: the rest of the findings, matched patterns
Sleep 9s
Type "q"
Sleep 500ms
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 4. what it found ────────────────────────────────────────────────────────
Type@15ms "# What it found: 🔴 CRITICAL overall, most severe first"
Enter
Sleep 1s
Type@15ms "# 🔴 capture CAP$_XOUT_1 is ABORTED: ORA-01291 missing logfile => restore the archived log, then START_CAPTURE"
Enter
Sleep 3s
Type@15ms "# 🔴 NOARCHIVELOG and no minimal supplemental logging: XStream prerequisites, the SQL to fix them is printed"
Enter
Sleep 3s
Type@15ms "# 🔴 LogMiner uses 97% of its memory, 🟠 Oracle estimates 5,000 spills at a 64 MB streams pool => 96 MB"
Enter
Sleep 3s
Type@15ms "# 🟠 capture PAUSED FOR FLOW CONTROL: the outbound server / the connector does not consume fast enough"
Enter
Sleep 3s
Type@15ms "# 🧩 each finding is matched to a known root-cause pattern (A undersized pool, C flow control, H aborted...)"
Enter
Sleep 3s
Type@15ms "# 💡 every value is quoted from the report with its section: check it, and copy the SQL in your answer"
Enter
Sleep 4s

# ── 5. the HTML report ──────────────────────────────────────────────────────
Type@15ms "# 🌐 The HTML report has the findings, the components and the streams pool advice chart. Attach it to the case!"
Enter
Sleep 2s
Type "ls /tmp/xstream"
Sleep 500ms
Enter
Sleep 3s
Type@15ms "# It looks like this 👇"
Enter
Sleep 2s
