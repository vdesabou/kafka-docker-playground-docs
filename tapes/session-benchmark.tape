# 🎓 Bite size session: is version Y of a connector slower? Benchmark two versions (narrated with comments typed in the terminal)
# off camera (scripts/generate-session-videos.sh): the JDBC PostgreSQL sink example
# the end of the session (a scroll through the HTML report) is added by scripts/generate-session-videos.sh
Output docs/videos/session-benchmark-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# ── 1. the question ─────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: since the upgrade, the JDBC sink feels slower. Is the new version slower, and by how much?"
Enter
Sleep 2s
Type@15ms "# connector benchmark measures it on the example you run: no load script to write for a sink, it replays its producer"
Enter
Sleep 2s
Type "playground connector status"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 2. how it measures ──────────────────────────────────────────────────────
Type@15ms "# drain mode (default): pause the connector, load a backlog of --nb-records, resume it, time how long it takes to drain"
Enter
Sleep 3s
Type@15ms "# two --connector-tag: for each version, switch the plugin, a warm-up drain, the measured drain, then the comparison"
Enter
Sleep 3s
Type@15ms "# (the original version is restored at the end; --rounds 2 to repeat, --mode steady for a throughput over --duration)"
Enter
Sleep 2s
Type "playground connector benchmark --nb-records 3000000 --connector-tag 10.8.4 --connector-tag 10.9.9 --output-dir /tmp/benchmark"
Sleep 800ms
Enter
Sleep 8s
# switching the plugin, the warm-up and the loading of the backlog take minutes: cut them
Hide
Wait+Screen@15m /10\.8\.4, CP/
Show
Sleep 12s
Hide
Wait@20m /❯\s*$/
Show
Sleep 14s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 3. reading the results ──────────────────────────────────────────────────
Type@15ms "# For each version: duration, records/s, put batch time, running ratio, connect CPU, GC pauses, and the setup"
Enter
Sleep 3s
Type@15ms "# 🛩️  a flight recording of the measure says where the task time went (Kafka, the database, converters, locks)"
Enter
Sleep 3s
Type@15ms "# 📊 the comparison table: records/s of each version and the difference with the first one"
Enter
Sleep 3s
Type@15ms "# ⚠️  'lower bound' = drained before the first sample: rerun with 10x --nb-records. Compare runs on the same machine only"
Enter
Sleep 3s
Type@15ms "# 💡 every run is kept in benchmark-history: the next run of the same connector says how it compares"
Enter
Sleep 3s
Type@15ms "# 💡 sources too (JDBC, Debezium, Oracle CDC, MongoDB, MQ...: the example ships a benchmark-load.bash), fully managed too"
Enter
Sleep 4s

# ── 4. the HTML report ──────────────────────────────────────────────────────
Type@15ms "# 🌐 The HTML report has the throughput over time of each version, side by side. Send it to the customer!"
Enter
Sleep 2s
Type "ls /tmp/benchmark/*.html"
Sleep 500ms
Enter
Sleep 3s
Type@15ms "# The comparison report looks like this 👇"
Enter
Sleep 2s
