# 🎓 Bite size session: playground run, with the menu and without it (-f and flags), and its options (narrated with comments typed in the terminal)
# off camera (scripts/generate-session-videos.sh): an empty run history. The session runs the JDBC PostgreSQL sink example
# twice, the waits are cut
Output docs/videos/session-run-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# ── 1. the menu ─────────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: playground run, the one command that runs any of the 700+ examples"
Enter
Sleep 2s
Type@15ms "# Two ways: 'playground run' opens a menu that guides you, 'playground run -f <example.sh> <flags>' runs it directly"
Enter
Sleep 3s
Type@15ms "# The menu first: pick a category, type a few words to find the example, then look at its options"
Enter
Sleep 1s
Type "playground run"
Sleep 800ms
Enter
Wait+Screen@1m /select a category/
Sleep 3s
# 🔗 Connectors
Enter
Wait+Screen@1m /select example/
Sleep 2s
Type@120ms "jdbc postgres sink"
Sleep 2s
Enter
Wait+Screen@1m /select option\(s\)/
Sleep 4s
# from 🚀 at the bottom up to the actions at the top, group by group
Up@600ms 6
Sleep 2s
Up@500ms 9
Sleep 2s
Up@500ms 13
Sleep 2s
Up@500ms 7
Sleep 3s
# quit without running anything
Escape
Sleep 2s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 2. what is in the menu ──────────────────────────────────────────────────
Type@15ms "# What the menu showed, from the bottom:"
Enter
Sleep 1s
Type@15ms "#  🚀 run it, 📖 open its files, 🌐 its docs"
Enter
Sleep 2s
Type@15ms "#  🎯 versions: CP (--tag, or one component only), 🔌 connector (--connector-tag, --connector-zip, --connector-jar)"
Enter
Sleep 3s
Type@15ms "#  🔐 the security environment (plaintext, sasl-ssl, kerberos, rbac...)"
Enter
Sleep 2s
Type@15ms "#  [ ] add-ons, on/off: Control Center, ksqlDB, Grafana, kcat, Flink, more brokers or workers, a benchmark..."
Enter
Sleep 3s
Type@15ms "#  images & modes (community images, KRaft), connect log levels, and actions: switch example, create a repro model"
Enter
Sleep 3s
Type@15ms "# The right pane lists the flags picked so far, Esc quits without running or stopping anything"
Enter
Sleep 3s
Type@15ms "# In the CP and connector version pickers, the right pane shows what changed in the highlighted version 📜"
Enter
Sleep 3s
Type@15ms "# Now for real: CP 8.2.0, connector 10.8.12, Grafana + kcat (tab selects several), and one bad combination 👇"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 3. pick options and run ─────────────────────────────────────────────────
Type "playground run"
Sleep 800ms
Enter
Wait+Screen@1m /select a category/
Sleep 1s
Enter
Wait+Screen@1m /select example/
Sleep 1s
Type@80ms "jdbc postgres sink"
Sleep 1s
Enter
Wait+Screen@1m /select option\(s\)/
Sleep 2s
# typing filters the options too
Type@100ms "CP version (all"
Sleep 1500ms
Enter
Wait+Screen@1m /select cp version/
Sleep 2s
# the preview: the commits of the highlighted CP version, from the docs.confluent.io changelog feeds
Type@150ms "8.2."
Wait+Screen@30s /released:/
Sleep 4s
Up
Wait+Screen@30s /released:/
Sleep 3s
Ctrl+U
Type@150ms "8.2.0"
Wait+Screen@30s /🔢 8\.2\.0 -/
Sleep 3s
Enter
Wait+Screen@1m /--tag\s+\[8\.2\.0\]/
Sleep 3s
Type@100ms "connector version"
Sleep 1500ms
Enter
Wait+Screen@1m /select connector version/
Sleep 2s
# the preview: the release notes of the highlighted connector version
Wait+Screen@30s /🌐 changelog:/
Sleep 4s
Type@150ms "10.8.12"
Sleep 5s
Enter
Wait+Screen@1m /--connector-tag\s+\[10\.8\.12\]/
Sleep 3s
# two toggles at once: tab marks one, ctrl-u clears the query, tab marks the other
Type@100ms "grafana"
Sleep 1s
Tab
Sleep 500ms
Ctrl+U
Type@100ms "kcat"
Sleep 1s
Tab
Sleep 1s
Enter
Wait+Screen@1m /\[x\].*kcat/
Sleep 4s
# legacy Control Center does not exist for CP 8: the menu refuses to run
Type@100ms "legacy control"
Sleep 1500ms
Enter
Wait+Screen@1m /cannot be executed/
Sleep 7s
Type@100ms "legacy control"
Sleep 1500ms
Enter
Wait+Screen@1m /Run the example/
Sleep 3s
Type@100ms "run the example"
Sleep 1500ms
Enter
Wait+Screen@2m /Flags used are/
Sleep 8s
# the run takes a few minutes: cut it
Hide
Wait@20m /❯\s*$/
# the end of the run prints the release notes of the connector versions in one burst: let the terminal catch up
Sleep 10s
Show
Sleep 5s
Type@15ms "# ✅ RESULT: SUCCESS: environment started, connector created, records produced and checked (the wait is cut)"
Enter
Sleep 3s
Type@15ms "# Above: the last connector versions with their release notes, and the command to see all the changes since 10.8.12"
Enter
Sleep 3s
Type@15ms "# 📢 CP 8.2.0 is not the latest 8.2 patch: how many changes since (security ones counted), and how to update"
Enter
Sleep 3s
Type@15ms "# then the connector status, and the links to the example docs and to the connector source code"
Enter
Sleep 3s
Type@15ms "# The same run as a command, ready to paste, is in 'playground history' (and in the clipboard on macOS)"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 4. without the menu ─────────────────────────────────────────────────────
Type@15ms "# Without the menu: -f <example> and the same flags. For scripts, to share a run, to change one thing and run again"
Enter
Sleep 3s
Type@15ms "# (in your shell, <tab> after -f, --tag, --connector-tag... opens a picker: no path or version to remember)"
Enter
Sleep 3s
Type@15ms "# Bad combinations are refused before anything is stopped:"
Enter
Sleep 1s
Type "playground run -f $PWD/connect/connect-jdbc-postgresql-sink/postgres-sink.sh --tag 8.2.0 --enable-legacy-control-center"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 4s
Type@15ms "# ❌ in a second, and the environment that runs is untouched"
Enter
Sleep 3s
Type@15ms "# The same example under another security environment, with another connector version and DEBUG logs for the connector:"
Enter
Sleep 1s
Type "playground run -f $PWD/connect/connect-jdbc-postgresql-sink/postgres-sink.sh --environment sasl-ssl --connector-tag 10.8.4 --connect-log-level io.confluent.connect.jdbc=DEBUG"
Sleep 800ms
Enter
Wait+Screen@2m /Flags used are/
Sleep 8s
Hide
Wait@20m /❯\s*$/
Show
Sleep 5s
Type@15ms "# ✅ SASL_SSL everywhere (brokers, connect, clients), connector 10.8.4: nothing changed in the example script"
Enter
Sleep 4s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 5. recap ────────────────────────────────────────────────────────────────
Type@15ms "# 🧰 Next to playground run:"
Enter
Sleep 1s
Type@15ms "#   playground re-run                  ⚡ the last example again, same flags"
Enter
Sleep 2s
Type@15ms "#   playground history                 🏰 pick a previous run, edit its flags, run it"
Enter
Sleep 2s
Type@15ms "#   playground run -f <example> -o     📖 open the example and its docker-compose files first"
Enter
Sleep 2s
Type@15ms "#   playground secrets set <VAR>       🔐 store the credentials an example needs once (AWS, Salesforce...)"
Enter
Sleep 2s
Type@15ms "#   playground cp-changelog --from X   📜 what changed in Confluent Platform since X (--grep, --security)"
Enter
Sleep 2s
Type@15ms "#   playground run --help              every flag, with what it does"
Enter
Sleep 3s
Type@15ms "# 💡 the menu is the easiest way to discover the options: everything picked there is a flag to reuse with -f"
Enter
Sleep 6s
