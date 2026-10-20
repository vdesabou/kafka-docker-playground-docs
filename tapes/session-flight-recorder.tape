# 🎓 Bite size session: a slow connector, where does the task time go? Analyze a flight recording (narrated with comments typed in the terminal)
# the end of the session (a scroll through the HTML report) is added by scripts/generate-session-videos.sh
Output docs/videos/session-flight-recorder-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# ── 1. the symptom ──────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: the connector works, but it is slow => where does the time of its tasks go?"
Enter
Sleep 2s
Type@15ms "# Is it the database, the network, Kafka, a lock, the converters, or the connector code itself?"
Enter
Sleep 2s
Type@15ms "# Java Flight Recorder samples what every thread does, with almost no overhead: the answer, with numbers"
Enter
Sleep 3s

# ── 2. the 3 ways to run it ─────────────────────────────────────────────────
Type@15ms "# ① on a running example: records the worker over JMX for 60 s (no restart), focused on the tasks of a connector"
Enter
Type@15ms "#    playground analyze flight-recorder -c connect --duration 60s --connector <connector>"
Enter
Sleep 2s
Type@15ms "# ② on a recording from a customer: jcmd <pid> JFR.start duration=60s filename=rec.jfr, then"
Enter
Type@15ms "#    playground analyze flight-recorder -f rec.jfr"
Enter
Sleep 2s
Type@15ms "# ③ on a sample shipped with the playground: a JDBC PostgreSQL sink under load, try it now 👇"
Enter
Sleep 2s

Type "playground analyze flight-recorder --sample jdbc_postgres_sink --output-dir /tmp/flight-recorder | less -R"
Sleep 800ms
Enter

# ── 3. the digest ───────────────────────────────────────────────────────────
# page 1: findings, task thread time by state, CPU by layer
Sleep 16s
Type " "
# page 2: hot methods, network I/O, checked and normal
Sleep 10s
Type "q"
Sleep 500ms
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 4. what it found ────────────────────────────────────────────────────────
Type@15ms "# What it found:"
Enter
Sleep 1s
Type@15ms "# 🔴 the task threads spend 54% of their time blocked on network I/O to postgres:5432 => the database is the limit"
Enter
Sleep 3s
Type@15ms "#    not the connector code: look at the database latency and load, and at how the connector batches (batch.size)"
Enter
Sleep 3s
Type@15ms "# ℹ️  62% of the task CPU is in the converters (Avro), 11% in the connector itself: expected with large records"
Enter
Sleep 3s
Type@15ms "# ℹ️  876 MB/s allocated, mostly by AvroData.toConnectData: this is what keeps the GC busy"
Enter
Sleep 3s
Type@15ms "# ✅ checked and normal: Kafka client 10% of the time, lock contention 0%, GC pauses"
Enter
Sleep 3s
Type@15ms "# 💡 compare two versions or configs: playground connector benchmark records the workers the same way"
Enter
Sleep 4s

# ── 5. the HTML report ──────────────────────────────────────────────────────
Type@15ms "# 🌐 The HTML report has the charts: time by state, CPU by layer, hot methods, network calls. Send it to the customer!"
Enter
Sleep 2s
Type "ls /tmp/flight-recorder"
Sleep 500ms
Enter
Sleep 3s
Type@15ms "# It looks like this 👇"
Enter
Sleep 2s
