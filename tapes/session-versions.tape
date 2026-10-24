# 🎓 Bite size session: another connector version, a build from engineering, another Connect version, on the example that runs (update-version, connector versions) (narrated with comments typed in the terminal)
# the commands that print a lot are piped to grep: the vhs terminal (ttyd flow control) stops updating after a burst of
# a few dozen lines
# off camera (scripts/generate-session-videos.sh): the JDBC PostgreSQL sink example run with the customer's versions
# (--tag 8.2.0 --connector-tag 10.8.4, 2 rows in the table orders), the avro schema of its topic orders in
# /tmp/orders.avsc, and the 10.9.9 zip of the connector from Confluent Hub in /tmp/engineering-build (it plays the build
# sent by engineering). The waits of update-version are cut
Output docs/videos/session-versions-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# ── 1. the customer's versions ──────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: the customer runs the JDBC sink 10.8.4 on CP 8.2.0. Is it fixed in a newer connector? A newer worker?"
Enter
Sleep 2s
Type@15ms "# The example runs with their versions (off camera: playground run -f .../postgres-sink.sh --tag 8.2.0 --connector-tag 10.8.4)"
Enter
Sleep 2s
Type@15ms "# What runs exactly, and what is the latest on Confluent Hub?"
Enter
Sleep 1s
Type "playground connector versions 2> /dev/null"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 7s
Type@15ms "# CP 8.2.0, connector v10.8.4 'is not latest': v10.9.9 is the latest on Confluent Hub (the last 5 versions above)"
Enter
Sleep 3s
Type@15ms "# playground run with other flags would start everything again. update-version swaps versions on the example that runs 👇"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 2. another connector version ────────────────────────────────────────────
Type@15ms "# ① the latest patch of their 10.8 line: --connector-tag. The plugin is installed again, then connect is restarted"
Enter
Sleep 2s
Type "playground update-version --connector-tag 10.8.12 2>&1 | grep -E --line-buffered 'Loading new version|Installing connector|Restarting docker|currently used for confluentinc|v10.8.12 -'"
Sleep 800ms
Enter
Sleep 5s
# the install and the restart of connect take a minute or two: cut them
Hide
Wait@15m /❯\s*$/
Show
Sleep 5s
Type@15ms "# 10.8.12 is loaded (the connector versions printed at the end). The connector itself was not touched:"
Enter
Sleep 1s
Type "playground connector wait --connector postgres-sink --max-wait 120 2>&1 | grep 'is RUNNING'"
Sleep 800ms
Enter
Wait@3m /❯\s*$/
Sleep 3s
Type@15ms "# the example script is NOT run again: same topics, same data, same connector config, only the plugin changed"
Enter
Sleep 3s
Type@15ms "# => a bisect tool: call it once per candidate version, and replay the symptom each time"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 3. a build from engineering ─────────────────────────────────────────────
Type@15ms "# ② engineering sends a build: --connector-zip installs the whole plugin (--connector-jar replaces one jar of the installed one)"
Enter
Sleep 2s
Type@15ms "# (for this video, the 10.9.9 zip downloaded from Confluent Hub plays the build)"
Enter
Sleep 1s
Type "playground update-version --connector-zip /tmp/engineering-build/confluentinc-kafka-connect-jdbc-10.9.9.zip 2>&1 | grep -E --line-buffered 'Loading new version|CONNECTOR_ZIP|Installing connector|Restarting docker|currently used for confluentinc'"
Sleep 800ms
Enter
Sleep 5s
Hide
Wait@15m /❯\s*$/
Show
Sleep 5s
Type@15ms "# installed from the zip, and connector versions reads its manifest: 10.9.9, the latest. Does it write? One more record:"
Enter
Sleep 1s
Type "playground topic produce -t orders --nb-messages 1 < /tmp/orders.avsc > /dev/null 2>&1"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 1s
Type `sleep 8; echo "rows in orders: $(playground container exec -c postgres --command "psql -U myuser -d postgres -t -A -c 'SELECT count(*) FROM orders'" 2>/dev/null | tail -1)"`
Sleep 800ms
Enter
Wait+Screen@1m /rows in orders: [0-9]/
Sleep 4s
Type@15ms "# 3 rows: the 2 written by 10.8.4 when the example ran, and the new one, written by the build"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 4. another Connect version ──────────────────────────────────────────────
Type@15ms "# ③ and the worker? --tag changes every CP component, --connect-tag only connect (a Connect cluster older or newer than the brokers)"
Enter
Sleep 2s
Type@15ms "# connect on 8.3.2, the brokers stay on 8.2.0:"
Enter
Sleep 1s
Type "playground update-version --connect-tag 8.3.2 2>&1 | grep -E --line-buffered 'Loading new version|Detected confluent|Container (broker|connect) +Recreate'"
Sleep 800ms
Enter
Sleep 5s
Hide
Wait@15m /❯\s*$/
Show
Sleep 4s
Type "playground status 2>&1 | grep -E '^(NAMES|broker|connect|schema-registry) '"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 5s
Type@15ms "# only connect was recreated: cp-server-connect:8.3.2, broker and schema-registry still on 8.2.0"
Enter
Sleep 3s
Type@15ms "# (update-version --tag 8.3.2 would move them all; a flag equal to the running version is ignored)"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 5. recap ────────────────────────────────────────────────────────────────
Type@15ms "# 🧰 Versions of the example that runs:"
Enter
Sleep 1s
Type@15ms "#   playground connector versions                    what runs (CP, connector) and the latest on Confluent Hub"
Enter
Sleep 2s
Type@15ms "#   playground update-version --connector-tag X      another connector version (A,B for an example with two connectors)"
Enter
Sleep 2s
Type@15ms "#   playground update-version --connector-zip|jar    a build: the whole plugin, or one jar of the installed plugin"
Enter
Sleep 2s
Type@15ms "#   playground update-version --tag X|--connect-tag X  every CP component, or connect only"
Enter
Sleep 2s
Type@15ms "#   playground update-version                        no flag: a menu with the versions running now"
Enter
Sleep 3s
Type@15ms "# ⚠️  update-version writes nothing to the history: a re-run goes back to the flags of the last playground run"
Enter
Sleep 3s
Type@15ms "# 💡 it changes containers, not the scenario: when the config or the data of the example depend on the version, playground run again"
Enter
Sleep 6s
