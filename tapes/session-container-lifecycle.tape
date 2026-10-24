# 🎓 Bite size session: restart vs recreate, an environment variable and another JDK in the connect container: what each command keeps (narrated with comments typed in the terminal)
# the commands that print a lot are piped to grep: the vhs terminal (ttyd flow control) stops updating after a burst of
# a few dozen lines
# off camera (scripts/generate-session-videos.sh): the JDBC PostgreSQL sink example (connector postgres-sink). The JDK
# install (change-jdk downloads Azul Zulu 17 in the container) and the recreations are cut
Output docs/videos/session-container-lifecycle-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# ── 1. the customer's worker ────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: the customer says 'it only fails on our workers: Java 17, and KAFKA_HEAP_OPTS=-Xms1G -Xmx2G'"
Enter
Sleep 2s
Type@15ms "# Let's build that worker on the running example (JDBC PostgreSQL sink), and see what each container command keeps"
Enter
Sleep 2s
Type@15ms "# exec runs one command inside the container, as the image user (appuser), with the container name resolved for you"
Enter
Sleep 1s
Type "playground container exec -c connect --command 'java -version 2>&1 | head -1'"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 4s
Type@15ms "# the JDK of the image: Java 25 with CP 8.3. The customer runs 17 👇"
Enter
Sleep 2s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 2. change-jdk ───────────────────────────────────────────────────────────
Type@15ms "# change-jdk installs Azul Zulu 17 as root inside the container (yum), selects it, then restarts connect"
Enter
Sleep 2s
Type "playground container change-jdk -c connect --version 17 2>&1 | grep -E --line-buffered 'Installing Azul|Restarting|openjdk version'"
Sleep 800ms
Enter
Sleep 5s
# the download and the install take a few minutes: cut them
Hide
Wait@15m /❯\s*$/
Show
Sleep 5s
Type@15ms "# ✅ openjdk 17. ⚠️  It lives in the container, not in the image: only some commands keep it"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 3. restart vs recreate ──────────────────────────────────────────────────
Type@15ms "# ① restart = docker restart: the same container stops and starts again (connect: it waits for the REST API)"
Enter
Sleep 2s
Type "playground container restart -c connect > /dev/null 2>&1; playground container exec -c connect --command 'java -version 2>&1 | head -1'"
Sleep 800ms
Enter
Sleep 3s
Hide
Wait@5m /❯\s*$/
Show
Sleep 4s
Type@15ms "# still 17: restart keeps the files, the installed packages and the logs (network rules of debug block-traffic are lost)"
Enter
Sleep 3s
Type@15ms "# ② recreate replays the docker compose command of the example with 'up -d'"
Enter
Sleep 1s
Type "playground container recreate 2>&1 | grep -E 'Container connect '; playground container exec -c connect --command 'java -version 2>&1 | head -1'"
Sleep 800ms
Enter
Sleep 3s
Hide
Wait@5m /❯\s*$/
Show
Sleep 5s
Type@15ms "# 'Container connect Running': the definition did not change, so docker compose did nothing. Still 17"
Enter
Sleep 3s
Type@15ms "# => recreate alone is NOT a way to get a clean container: it only rebuilds containers whose definition changed"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 4. an environment variable ──────────────────────────────────────────────
Type@15ms "# ③ now the customer's heap: set-environment-variables (compose syntax 'NAME: value', not NAME=value)"
Enter
Sleep 2s
Type 'playground container set-environment-variables -c connect --env "KAFKA_HEAP_OPTS: -Xms1G -Xmx2G" 2>&1 | grep -E "enabling containers|Container connect "'
Sleep 800ms
Enter
Sleep 5s
Hide
Wait@5m /❯\s*$/
Show
Sleep 4s
Type@15ms "# 'Recreate': a temporary compose override with the variable, so a NEW container is built from the definition"
Enter
Sleep 2s
Type `playground container exec -c connect --command 'echo "KAFKA_HEAP_OPTS=$KAFKA_HEAP_OPTS"; java -version 2>&1 | head -1'`
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 5s
Type@15ms "# the heap options are there... and Java 17 is gone: a new container loses what was done inside (JDK, copied files, logs)"
Enter
Sleep 3s
Type@15ms "# 💡 the right order: environment variables first (they recreate), then change-jdk, cp, degrade-traffic"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 5. and the next recreate ────────────────────────────────────────────────
Type@15ms "# ④ one more recreate: it replays the original command, without the override"
Enter
Sleep 1s
Type `playground container recreate 2>&1 | grep -E 'Container connect '; playground container exec -c connect --command 'echo "KAFKA_HEAP_OPTS=$KAFKA_HEAP_OPTS"'`
Sleep 800ms
Enter
Sleep 3s
Hide
Wait@5m /❯\s*$/
Show
Sleep 5s
Type@15ms "# this time the definition changed: connect is rebuilt, and the variable is empty again"
Enter
Sleep 2s
Type@15ms "# the connector does not care: its config and offsets live in Kafka topics, it comes back on its own"
Enter
Sleep 1s
Type "playground connector wait --connector postgres-sink --max-wait 120 2>&1 | grep 'is RUNNING'"
Sleep 800ms
Enter
Wait@3m /❯\s*$/
Sleep 4s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 6. recap ────────────────────────────────────────────────────────────────
Type@15ms "# 🧰 What each command keeps:"
Enter
Sleep 1s
Type@15ms "#   container restart                      same container: files, JDK, logs kept (network rules lost)"
Enter
Sleep 2s
Type@15ms "#   container kill + recreate              a crash (Exited 137 in playground status), then the same container again"
Enter
Sleep 2s
Type@15ms "#   container recreate                     rebuilds only what changed in the definition"
Enter
Sleep 2s
Type@15ms "#   container set-environment-variables    a new container with your variables, undone by the next recreate"
Enter
Sleep 2s
Type@15ms "#   container change-jdk                   8, 11, 17, 21, 22 or 25, kept by restart, lost by a new container"
Enter
Sleep 3s
Type@15ms "# 💡 in a repro model, put the customer's variables in the compose override (playground repro bootstrap): it survives every recreate"
Enter
Sleep 6s
