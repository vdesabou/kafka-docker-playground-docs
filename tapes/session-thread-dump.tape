# 🎓 Bite size session: a connector looks stuck, analyze thread dumps (narrated with comments typed in the terminal)
# the end of the session (a scroll through the HTML report) is added by scripts/generate-session-videos.sh
Output docs/videos/session-thread-dump-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# ── 1. the symptom ──────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: a connector looks stuck => analyze thread dumps"
Enter
Sleep 2s
Type@15ms "# Symptom: the task is RUNNING, but no record moves, and there is no error in the logs"
Enter
Sleep 2s
Type@15ms "# A thread dump says what every thread of the JVM is doing right now"
Enter
Sleep 1500ms
Type@15ms "# Take 3 of them a few seconds apart: a thread on the same line in all 3 is stuck, not busy"
Enter
Sleep 3s

# ── 2. the 3 ways to run it ─────────────────────────────────────────────────
Type@15ms "# ① on a running example: takes 3 dumps 5s apart, and analyzes them"
Enter
Type@15ms "#    playground analyze thread-dump -c connect"
Enter
Sleep 2s
Type@15ms "# ② on dumps from a customer: one -f per dump of the same JVM"
Enter
Type@15ms "#    playground analyze thread-dump -f dump1.txt -f dump2.txt -f dump3.txt"
Enter
Sleep 2s
Type@15ms "# ③ on a sample shipped with the playground: nothing to install, try it now 👇"
Enter
Sleep 2s

Type "playground analyze thread-dump --sample deadlock_jdk21 --output-dir /tmp/thread-dump | less -R"
Sleep 800ms
Enter

# ── 3. the digest, page by page ─────────────────────────────────────────────
# page 1: dumps, threads per dump, findings (most severe first)
Sleep 14s
Type " "
# page 2: deadlock, lock contention, same frames in all dumps
Sleep 9s
Type " "
# page 3: CPU between the dumps, Kafka Connect tasks, thread pools
Sleep 9s
Type "q"
Sleep 500ms
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 4. what it found ────────────────────────────────────────────────────────
Type@15ms "# What it found, most severe first:"
Enter
Sleep 1s
Type@15ms "# 🔴 CRITICAL  deadlock-1 <-> deadlock-2: each one waits for a lock held by the other => only a restart frees them"
Enter
Sleep 3s
Type@15ms "# 🟠 HIGH      8 threads BLOCKED on one lock, held by a thread that sleeps => contention, not a bug in the 8"
Enter
Sleep 3s
Type@15ms "# 🟠 HIGH      task my-sink-connector-0 is RUNNABLE on the same frame in the 3 dumps, with 0% CPU => STUCK (I/O, remote call)"
Enter
Sleep 3s
Type@15ms "# 🟠 HIGH      cpu-burner used 99.7% of a CPU between the dumps => the hot loop to look at"
Enter
Sleep 3s
Type@15ms "# 🟡 MEDIUM    a thread pool grows 14, 24, 34: threads created and never stopped (client not closed)"
Enter
Sleep 4s
Type@15ms "# 💡 the stuck frame says where to look: the connector code at that line, or the remote system it calls"
Enter
Sleep 3s
Type@15ms "# 🔗 the code at the customer version: playground connector-plugin sourcecode --connector-tag <version>"
Enter
Sleep 4s

# ── 5. the HTML report ──────────────────────────────────────────────────────
Type@15ms "# 🌐 The same analysis is in an HTML report: charts, findings, every stack (expand them). Send it to the customer!"
Enter
Sleep 2s
Type "ls /tmp/thread-dump"
Sleep 500ms
Enter
Sleep 3s
Type@15ms "# It looks like this 👇"
Enter
Sleep 2s
