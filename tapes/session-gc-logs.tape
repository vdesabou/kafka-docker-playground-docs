# 🎓 Bite size session: long GC pauses or a memory leak, analyze GC logs (narrated with comments typed in the terminal)
# the end of the session (a scroll through the HTML report) is added by scripts/generate-session-videos.sh
Output docs/videos/session-gc-logs-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# ── 1. the symptom ──────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: the worker freezes, tasks get rebalanced, the heap keeps growing => analyze GC logs"
Enter
Sleep 2s
Type@15ms "# Every GC pause stops all the threads of the JVM: long or frequent pauses look like a slow or stuck connector"
Enter
Sleep 2s
Type@15ms "# The GC log says how long each pause was, why it happened, and how full the heap was before and after"
Enter
Sleep 3s

# ── 2. the 3 ways to run it ─────────────────────────────────────────────────
Type@15ms "# ① on a running example: reads the GC log of the container"
Enter
Type@15ms "#    playground analyze gc-logs -c connect"
Enter
Sleep 2s
Type@15ms "# ② on GC logs from a customer (a file, or a folder of rotated logs), JDK 7 to 21, any collector"
Enter
Type@15ms "#    playground analyze gc-logs -f gc.log"
Enter
Sleep 2s
Type@15ms "# ③ on a sample shipped with the playground: a JDK 21 G1 log of a Kafka JVM, try it now 👇"
Enter
Sleep 2s

Type "playground analyze gc-logs --sample jdk21_g1_kafka_real --output-dir /tmp/gc-logs | less -R"
Sleep 800ms
Enter

# ── 3. the digest, page by page ─────────────────────────────────────────────
# page 1: JDK / collector / heap, health score, summary, pause times and distribution, heap
Sleep 14s
Type " "
# page 2: GC causes, GC types, longest pauses, recommendations
Sleep 12s
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
Type@15ms "# 🟢 health 87/100, all 57 pauses under 10 ms (max 3.25 ms) => the pauses themselves are not the problem here"
Enter
Sleep 3s
Type@15ms "# 🟠 HIGH    4 evacuation failures: G1 had no free region to copy live objects to => the heap is too tight"
Enter
Sleep 3s
Type@15ms "# 🟡 MEDIUM  live set 162 MB = 63% of -Xmx 256m: keep it under half of the heap so the collector has room to work"
Enter
Sleep 3s
Type@15ms "# 👉 each recommendation comes with the JVM flag to try: -Xms512m -Xmx512m, -XX:G1ReservePercent=20"
Enter
Sleep 3s
Type@15ms "# 💡 a heap floor that keeps rising over hours = a leak: then take a heap dump, playground analyze heap-dump -f <.hprof>"
Enter
Sleep 4s

# ── 5. the HTML report ──────────────────────────────────────────────────────
Type@15ms "# 🌐 The HTML report has the charts: pause timeline, heap before / after GC, pause distribution. Send it to the customer!"
Enter
Sleep 2s
Type "ls /tmp/gc-logs"
Sleep 500ms
Enter
Sleep 3s
Type@15ms "# It looks like this 👇"
Enter
Sleep 2s
